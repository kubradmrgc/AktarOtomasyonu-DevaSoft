using System;
using System.Collections.Generic;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Windows.Forms;
using AktarOtomasyon.Forms.Base;
using AktarOtomasyon.Forms.Common;
using AktarOtomasyon.Forms.Managers;
using AktarOtomasyon.Stok.Interface;
using AktarOtomasyon.Urun.Interface.Models;
using DevExpress.XtraEditors;
using DevExpress.XtraGrid;
using DevExpress.XtraGrid.Columns;
using DevExpress.XtraGrid.Views.Base;
using DevExpress.XtraGrid.Views.Grid;
using DevExpress.Utils;

namespace AktarOtomasyon.Forms.Screens.Stok
{
    /// <summary>
    /// Ürünler ve Stok Yönetimi paneli (URUN_STOK).
    /// Sol: ürün/stok grid — Sağ: seçili ürün detayı + hızlı stok hareketi.
    /// </summary>
    public partial class UcUrunStok : UcBase
    {
        private List<StokUrunListeDto> _allItems = new List<StokUrunListeDto>();
        private StokUrunListeDto _selected;
        private string _hareketTip = "GIRIS";
        private int? _filterKategoriId;
        private bool _filterKritikOnly;
        private readonly List<SimpleButton> _chipButtons = new List<SimpleButton>();

        private PanelControl pnlRoot;
        private LabelControl lblTitle;
        private LabelControl lblSubtitle;
        private SimpleButton btnStokSayimi;
        private SimpleButton btnYeniUrun;
        private TextEdit txtArama;
        private FlowLayoutPanel flpChips;
        private SplitContainerControl splitMain;
        private GridControl grdUrunler;
        private GridView gvUrunler;
        private LabelControl lblFooter;
        private LabelControl lblDetayKod;
        private LabelControl lblDetayAd;
        private LabelControl lblDetayDurum;
        private LabelControl lblMevcut;
        private LabelControl lblKritik;
        private LabelControl lblBirim;
        private LabelControl lblKategori;
        private SimpleButton btnGiris;
        private SimpleButton btnCikis;
        private TextEdit txtMiktar;
        private TextEdit txtAciklama;
        private SimpleButton btnKaydet;
        private SimpleButton btnSiparis;

        public UcUrunStok()
        {
            InitializeComponent();
            BuildUi();
            WireEvents();
            ApplyTheme();
        }

        #region UI Build

        private void BuildUi()
        {
            pnlRoot = new PanelControl
            {
                Dock = DockStyle.Fill,
                BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.NoBorder,
                Padding = new Padding(20)
            };
            Controls.Add(pnlRoot);

            // Header
            var pnlHeader = new PanelControl
            {
                Dock = DockStyle.Top,
                Height = 72,
                BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.NoBorder,
                Padding = new Padding(0, 0, 0, 8)
            };

            lblTitle = new LabelControl
            {
                Text = "Ürünler ve Stok Yönetimi",
                Location = new Point(0, 4),
                AutoSizeMode = LabelAutoSizeMode.None,
                Size = new Size(520, 28)
            };
            lblSubtitle = new LabelControl
            {
                Text = "Stok durumu yükleniyor…",
                Location = new Point(0, 34),
                AutoSizeMode = LabelAutoSizeMode.None,
                Size = new Size(620, 20)
            };

            btnYeniUrun = new SimpleButton
            {
                Text = "Yeni Ürün Ekle  F3",
                Size = new Size(160, 36),
                Anchor = AnchorStyles.Top | AnchorStyles.Right
            };
            btnStokSayimi = new SimpleButton
            {
                Text = "Stok Hareketleri",
                Size = new Size(140, 36),
                Anchor = AnchorStyles.Top | AnchorStyles.Right
            };

            pnlHeader.Controls.Add(lblTitle);
            pnlHeader.Controls.Add(lblSubtitle);
            pnlHeader.Controls.Add(btnStokSayimi);
            pnlHeader.Controls.Add(btnYeniUrun);
            pnlHeader.Resize += (s, e) =>
            {
                btnYeniUrun.Location = new Point(pnlHeader.Width - btnYeniUrun.Width - 4, 16);
                btnStokSayimi.Location = new Point(btnYeniUrun.Left - btnStokSayimi.Width - 8, 16);
            };

            // Filter strip
            var pnlFilter = new PanelControl
            {
                Dock = DockStyle.Top,
                Height = 64,
                BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.Simple,
                Padding = new Padding(10)
            };

            txtArama = new TextEdit
            {
                Location = new Point(12, 16),
                Size = new Size(280, 28)
            };
            txtArama.Properties.NullValuePrompt = "Barkod, stok kodu veya ürün adı ara…";
            txtArama.Properties.NullValuePromptShowForEmptyValue = true;

            flpChips = new FlowLayoutPanel
            {
                Location = new Point(310, 12),
                Size = new Size(740, 40),
                Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right,
                WrapContents = false,
                AutoScroll = true
            };

            pnlFilter.Controls.Add(txtArama);
            pnlFilter.Controls.Add(flpChips);

            // Split: list (left) + detail (right)
            splitMain = new SplitContainerControl
            {
                Dock = DockStyle.Fill,
                Horizontal = false, // sol liste + sağ detay
                SplitterPosition = 720
            };
            splitMain.Panel1.MinSize = 420;
            splitMain.Panel2.MinSize = 280;

            BuildListPanel(splitMain.Panel1);
            BuildDetailPanel(splitMain.Panel2);

            // Dock order: Fill first, then Top
            pnlRoot.Controls.Add(splitMain);
            pnlRoot.Controls.Add(pnlFilter);
            pnlRoot.Controls.Add(pnlHeader);
        }

        private void BuildListPanel(Control panel)
        {
            var card = new PanelControl
            {
                Dock = DockStyle.Fill,
                BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.Simple,
                Padding = new Padding(0)
            };

            var hdr = new PanelControl
            {
                Dock = DockStyle.Top,
                Height = 42,
                BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.NoBorder,
                Padding = new Padding(12, 10, 12, 8)
            };
            var lblListTitle = new LabelControl
            {
                Text = "Ürün ve Stok Listesi",
                Dock = DockStyle.Left,
                AutoSizeMode = LabelAutoSizeMode.Horizontal
            };
            var lblHint = new LabelControl
            {
                Text = "Satır seçerek hızlı stok güncelleyin",
                Dock = DockStyle.Right,
                AutoSizeMode = LabelAutoSizeMode.Horizontal
            };
            hdr.Controls.Add(lblHint);
            hdr.Controls.Add(lblListTitle);

            var footer = new PanelControl
            {
                Dock = DockStyle.Bottom,
                Height = 36,
                BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.NoBorder,
                Padding = new Padding(12, 8, 12, 8)
            };
            lblFooter = new LabelControl
            {
                Text = "Gösterilen: 0 kayıt",
                Dock = DockStyle.Fill,
                AutoSizeMode = LabelAutoSizeMode.None
            };
            footer.Controls.Add(lblFooter);

            grdUrunler = new GridControl { Dock = DockStyle.Fill };
            gvUrunler = new GridView(grdUrunler);
            grdUrunler.MainView = gvUrunler;
            grdUrunler.ViewCollection.Add(gvUrunler);

            gvUrunler.OptionsBehavior.Editable = false;
            gvUrunler.OptionsSelection.EnableAppearanceFocusedCell = false;
            gvUrunler.FocusRectStyle = DrawFocusRectStyle.RowFocus;
            gvUrunler.OptionsView.ShowIndicator = false;
            gvUrunler.OptionsView.ShowGroupPanel = false;
            gvUrunler.OptionsView.ShowVerticalLines = DefaultBoolean.False;
            gvUrunler.RowHeight = 36;

            gvUrunler.Columns.AddRange(new[]
            {
                Col("UrunKod", "Kod", 90),
                Col("UrunAdi", "Ürün Adı", 180),
                Col("KategoriAdi", "Kategori", 110),
                Col("MevcutStokText", "Mevcut", 90, HorzAlignment.Far),
                Col("FiyatText", "Fiyat", 80, HorzAlignment.Far),
                Col("Durum", "Durum", 80, HorzAlignment.Center)
            });

            card.Controls.Add(grdUrunler);
            card.Controls.Add(footer);
            card.Controls.Add(hdr);
            panel.Controls.Add(card);
        }

        private static GridColumn Col(string field, string caption, int width, HorzAlignment align = HorzAlignment.Near)
        {
            return new GridColumn
            {
                FieldName = field,
                Caption = caption,
                Visible = true,
                Width = width,
                AppearanceCell = { TextOptions = { HAlignment = align } },
                AppearanceHeader = { TextOptions = { HAlignment = align } }
            };
        }

        private void BuildDetailPanel(Control panel)
        {
            var card = new PanelControl
            {
                Dock = DockStyle.Fill,
                BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.Simple,
                Padding = new Padding(16)
            };

            lblDetayKod = new LabelControl
            {
                Location = new Point(16, 16),
                AutoSizeMode = LabelAutoSizeMode.None,
                Size = new Size(260, 18),
                Text = "—"
            };
            lblDetayAd = new LabelControl
            {
                Location = new Point(16, 36),
                AutoSizeMode = LabelAutoSizeMode.None,
                Size = new Size(200, 24),
                Text = "Ürün seçin"
            };
            lblDetayDurum = new LabelControl
            {
                Location = new Point(210, 36),
                AutoSizeMode = LabelAutoSizeMode.None,
                Size = new Size(90, 22),
                Text = "",
                Appearance = { TextOptions = { HAlignment = HorzAlignment.Center } }
            };

            var infoBox = new PanelControl
            {
                Location = new Point(16, 72),
                Size = new Size(280, 110),
                Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right,
                BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.Simple,
                Padding = new Padding(10)
            };

            lblMevcut = MakeInfoLabel(infoBox, "Mevcut Miktar", "—", 8, 8);
            lblKritik = MakeInfoLabel(infoBox, "Kritik Eşik", "—", 148, 8);
            lblBirim = MakeInfoLabel(infoBox, "Birim", "—", 8, 58);
            lblKategori = MakeInfoLabel(infoBox, "Kategori", "—", 148, 58);

            var lblHizli = new LabelControl
            {
                Text = "Hızlı Stok Güncelleme",
                Location = new Point(16, 196),
                AutoSizeMode = LabelAutoSizeMode.Horizontal
            };

            btnGiris = new SimpleButton
            {
                Text = "Stok Girişi (+)",
                Location = new Point(16, 222),
                Size = new Size(136, 30)
            };
            btnCikis = new SimpleButton
            {
                Text = "Fire / Çıkış (-)",
                Location = new Point(160, 222),
                Size = new Size(136, 30)
            };

            var lblMiktar = new LabelControl { Text = "Miktar", Location = new Point(16, 264) };
            txtMiktar = new TextEdit
            {
                Location = new Point(16, 284),
                Size = new Size(280, 28),
                Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right,
                Text = "1"
            };

            var lblNot = new LabelControl { Text = "İşlem Açıklaması", Location = new Point(16, 322) };
            txtAciklama = new TextEdit
            {
                Location = new Point(16, 342),
                Size = new Size(280, 28),
                Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right
            };

            btnKaydet = new SimpleButton
            {
                Text = "Stok Hareketini Kaydet",
                Location = new Point(16, 400),
                Size = new Size(280, 40),
                Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right
            };
            btnSiparis = new SimpleButton
            {
                Text = "Tedarik Siparişi Oluştur",
                Location = new Point(16, 450),
                Size = new Size(280, 36),
                Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right
            };

            card.Controls.AddRange(new Control[]
            {
                lblDetayKod, lblDetayAd, lblDetayDurum, infoBox, lblHizli,
                btnGiris, btnCikis, lblMiktar, txtMiktar, lblNot, txtAciklama,
                btnKaydet, btnSiparis
            });

            card.Resize += (s, e) =>
            {
                int w = Math.Max(200, card.Width - 40);
                infoBox.Width = w;
                txtMiktar.Width = w;
                txtAciklama.Width = w;
                btnKaydet.Width = w;
                btnSiparis.Width = w;
                btnCikis.Left = 16 + w / 2 + 4;
                btnGiris.Width = w / 2 - 4;
                btnCikis.Width = w / 2 - 4;
            };

            panel.Controls.Add(card);
            SetHareketTip("GIRIS");
            ClearDetail();
        }

        private LabelControl MakeInfoLabel(Control parent, string title, string value, int x, int y)
        {
            var t = new LabelControl
            {
                Text = title,
                Location = new Point(x, y),
                AutoSizeMode = LabelAutoSizeMode.None,
                Size = new Size(120, 16)
            };
            t.Appearance.ForeColor = ModernTheme.Colors.TextSecondary;
            t.Appearance.Font = ModernTheme.Typography.Caption;
            t.Appearance.Options.UseForeColor = true;
            t.Appearance.Options.UseFont = true;

            var v = new LabelControl
            {
                Text = value,
                Location = new Point(x, y + 18),
                AutoSizeMode = LabelAutoSizeMode.None,
                Size = new Size(120, 22),
                Tag = title
            };
            v.Appearance.Font = ModernTheme.Typography.H5;
            v.Appearance.Options.UseFont = true;

            parent.Controls.Add(t);
            parent.Controls.Add(v);
            return v;
        }

        #endregion

        #region Theme / Events

        private void ApplyTheme()
        {
            BackColor = ModernTheme.Colors.Background;
            pnlRoot.Appearance.BackColor = ModernTheme.Colors.Background;
            pnlRoot.Appearance.Options.UseBackColor = true;

            lblTitle.Appearance.Font = ModernTheme.Typography.H3;
            lblTitle.Appearance.ForeColor = ModernTheme.Colors.TextPrimary;
            lblTitle.Appearance.Options.UseFont = true;
            lblTitle.Appearance.Options.UseForeColor = true;

            lblSubtitle.Appearance.Font = ModernTheme.Typography.Body;
            lblSubtitle.Appearance.ForeColor = ModernTheme.Colors.TextSecondary;
            lblSubtitle.Appearance.Options.UseFont = true;
            lblSubtitle.Appearance.Options.UseForeColor = true;

            ModernTheme.ApplyModernButton(btnYeniUrun, ModernTheme.Colors.Primary, true);
            ModernTheme.ApplyModernButton(btnStokSayimi, ModernTheme.Colors.Surface, false);
            btnStokSayimi.Appearance.ForeColor = ModernTheme.Colors.Primary;
            btnStokSayimi.Appearance.BorderColor = ModernTheme.Colors.Border;
            btnStokSayimi.Appearance.Options.UseBorderColor = true;
            btnStokSayimi.Appearance.Options.UseForeColor = true;

            ModernTheme.ApplyModernButton(btnKaydet, ModernTheme.Colors.Primary, true);
            ModernTheme.ApplyModernButton(btnSiparis, ModernTheme.Colors.TerracottaSoft, false);
            btnSiparis.Appearance.ForeColor = ModernTheme.Colors.OnTerracottaSoft;
            btnSiparis.Appearance.Options.UseForeColor = true;

            ModernTheme.ApplyModernGrid(gvUrunler);
            gvUrunler.Appearance.FocusedRow.BackColor = Color.FromArgb(0xE4, 0xEF, 0xE9);
            gvUrunler.Appearance.FocusedRow.ForeColor = ModernTheme.Colors.TextPrimary;
            gvUrunler.Appearance.SelectedRow.BackColor = Color.FromArgb(0xE4, 0xEF, 0xE9);
            gvUrunler.Appearance.SelectedRow.ForeColor = ModernTheme.Colors.TextPrimary;

            lblDetayAd.Appearance.Font = ModernTheme.Typography.H4;
            lblDetayAd.Appearance.ForeColor = ModernTheme.Colors.TextPrimary;
            lblDetayAd.Appearance.Options.UseFont = true;
            lblDetayAd.Appearance.Options.UseForeColor = true;

            lblDetayKod.Appearance.Font = ModernTheme.Typography.Caption;
            lblDetayKod.Appearance.ForeColor = ModernTheme.Colors.Primary;
            lblDetayKod.Appearance.Options.UseFont = true;
            lblDetayKod.Appearance.Options.UseForeColor = true;
        }

        private void WireEvents()
        {
            btnYeniUrun.Click += (s, e) => OpenYeniUrun();
            btnStokSayimi.Click += (s, e) =>
            {
                var frm = FindForm();
                if (frm != null && frm.MdiParent != null)
                    NavigationManager.OpenScreen("STOK_HAREKET", frm.MdiParent);
            };

            txtArama.KeyDown += (s, e) =>
            {
                if (e.KeyCode == Keys.Enter)
                {
                    ApplyFilter();
                    e.Handled = true;
                }
            };
            txtArama.EditValueChanged += (s, e) =>
            {
                // debounce-lite: filter on leave or Enter; also filter after short idle via timer not needed
            };

            gvUrunler.FocusedRowChanged += gvUrunler_FocusedRowChanged;
            gvUrunler.CustomDrawCell += gvUrunler_CustomDrawCell;
            gvUrunler.DoubleClick += (s, e) => OpenUrunKart();

            btnGiris.Click += (s, e) => SetHareketTip("GIRIS");
            btnCikis.Click += (s, e) => SetHareketTip("CIKIS");
            btnKaydet.Click += (s, e) => KaydetHareket();
            btnSiparis.Click += (s, e) => OpenSiparisTaslak();
        }

        protected override bool ProcessCmdKey(ref Message msg, Keys keyData)
        {
            if (keyData == Keys.F3)
            {
                OpenYeniUrun();
                return true;
            }
            return base.ProcessCmdKey(ref msg, keyData);
        }

        #endregion

        #region Data

        public override void LoadData()
        {
            try
            {
                BuildCategoryChips();
                RefreshList();
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage("UcUrunStok.LoadData: " + ex.Message, "URUN_STOK");
                MessageHelper.ShowError("Stok paneli yüklenirken hata: " + ex.Message);
            }
        }

        private void BuildCategoryChips()
        {
            flpChips.Controls.Clear();
            _chipButtons.Clear();

            var kategoriler = UrunLookupProvider.GetKategoriler() ?? new List<UrunKategoriDto>();
            AddChip("Tümü", null, false, true);

            foreach (var k in kategoriler.Take(8))
            {
                var ad = TextHelper.FixEncoding(k.KategoriAdi);
                AddChip(ad, k.KategoriId, false, false);
            }

            AddChip("Kritik Stok", null, true, false);
        }

        private void AddChip(string text, int? kategoriId, bool kritikOnly, bool selected)
        {
            var btn = new SimpleButton
            {
                Text = text,
                Height = 28,
                Width = Math.Max(80, 12 + text.Length * 8),
                MinimumSize = new Size(70, 28),
                Tag = new ChipTag { KategoriId = kategoriId, KritikOnly = kritikOnly }
            };
            StyleChip(btn, selected, kritikOnly);
            btn.Click += Chip_Click;
            _chipButtons.Add(btn);
            flpChips.Controls.Add(btn);
            if (selected)
            {
                _filterKategoriId = kategoriId;
                _filterKritikOnly = kritikOnly;
            }
        }

        private void StyleChip(SimpleButton btn, bool selected, bool kritik)
        {
            if (selected && kritik)
            {
                btn.Appearance.BackColor = ModernTheme.Colors.TerracottaSoft;
                btn.Appearance.ForeColor = ModernTheme.Colors.OnTerracottaSoft;
            }
            else if (selected)
            {
                btn.Appearance.BackColor = ModernTheme.Colors.Primary;
                btn.Appearance.ForeColor = ModernTheme.Colors.TextOnPrimary;
            }
            else
            {
                btn.Appearance.BackColor = Color.FromArgb(0xF6, 0xF3, 0xEE);
                btn.Appearance.ForeColor = ModernTheme.Colors.TextPrimary;
                btn.Appearance.BorderColor = ModernTheme.Colors.Border;
                btn.Appearance.Options.UseBorderColor = true;
            }
            btn.Appearance.Font = ModernTheme.Typography.Caption;
            btn.Appearance.Options.UseBackColor = true;
            btn.Appearance.Options.UseForeColor = true;
            btn.Appearance.Options.UseFont = true;
            btn.ButtonStyle = DevExpress.XtraEditors.Controls.BorderStyles.Simple;
        }

        private void Chip_Click(object sender, EventArgs e)
        {
            var btn = sender as SimpleButton;
            if (btn == null) return;
            var tag = btn.Tag as ChipTag;
            if (tag == null) return;

            _filterKategoriId = tag.KategoriId;
            _filterKritikOnly = tag.KritikOnly;

            foreach (var c in _chipButtons)
            {
                var t = c.Tag as ChipTag;
                bool sel = ReferenceEquals(c, btn);
                StyleChip(c, sel, t != null && t.KritikOnly);
            }

            ApplyFilter();
        }

        private void ApplyFilter()
        {
            RefreshList();
        }

        private void RefreshList()
        {
            try
            {
                grdUrunler.BeginUpdate();
                var arama = string.IsNullOrWhiteSpace(txtArama.Text) ? null : txtArama.Text.Trim();
                _allItems = InterfaceFactory.Stok.UrunStokListele(arama, _filterKategoriId, _filterKritikOnly)
                             ?? new List<StokUrunListeDto>();

                foreach (var item in _allItems)
                {
                    item.UrunAdi = TextHelper.FixEncoding(item.UrunAdi);
                    item.KategoriAdi = TextHelper.FixEncoding(item.KategoriAdi);
                    item.BirimAdi = TextHelper.FixEncoding(item.BirimAdi);
                    item.Durum = TextHelper.FixEncoding(item.Durum);
                }

                grdUrunler.DataSource = _allItems;
                UpdateSummary();
                UpdateChipCounts();

                if (_allItems.Count > 0)
                    gvUrunler.FocusedRowHandle = 0;
                else
                    ClearDetail();
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage("UcUrunStok.RefreshList: " + ex.Message, "URUN_STOK");
                MessageHelper.ShowError("Liste yüklenirken hata: " + ex.Message);
            }
            finally
            {
                grdUrunler.EndUpdate();
            }
        }

        private void UpdateSummary()
        {
            int toplam = _allItems.Count;
            int kritik = _allItems.Count(x => string.Equals(x.Durum, "Kritik", StringComparison.OrdinalIgnoreCase));
            lblSubtitle.Text = string.Format(
                CultureInfo.GetCultureInfo("tr-TR"),
                "Toplam {0} aktif ürün • {1} ürün kritik stok eşiğinde",
                toplam, kritik);
            lblFooter.Text = string.Format("Gösterilen: {0} kayıt", toplam);

            // Update Tümü / Kritik chip labels with counts if we can cheaply
            // (counts from current filter set — for absolute counts load once without filter)
        }

        private void UpdateChipCounts()
        {
            // Refresh absolute counts for Tümü / Kritik labels
            try
            {
                var all = InterfaceFactory.Stok.UrunStokListele(null, null, false) ?? new List<StokUrunListeDto>();
                int total = all.Count;
                int kritik = all.Count(x => string.Equals(x.Durum, "Kritik", StringComparison.OrdinalIgnoreCase));

                foreach (var c in _chipButtons)
                {
                    var t = c.Tag as ChipTag;
                    if (t == null) continue;
                    if (!t.KritikOnly && t.KategoriId == null && c.Text.StartsWith("Tümü"))
                        c.Text = string.Format("Tümü ({0})", total);
                    else if (t.KritikOnly)
                        c.Text = string.Format("Kritik Stok ({0})", kritik);
                }
            }
            catch
            {
                // ignore count refresh errors
            }
        }

        private void gvUrunler_FocusedRowChanged(object sender, FocusedRowChangedEventArgs e)
        {
            var row = gvUrunler.GetRow(e.FocusedRowHandle) as StokUrunListeDto;
            BindDetail(row);
        }

        private void gvUrunler_CustomDrawCell(object sender, RowCellCustomDrawEventArgs e)
        {
            if (e.Column == null || e.Column.FieldName != "Durum") return;
            var durum = e.CellValue as string;
            if (string.IsNullOrEmpty(durum)) return;

            Color bg, fg;
            switch (durum)
            {
                case "Kritik":
                    bg = ModernTheme.Colors.TerracottaSoft;
                    fg = ModernTheme.Colors.OnTerracottaSoft;
                    break;
                case "Azalıyor":
                    bg = ModernTheme.Colors.WarningSoft;
                    fg = Color.FromArgb(0x54, 0x31, 0x02);
                    break;
                case "Yeterli":
                    bg = ModernTheme.Colors.SuccessSoft;
                    fg = Color.FromArgb(0x14, 0x3D, 0x2B);
                    break;
                default:
                    bg = ModernTheme.Colors.OliveSoft;
                    fg = ModernTheme.Colors.OnOliveSoft;
                    break;
            }

            e.Appearance.BackColor = bg;
            e.Appearance.ForeColor = fg;
            e.Appearance.Options.UseBackColor = true;
            e.Appearance.Options.UseForeColor = true;
        }

        private void BindDetail(StokUrunListeDto item)
        {
            _selected = item;
            if (item == null)
            {
                ClearDetail();
                return;
            }

            lblDetayKod.Text = string.Format("{0} • {1}",
                item.UrunKod ?? "—",
                string.IsNullOrWhiteSpace(item.Barkod) ? "barkod yok" : item.Barkod);
            lblDetayAd.Text = item.UrunAdi ?? "—";
            lblDetayDurum.Text = item.Durum ?? "";
            StyleDurumBadge(item.Durum);

            lblMevcut.Text = item.MevcutStokText;
            lblMevcut.Appearance.ForeColor = string.Equals(item.Durum, "Kritik", StringComparison.OrdinalIgnoreCase)
                ? ModernTheme.Colors.OnTerracottaSoft
                : ModernTheme.Colors.TextPrimary;
            lblMevcut.Appearance.Options.UseForeColor = true;

            lblKritik.Text = string.Format("{0:N2} {1}", item.KritikStok, item.BirimAdi ?? "").Trim();
            lblBirim.Text = item.BirimAdi ?? "—";
            lblKategori.Text = item.KategoriAdi ?? "—";

            btnKaydet.Enabled = true;
            btnSiparis.Enabled = true;
        }

        private void StyleDurumBadge(string durum)
        {
            Color bg, fg;
            switch (durum)
            {
                case "Kritik":
                    bg = ModernTheme.Colors.TerracottaSoft;
                    fg = ModernTheme.Colors.OnTerracottaSoft;
                    break;
                case "Azalıyor":
                    bg = ModernTheme.Colors.WarningSoft;
                    fg = Color.FromArgb(0x54, 0x31, 0x02);
                    break;
                case "Yeterli":
                    bg = ModernTheme.Colors.SuccessSoft;
                    fg = Color.FromArgb(0x14, 0x3D, 0x2B);
                    break;
                default:
                    bg = ModernTheme.Colors.OliveSoft;
                    fg = ModernTheme.Colors.OnOliveSoft;
                    break;
            }
            lblDetayDurum.Appearance.BackColor = bg;
            lblDetayDurum.Appearance.ForeColor = fg;
            lblDetayDurum.Appearance.Options.UseBackColor = true;
            lblDetayDurum.Appearance.Options.UseForeColor = true;
        }

        private void ClearDetail()
        {
            _selected = null;
            lblDetayKod.Text = "—";
            lblDetayAd.Text = "Ürün seçin";
            lblDetayDurum.Text = "";
            lblMevcut.Text = "—";
            lblKritik.Text = "—";
            lblBirim.Text = "—";
            lblKategori.Text = "—";
            btnKaydet.Enabled = false;
            btnSiparis.Enabled = false;
        }

        private void SetHareketTip(string tip)
        {
            _hareketTip = tip;
            bool giris = tip == "GIRIS";

            btnGiris.Appearance.BackColor = giris ? ModernTheme.Colors.Primary : Color.FromArgb(0xF6, 0xF3, 0xEE);
            btnGiris.Appearance.ForeColor = giris ? ModernTheme.Colors.TextOnPrimary : ModernTheme.Colors.TextSecondary;
            btnGiris.Appearance.Options.UseBackColor = true;
            btnGiris.Appearance.Options.UseForeColor = true;

            btnCikis.Appearance.BackColor = !giris ? ModernTheme.Colors.Terracotta : Color.FromArgb(0xF6, 0xF3, 0xEE);
            btnCikis.Appearance.ForeColor = !giris ? ModernTheme.Colors.TextOnPrimary : ModernTheme.Colors.TextSecondary;
            btnCikis.Appearance.Options.UseBackColor = true;
            btnCikis.Appearance.Options.UseForeColor = true;
        }

        private void KaydetHareket()
        {
            if (_selected == null)
            {
                MessageHelper.ShowWarning("Önce listeden bir ürün seçin.");
                return;
            }

            decimal miktar;
            var raw = (txtMiktar.Text ?? "").Trim().Replace(',', '.');
            if (!decimal.TryParse(raw, NumberStyles.Number, CultureInfo.InvariantCulture, out miktar) || miktar <= 0)
            {
                MessageHelper.ShowWarning("Geçerli bir miktar girin.");
                txtMiktar.Focus();
                return;
            }

            try
            {
                var hareket = new StokHareketModel
                {
                    UrunId = _selected.UrunId,
                    HareketTip = _hareketTip,
                    Miktar = miktar,
                    HareketTarih = DateTime.Now,
                    Aciklama = string.IsNullOrWhiteSpace(txtAciklama.Text) ? null : txtAciklama.Text.Trim(),
                    KullaniciId = SessionManager.IsAuthenticated ? SessionManager.KullaniciId : (int?)null
                };

                var err = InterfaceFactory.Stok.HareketEkle(hareket);
                if (!string.IsNullOrEmpty(err))
                {
                    MessageHelper.ShowError(err);
                    return;
                }

                MessageHelper.ShowSuccess(_hareketTip == "GIRIS"
                    ? "Stok girişi kaydedildi."
                    : "Stok çıkışı kaydedildi.");

                var keepId = _selected.UrunId;
                RefreshList();
                FocusUrun(keepId);
                txtMiktar.Text = "1";
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage("UcUrunStok.KaydetHareket: " + ex.Message, "URUN_STOK");
                MessageHelper.ShowError("Hareket kaydedilemedi: " + ex.Message);
            }
        }

        private void FocusUrun(int urunId)
        {
            for (int i = 0; i < gvUrunler.RowCount; i++)
            {
                var row = gvUrunler.GetRow(i) as StokUrunListeDto;
                if (row != null && row.UrunId == urunId)
                {
                    gvUrunler.FocusedRowHandle = i;
                    return;
                }
            }
        }

        private void OpenYeniUrun()
        {
            try
            {
                var frm = FindForm();
                if (frm != null && frm.MdiParent != null)
                    NavigationManager.OpenScreen("URUN_KART", frm.MdiParent, null);
            }
            catch (Exception ex)
            {
                MessageHelper.ShowError("Yeni ürün açılamadı: " + ex.Message);
            }
        }

        private void OpenUrunKart()
        {
            if (_selected == null) return;
            try
            {
                var frm = FindForm();
                if (frm != null && frm.MdiParent != null)
                    NavigationManager.OpenScreen("URUN_KART", frm.MdiParent, _selected.UrunId);
            }
            catch (Exception ex)
            {
                MessageHelper.ShowError("Ürün kartı açılamadı: " + ex.Message);
            }
        }

        private void OpenSiparisTaslak()
        {
            try
            {
                var frm = FindForm();
                if (frm != null && frm.MdiParent != null)
                    NavigationManager.OpenScreen("SIP_TASLAK", frm.MdiParent, null);
            }
            catch (Exception ex)
            {
                MessageHelper.ShowError("Sipariş taslağı açılamadı: " + ex.Message);
            }
        }

        #endregion

        private class ChipTag
        {
            public int? KategoriId { get; set; }
            public bool KritikOnly { get; set; }
        }
    }
}
