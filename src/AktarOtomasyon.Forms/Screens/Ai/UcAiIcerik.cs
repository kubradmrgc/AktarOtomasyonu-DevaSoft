using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text.RegularExpressions;
using System.Windows.Forms;
using AktarOtomasyon.Ai.Interface;
using AktarOtomasyon.Forms.Base;
using AktarOtomasyon.Forms.Common;
using AktarOtomasyon.Forms.Managers;
using AktarOtomasyon.Urun.Interface.Models;
using DevExpress.XtraEditors;
using DevExpress.XtraGrid;
using DevExpress.XtraGrid.Columns;
using DevExpress.XtraGrid.Views.Base;
using DevExpress.XtraGrid.Views.Grid;
using DevExpress.Utils;
using Newtonsoft.Json;

namespace AktarOtomasyon.Forms.Screens.Ai
{
    /// <summary>
    /// AI İçerik Asistanı paneli (AI_ICERIK).
    /// Sol: taslak kuyruğu — Sağ: içerik editörü / onay.
    /// </summary>
    public partial class UcAiIcerik : UcBase
    {
        private string _durumGrup = "BEKLEYEN";
        private List<AiIcerikListeDto> _items = new List<AiIcerikListeDto>();
        private AiIcerikListeDto _selected;
        private bool _suppressChange;

        private PanelControl pnlRoot;
        private LabelControl lblTitle;
        private LabelControl lblSubtitle;
        private SimpleButton btnTumunuOnayla;
        private SimpleButton btnYeniUret;
        private SimpleButton btnBekleyen;
        private SimpleButton btnOnaylanan;
        private SplitContainerControl splitMain;
        private GridControl grdKuyruk;
        private GridView gvKuyruk;
        private LabelControl lblDetayKod;
        private LabelControl lblDetayAd;
        private LabelControl lblDetayDurum;
        private ComboBoxEdit cmbTon;
        private ComboBoxEdit cmbKanal;
        private SimpleButton btnYenile;
        private TextEdit txtBaslik;
        private MemoEdit memoAciklama;
        private MemoEdit memoKullanim;
        private FlowLayoutPanel flpEtiketler;
        private SimpleButton btnReddet;
        private SimpleButton btnKaydet;
        private SimpleButton btnOnayla;
        private LookUpEdit lkpYeniUrun;
        private LookUpEdit lkpYeniSablon;

        public UcAiIcerik()
        {
            InitializeComponent();
            BuildUi();
            WireEvents();
            ApplyTheme();
        }

        #region UI

        private void BuildUi()
        {
            pnlRoot = new PanelControl
            {
                Dock = DockStyle.Fill,
                BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.NoBorder,
                Padding = new Padding(20)
            };
            Controls.Add(pnlRoot);

            var pnlHeader = new PanelControl
            {
                Dock = DockStyle.Top,
                Height = 72,
                BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.NoBorder
            };

            lblTitle = new LabelControl
            {
                Text = "AI İçerik Asistanı",
                Location = new Point(0, 4),
                AutoSizeMode = LabelAutoSizeMode.None,
                Size = new Size(480, 28)
            };
            lblSubtitle = new LabelControl
            {
                Text = "Onay bekleyen taslaklar yükleniyor…",
                Location = new Point(0, 34),
                AutoSizeMode = LabelAutoSizeMode.None,
                Size = new Size(620, 20)
            };

            btnYeniUret = new SimpleButton
            {
                Text = "Yeni İçerik Üret  F5",
                Size = new Size(170, 36),
                Anchor = AnchorStyles.Top | AnchorStyles.Right
            };
            btnTumunuOnayla = new SimpleButton
            {
                Text = "Tümünü Onayla",
                Size = new Size(140, 36),
                Anchor = AnchorStyles.Top | AnchorStyles.Right
            };

            pnlHeader.Controls.Add(lblTitle);
            pnlHeader.Controls.Add(lblSubtitle);
            pnlHeader.Controls.Add(btnTumunuOnayla);
            pnlHeader.Controls.Add(btnYeniUret);
            pnlHeader.Resize += (s, e) =>
            {
                btnYeniUret.Location = new Point(pnlHeader.Width - btnYeniUret.Width - 4, 16);
                btnTumunuOnayla.Location = new Point(btnYeniUret.Left - btnTumunuOnayla.Width - 8, 16);
            };

            splitMain = new SplitContainerControl
            {
                Dock = DockStyle.Fill,
                Horizontal = false,
                SplitterPosition = 360
            };
            splitMain.Panel1.MinSize = 260;
            splitMain.Panel2.MinSize = 420;

            BuildQueuePanel(splitMain.Panel1);
            BuildEditorPanel(splitMain.Panel2);

            pnlRoot.Controls.Add(splitMain);
            pnlRoot.Controls.Add(pnlHeader);
        }

        private void BuildQueuePanel(Control panel)
        {
            var card = new PanelControl
            {
                Dock = DockStyle.Fill,
                BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.Simple,
                Padding = new Padding(0)
            };

            var tabs = new PanelControl
            {
                Dock = DockStyle.Top,
                Height = 48,
                BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.NoBorder,
                Padding = new Padding(8)
            };

            btnBekleyen = new SimpleButton { Text = "Onay Bekleyen", Size = new Size(150, 30), Location = new Point(8, 8) };
            btnOnaylanan = new SimpleButton { Text = "Onaylanan", Size = new Size(150, 30), Location = new Point(166, 8) };
            tabs.Controls.Add(btnBekleyen);
            tabs.Controls.Add(btnOnaylanan);

            grdKuyruk = new GridControl { Dock = DockStyle.Fill };
            gvKuyruk = new GridView(grdKuyruk);
            grdKuyruk.MainView = gvKuyruk;
            grdKuyruk.ViewCollection.Add(gvKuyruk);

            gvKuyruk.OptionsBehavior.Editable = false;
            gvKuyruk.OptionsView.ShowGroupPanel = false;
            gvKuyruk.OptionsView.ShowIndicator = false;
            gvKuyruk.OptionsView.ShowColumnHeaders = false;
            gvKuyruk.OptionsView.ShowHorizontalLines = DefaultBoolean.True;
            gvKuyruk.OptionsView.ShowVerticalLines = DefaultBoolean.False;
            gvKuyruk.FocusRectStyle = DrawFocusRectStyle.RowFocus;
            gvKuyruk.OptionsSelection.EnableAppearanceFocusedCell = false;
            gvKuyruk.RowHeight = 72;

            gvKuyruk.Columns.Add(new GridColumn { FieldName = "DisplayBlock", Caption = " ", Visible = true, Width = 320 });

            card.Controls.Add(grdKuyruk);
            card.Controls.Add(tabs);
            panel.Controls.Add(card);
            StyleTab(true);
        }

        private void BuildEditorPanel(Control panel)
        {
            var card = new PanelControl
            {
                Dock = DockStyle.Fill,
                BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.Simple,
                Padding = new Padding(16)
            };

            lblDetayKod = new LabelControl
            {
                Location = new Point(16, 12),
                AutoSizeMode = LabelAutoSizeMode.None,
                Size = new Size(420, 18),
                Text = "—"
            };
            lblDetayAd = new LabelControl
            {
                Location = new Point(16, 34),
                AutoSizeMode = LabelAutoSizeMode.None,
                Size = new Size(480, 28),
                Text = "Taslak seçin"
            };
            lblDetayDurum = new LabelControl
            {
                Location = new Point(520, 36),
                AutoSizeMode = LabelAutoSizeMode.None,
                Size = new Size(120, 22),
                Appearance = { TextOptions = { HAlignment = HorzAlignment.Center } }
            };

            var paramBox = new PanelControl
            {
                Location = new Point(16, 78),
                Size = new Size(640, 70),
                Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right,
                BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.Simple,
                Padding = new Padding(8)
            };

            var lblTon = new LabelControl { Text = "Anlatım Tonu", Location = new Point(8, 6) };
            cmbTon = new ComboBoxEdit { Location = new Point(8, 26), Size = new Size(180, 24) };
            cmbTon.Properties.TextEditStyle = DevExpress.XtraEditors.Controls.TextEditStyles.DisableTextEditor;
            cmbTon.Properties.Items.AddRange(new object[]
            {
                "Güven Veren & Doğal",
                "Kısa Raf Etiketi",
                "Detaylı Bilgilendirici"
            });
            cmbTon.SelectedIndex = 0;

            var lblKanal = new LabelControl { Text = "Hedef Kanal", Location = new Point(200, 6) };
            cmbKanal = new ComboBoxEdit { Location = new Point(200, 26), Size = new Size(180, 24) };
            cmbKanal.Properties.TextEditStyle = DevExpress.XtraEditors.Controls.TextEditStyles.DisableTextEditor;
            cmbKanal.Properties.Items.AddRange(new object[]
            {
                "Ürün Kartı + E-Ticaret",
                "Mağaza Raf Etiketi",
                "WhatsApp Katalog"
            });
            cmbKanal.SelectedIndex = 0;

            btnYenile = new SimpleButton
            {
                Text = "Taslağı Yenile",
                Location = new Point(400, 22),
                Size = new Size(140, 30)
            };

            // Hidden lookups for new generation dialog-ish strip
            lkpYeniUrun = new LookUpEdit { Visible = false, Size = new Size(1, 1) };
            lkpYeniSablon = new LookUpEdit { Visible = false, Size = new Size(1, 1) };

            paramBox.Controls.AddRange(new Control[] { lblTon, cmbTon, lblKanal, cmbKanal, btnYenile });

            var lblBaslik = new LabelControl { Text = "Ürün Başlığı", Location = new Point(16, 162) };
            txtBaslik = new TextEdit
            {
                Location = new Point(16, 182),
                Size = new Size(640, 28),
                Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right
            };

            var lblAciklama = new LabelControl { Text = "Ürün Açıklaması", Location = new Point(16, 220) };
            memoAciklama = new MemoEdit
            {
                Location = new Point(16, 240),
                Size = new Size(640, 90),
                Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right
            };

            var lblKullanim = new LabelControl { Text = "Hazırlama ve Saklama Önerisi", Location = new Point(16, 340) };
            memoKullanim = new MemoEdit
            {
                Location = new Point(16, 360),
                Size = new Size(640, 70),
                Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right
            };

            flpEtiketler = new FlowLayoutPanel
            {
                Location = new Point(16, 440),
                Size = new Size(640, 32),
                Anchor = AnchorStyles.Top | AnchorStyles.Left | AnchorStyles.Right,
                WrapContents = false
            };

            btnReddet = new SimpleButton
            {
                Text = "Taslağı Reddet",
                Location = new Point(16, 500),
                Size = new Size(140, 36)
            };
            btnKaydet = new SimpleButton
            {
                Text = "Düzenle ve Kaydet",
                Location = new Point(360, 500),
                Size = new Size(150, 36),
                Anchor = AnchorStyles.Top | AnchorStyles.Right
            };
            btnOnayla = new SimpleButton
            {
                Text = "Onayla ve Ürüne Aktar",
                Location = new Point(520, 500),
                Size = new Size(170, 36),
                Anchor = AnchorStyles.Top | AnchorStyles.Right
            };

            card.Controls.AddRange(new Control[]
            {
                lblDetayKod, lblDetayAd, lblDetayDurum, paramBox,
                lblBaslik, txtBaslik, lblAciklama, memoAciklama,
                lblKullanim, memoKullanim, flpEtiketler,
                btnReddet, btnKaydet, btnOnayla, lkpYeniUrun, lkpYeniSablon
            });

            card.Resize += (s, e) =>
            {
                int w = Math.Max(360, card.Width - 40);
                paramBox.Width = w;
                txtBaslik.Width = w;
                memoAciklama.Width = w;
                memoKullanim.Width = w;
                flpEtiketler.Width = w;
                btnOnayla.Left = 16 + w - btnOnayla.Width;
                btnKaydet.Left = btnOnayla.Left - btnKaydet.Width - 10;
                lblDetayDurum.Left = Math.Max(300, 16 + w - lblDetayDurum.Width);
            };

            panel.Controls.Add(card);
            ClearEditor();
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

            ModernTheme.ApplyModernButton(btnYeniUret, ModernTheme.Colors.TerracottaSoft, false);
            btnYeniUret.Appearance.ForeColor = ModernTheme.Colors.OnTerracottaSoft;
            btnYeniUret.Appearance.Options.UseForeColor = true;

            ModernTheme.ApplyModernButton(btnTumunuOnayla, ModernTheme.Colors.Surface, false);
            btnTumunuOnayla.Appearance.ForeColor = ModernTheme.Colors.Primary;
            btnTumunuOnayla.Appearance.BorderColor = ModernTheme.Colors.Border;
            btnTumunuOnayla.Appearance.Options.UseForeColor = true;
            btnTumunuOnayla.Appearance.Options.UseBorderColor = true;

            ModernTheme.ApplyModernButton(btnYenile, ModernTheme.Colors.OliveSoft, false);
            btnYenile.Appearance.ForeColor = ModernTheme.Colors.OnOliveSoft;
            btnYenile.Appearance.Options.UseForeColor = true;

            ModernTheme.ApplyModernButton(btnOnayla, ModernTheme.Colors.Primary, true);
            ModernTheme.ApplyModernButton(btnKaydet, ModernTheme.Colors.Surface, false);
            btnKaydet.Appearance.ForeColor = ModernTheme.Colors.Primary;
            btnKaydet.Appearance.BorderColor = ModernTheme.Colors.Border;
            btnKaydet.Appearance.Options.UseForeColor = true;
            btnKaydet.Appearance.Options.UseBorderColor = true;

            ModernTheme.ApplyModernButton(btnReddet, ModernTheme.Colors.Surface, false);
            btnReddet.Appearance.ForeColor = ModernTheme.Colors.TextSecondary;
            btnReddet.Appearance.BorderColor = ModernTheme.Colors.Border;
            btnReddet.Appearance.Options.UseForeColor = true;
            btnReddet.Appearance.Options.UseBorderColor = true;

            ModernTheme.ApplyModernGrid(gvKuyruk);
            gvKuyruk.Appearance.FocusedRow.BackColor = Color.FromArgb(0xE4, 0xEF, 0xE9);
            gvKuyruk.Appearance.FocusedRow.ForeColor = ModernTheme.Colors.TextPrimary;
            gvKuyruk.Appearance.SelectedRow.BackColor = Color.FromArgb(0xE4, 0xEF, 0xE9);
            gvKuyruk.Appearance.SelectedRow.ForeColor = ModernTheme.Colors.TextPrimary;

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
            btnBekleyen.Click += (s, e) => { _durumGrup = "BEKLEYEN"; StyleTab(true); RefreshList(); };
            btnOnaylanan.Click += (s, e) => { _durumGrup = "ONAYLANAN"; StyleTab(false); RefreshList(); };

            btnYeniUret.Click += (s, e) => UretYeniIcerik();
            btnTumunuOnayla.Click += (s, e) => TumunuOnayla();
            btnYenile.Click += (s, e) => YenileSecili();
            btnKaydet.Click += (s, e) => Kaydet();
            btnOnayla.Click += (s, e) => Onayla();
            btnReddet.Click += (s, e) => Reddet();

            gvKuyruk.FocusedRowChanged += gvKuyruk_FocusedRowChanged;
            gvKuyruk.CustomDrawCell += gvKuyruk_CustomDrawCell;
        }

        protected override bool ProcessCmdKey(ref Message msg, Keys keyData)
        {
            if (keyData == Keys.F5)
            {
                UretYeniIcerik();
                return true;
            }
            return base.ProcessCmdKey(ref msg, keyData);
        }

        private void StyleTab(bool bekleyen)
        {
            StyleChipButton(btnBekleyen, bekleyen, false);
            StyleChipButton(btnOnaylanan, !bekleyen, false);
        }

        private void StyleChipButton(SimpleButton btn, bool selected, bool terracotta)
        {
            if (selected)
            {
                btn.Appearance.BackColor = terracotta ? ModernTheme.Colors.TerracottaSoft : ModernTheme.Colors.Primary;
                btn.Appearance.ForeColor = terracotta ? ModernTheme.Colors.OnTerracottaSoft : ModernTheme.Colors.TextOnPrimary;
            }
            else
            {
                btn.Appearance.BackColor = Color.FromArgb(0xF6, 0xF3, 0xEE);
                btn.Appearance.ForeColor = ModernTheme.Colors.TextSecondary;
            }
            btn.Appearance.Options.UseBackColor = true;
            btn.Appearance.Options.UseForeColor = true;
            btn.ButtonStyle = DevExpress.XtraEditors.Controls.BorderStyles.Simple;
        }

        #endregion

        #region Data

        public override void LoadData()
        {
            try
            {
                LoadLookups();
                RefreshList();
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage("UcAiIcerik.LoadData: " + ex.Message, "AI_ICERIK");
                MessageHelper.ShowError("AI paneli yüklenirken hata: " + ex.Message);
            }
        }

        private void LoadLookups()
        {
            var urunler = InterfaceFactory.Urun.Listele() ?? new List<UrunListeItemDto>();
            foreach (var u in urunler)
                u.UrunAdi = TextHelper.FixEncoding(u.UrunAdi);

            lkpYeniUrun.Properties.DataSource = urunler;
            lkpYeniUrun.Properties.DisplayMember = "UrunAdi";
            lkpYeniUrun.Properties.ValueMember = "UrunId";
            lkpYeniUrun.Properties.NullText = "Ürün seçin…";

            var sablonlar = InterfaceFactory.Ai.SablonListele(true) ?? new List<AiSablonListModel>();
            lkpYeniSablon.Properties.DataSource = sablonlar;
            lkpYeniSablon.Properties.DisplayMember = "SablonAdi";
            lkpYeniSablon.Properties.ValueMember = "SablonKod";
            lkpYeniSablon.Properties.NullText = "Şablon seçin…";
            if (sablonlar.Count > 0)
                lkpYeniSablon.EditValue = sablonlar[0].SablonKod;
        }

        private void RefreshList()
        {
            try
            {
                grdKuyruk.BeginUpdate();
                _items = InterfaceFactory.Ai.IcerikListele(_durumGrup) ?? new List<AiIcerikListeDto>();

                foreach (var item in _items)
                {
                    item.UrunAdi = TextHelper.FixEncoding(item.UrunAdi);
                    item.KategoriAdi = TextHelper.FixEncoding(item.KategoriAdi);
                    item.SablonAdi = TextHelper.FixEncoding(item.SablonAdi);
                    item.Icerik = TextHelper.FixEncoding(item.Icerik);
                }

                // Bind via anonymous projection for display
                var bind = _items.Select(x => new QueueRow
                {
                    IcerikId = x.IcerikId,
                    DisplayBlock = string.Format("{0}\n{1}\n{2}", x.UrunKod, x.UrunAdi, x.MetaText),
                    Item = x
                }).ToList();

                grdKuyruk.DataSource = bind;
                UpdateSummary();

                if (bind.Count > 0)
                    gvKuyruk.FocusedRowHandle = 0;
                else
                    ClearEditor();
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage("UcAiIcerik.RefreshList: " + ex.Message, "AI_ICERIK");
                MessageHelper.ShowError("Kuyruk yüklenirken hata: " + ex.Message);
            }
            finally
            {
                grdKuyruk.EndUpdate();
            }
        }

        private void UpdateSummary()
        {
            var bekleyen = InterfaceFactory.Ai.IcerikListele("BEKLEYEN") ?? new List<AiIcerikListeDto>();
            var onayli = InterfaceFactory.Ai.IcerikListele("ONAYLANAN") ?? new List<AiIcerikListeDto>();

            btnBekleyen.Text = string.Format("Onay Bekleyen ({0})", bekleyen.Count);
            btnOnaylanan.Text = string.Format("Onaylanan ({0})", onayli.Count);
            lblSubtitle.Text = string.Format(
                "{0} onay bekleyen taslak • Ürün açıklamaları, raf etiketleri ve kullanım önerileri",
                bekleyen.Count);

            btnTumunuOnayla.Enabled = bekleyen.Count > 0 && _durumGrup == "BEKLEYEN";
        }

        private void gvKuyruk_FocusedRowChanged(object sender, FocusedRowChangedEventArgs e)
        {
            var row = gvKuyruk.GetRow(e.FocusedRowHandle) as QueueRow;
            BindEditor(row != null ? row.Item : null);
        }

        private void gvKuyruk_CustomDrawCell(object sender, RowCellCustomDrawEventArgs e)
        {
            if (e.Column == null || e.Column.FieldName != "DisplayBlock") return;
            var row = gvKuyruk.GetRow(e.RowHandle) as QueueRow;
            if (row == null || row.Item == null) return;

            e.Handled = true;
            var item = row.Item;
            var bounds = e.Bounds;
            bool focused = gvKuyruk.FocusedRowHandle == e.RowHandle;

            using (var bg = new SolidBrush(focused
                ? Color.FromArgb(0xE4, 0xEF, 0xE9)
                : ModernTheme.Colors.Surface))
            {
                e.Graphics.FillRectangle(bg, bounds);
            }

            if (focused)
            {
                using (var pen = new Pen(ModernTheme.Colors.Primary, 2))
                    e.Graphics.DrawLine(pen, bounds.Left + 1, bounds.Top + 4, bounds.Left + 1, bounds.Bottom - 4);
            }

            var kodFont = ModernTheme.Typography.Caption;
            var adFont = ModernTheme.Typography.H6;
            var metaFont = ModernTheme.Typography.Caption;

            TextRenderer.DrawText(e.Graphics, item.UrunKod ?? "", kodFont,
                new Rectangle(bounds.X + 12, bounds.Y + 8, bounds.Width - 110, 16),
                ModernTheme.Colors.Primary, TextFormatFlags.Left | TextFormatFlags.EndEllipsis);

            // Status badge
            var badge = item.DurumText;
            var badgeSize = TextRenderer.MeasureText(badge, metaFont);
            var badgeRect = new Rectangle(bounds.Right - badgeSize.Width - 18, bounds.Y + 8, badgeSize.Width + 8, 18);
            using (var bbg = new SolidBrush(ModernTheme.Colors.WarningSoft))
                e.Graphics.FillRectangle(bbg, badgeRect);
            TextRenderer.DrawText(e.Graphics, badge, metaFont, badgeRect,
                Color.FromArgb(0x54, 0x31, 0x02), TextFormatFlags.HorizontalCenter | TextFormatFlags.VerticalCenter);

            TextRenderer.DrawText(e.Graphics, item.UrunAdi ?? "", adFont,
                new Rectangle(bounds.X + 12, bounds.Y + 28, bounds.Width - 24, 20),
                ModernTheme.Colors.TextPrimary, TextFormatFlags.Left | TextFormatFlags.EndEllipsis);

            TextRenderer.DrawText(e.Graphics, item.MetaText ?? "", metaFont,
                new Rectangle(bounds.X + 12, bounds.Y + 50, bounds.Width - 24, 16),
                ModernTheme.Colors.TextSecondary, TextFormatFlags.Left | TextFormatFlags.EndEllipsis);
        }

        private void BindEditor(AiIcerikListeDto item)
        {
            _suppressChange = true;
            _selected = item;
            if (item == null)
            {
                ClearEditor();
                _suppressChange = false;
                return;
            }

            lblDetayKod.Text = string.Format("{0}  •  {1}",
                item.UrunKod ?? "—",
                string.IsNullOrWhiteSpace(item.KategoriAdi) ? "—" : item.KategoriAdi);
            bool onayli = string.Equals(item.Durum, "AKTIF", StringComparison.OrdinalIgnoreCase);
            lblDetayAd.Text = string.Format("{0} — {1}",
                item.UrunAdi ?? "—",
                onayli ? "Onaylı İçerik" : "Taslak İnceleme");
            lblDetayDurum.Text = item.DurumText;
            StyleDurumBadge(item.DurumText);

            var parsed = ParseContent(TextHelper.FixEncoding(item.Icerik));
            txtBaslik.Text = BuildBaslik(item, parsed);
            memoAciklama.Text = parsed.Aciklama ?? "";
            memoKullanim.Text = parsed.Kullanim ?? "";
            BuildEtiketler(item);

            bool editable = !string.Equals(item.Durum, "AKTIF", StringComparison.OrdinalIgnoreCase)
                            && !string.Equals(item.Durum, "REDDEDILDI", StringComparison.OrdinalIgnoreCase);
            txtBaslik.Properties.ReadOnly = !editable;
            memoAciklama.Properties.ReadOnly = !editable;
            memoKullanim.Properties.ReadOnly = !editable;
            btnKaydet.Enabled = editable;
            btnOnayla.Enabled = editable;
            btnReddet.Enabled = editable;
            btnYenile.Enabled = editable;

            _suppressChange = false;
        }

        private void ClearEditor()
        {
            _selected = null;
            lblDetayKod.Text = "—";
            lblDetayAd.Text = "Taslak seçin";
            lblDetayDurum.Text = "";
            txtBaslik.Text = "";
            memoAciklama.Text = "";
            memoKullanim.Text = "";
            flpEtiketler.Controls.Clear();
            btnKaydet.Enabled = false;
            btnOnayla.Enabled = false;
            btnReddet.Enabled = false;
            btnYenile.Enabled = false;
        }

        private void StyleDurumBadge(string text)
        {
            bool onayli = text == "Onaylandı";
            lblDetayDurum.Appearance.BackColor = onayli ? ModernTheme.Colors.SuccessSoft : ModernTheme.Colors.WarningSoft;
            lblDetayDurum.Appearance.ForeColor = onayli
                ? Color.FromArgb(0x14, 0x3D, 0x2B)
                : Color.FromArgb(0x54, 0x31, 0x02);
            lblDetayDurum.Appearance.Options.UseBackColor = true;
            lblDetayDurum.Appearance.Options.UseForeColor = true;
        }

        private void BuildEtiketler(AiIcerikListeDto item)
        {
            flpEtiketler.Controls.Clear();
            var tags = new List<Tuple<string, Color, Color>>();
            if (!string.IsNullOrWhiteSpace(item.KategoriAdi))
                tags.Add(Tuple.Create(item.KategoriAdi, Color.FromArgb(0xE4, 0xEF, 0xE9), Color.FromArgb(0x14, 0x29, 0x21)));
            tags.Add(Tuple.Create("Katkısız", ModernTheme.Colors.OliveSoft, ModernTheme.Colors.OnOliveSoft));
            tags.Add(Tuple.Create("Aktar Seçkisi", ModernTheme.Colors.TerracottaSoft, ModernTheme.Colors.OnTerracottaSoft));

            var lbl = new LabelControl
            {
                Text = "Etiketler:",
                AutoSizeMode = LabelAutoSizeMode.Horizontal,
                Margin = new Padding(0, 6, 8, 0)
            };
            lbl.Appearance.ForeColor = ModernTheme.Colors.TextSecondary;
            lbl.Appearance.Options.UseForeColor = true;
            flpEtiketler.Controls.Add(lbl);

            foreach (var t in tags)
            {
                var chip = new LabelControl
                {
                    Text = "  " + t.Item1 + "  ",
                    AutoSizeMode = LabelAutoSizeMode.Horizontal,
                    Margin = new Padding(0, 4, 6, 0),
                    Padding = new Padding(4, 2, 4, 2)
                };
                chip.Appearance.BackColor = t.Item2;
                chip.Appearance.ForeColor = t.Item3;
                chip.Appearance.Options.UseBackColor = true;
                chip.Appearance.Options.UseForeColor = true;
                flpEtiketler.Controls.Add(chip);
            }
        }

        private static string BuildBaslik(AiIcerikListeDto item, ParsedContent parsed)
        {
            if (!string.IsNullOrWhiteSpace(parsed.Baslik))
                return parsed.Baslik;
            return item.UrunAdi ?? "";
        }

        private class ParsedContent
        {
            public string Baslik { get; set; }
            public string Aciklama { get; set; }
            public string Kullanim { get; set; }
            public string Uyari { get; set; }
            public string Kombinasyon { get; set; }
            public bool IsJson { get; set; }
        }

        private class AiContentJson
        {
            [JsonProperty("fayda")]
            public string Fayda { get; set; }
            [JsonProperty("kullanim")]
            public string Kullanim { get; set; }
            [JsonProperty("uyari")]
            public string Uyari { get; set; }
            [JsonProperty("kombinasyon")]
            public string Kombinasyon { get; set; }
            [JsonProperty("baslik")]
            public string Baslik { get; set; }
            [JsonProperty("aciklama")]
            public string Aciklama { get; set; }
        }

        private ParsedContent ParseContent(string raw)
        {
            var result = new ParsedContent();
            if (string.IsNullOrWhiteSpace(raw))
                return result;

            try
            {
                var json = ExtractJson(raw);
                var obj = JsonConvert.DeserializeObject<AiContentJson>(json);
                if (obj != null)
                {
                    result.IsJson = true;
                    result.Baslik = TextHelper.FixEncoding(obj.Baslik);
                    result.Aciklama = TextHelper.FixEncoding(
                        !string.IsNullOrWhiteSpace(obj.Aciklama) ? obj.Aciklama : obj.Fayda);
                    result.Kullanim = TextHelper.FixEncoding(obj.Kullanim);
                    result.Uyari = TextHelper.FixEncoding(obj.Uyari);
                    result.Kombinasyon = TextHelper.FixEncoding(obj.Kombinasyon);
                    return result;
                }
            }
            catch
            {
                // plain text fallback
            }

            result.Aciklama = TextHelper.FixEncoding(raw);
            return result;
        }

        private static string ExtractJson(string text)
        {
            if (string.IsNullOrWhiteSpace(text))
                return text;
            var trimmed = text.Trim();
            if (trimmed.StartsWith("{"))
                return trimmed;

            var match = Regex.Match(trimmed, @"```(?:json)?\s*(\{[\s\S]*?\})\s*```", RegexOptions.IgnoreCase);
            if (match.Success)
                return match.Groups[1].Value.Trim();

            var start = trimmed.IndexOf('{');
            var end = trimmed.LastIndexOf('}');
            if (start >= 0 && end > start)
                return trimmed.Substring(start, end - start + 1);

            return trimmed;
        }

        private string BuildJsonFromEditor()
        {
            var obj = new AiContentJson
            {
                Baslik = txtBaslik.Text.Trim(),
                Aciklama = memoAciklama.Text.Trim(),
                Fayda = memoAciklama.Text.Trim(),
                Kullanim = memoKullanim.Text.Trim()
            };
            return JsonConvert.SerializeObject(obj);
        }

        private string ResolveSablonKod()
        {
            // Ton/kanal → şablon eşlemesi
            var ton = cmbTon.Text ?? "";
            var kanal = cmbKanal.Text ?? "";

            if (ton.Contains("Raf") || kanal.Contains("Raf"))
                return "URUN_SEO";
            if (ton.Contains("Detaylı") || kanal.Contains("WhatsApp"))
                return "URUN_KULLANIM";
            return "URUN_ACIKLAMA";
        }

        #endregion

        #region Actions

        private void Kaydet()
        {
            if (_selected == null) return;
            try
            {
                var json = BuildJsonFromEditor();
                var err = InterfaceFactory.Ai.IcerikGuncelle(_selected.IcerikId, json, _selected.SablonKod);
                if (DMLManager.KaydetKontrol(err))
                {
                    var keepId = _selected.IcerikId;
                    RefreshList();
                    FocusItem(keepId);
                }
            }
            catch (Exception ex)
            {
                MessageHelper.ShowError("Kayıt hatası: " + ex.Message);
            }
        }

        private void Onayla()
        {
            if (_selected == null) return;
            if (!MessageHelper.ShowConfirmation("İçeriği onaylayıp ürüne aktarmak istiyor musunuz?"))
                return;

            try
            {
                // Save edits first
                var json = BuildJsonFromEditor();
                var upd = InterfaceFactory.Ai.IcerikGuncelle(_selected.IcerikId, json, _selected.SablonKod);
                if (!string.IsNullOrEmpty(upd))
                {
                    MessageHelper.ShowError(upd);
                    return;
                }

                var err = InterfaceFactory.Ai.IcerikOnayla(_selected.IcerikId);
                if (DMLManager.IslemKontrol(err, "İçerik onaylandı ve ürüne aktarıldı."))
                    RefreshList();
            }
            catch (Exception ex)
            {
                MessageHelper.ShowError("Onay hatası: " + ex.Message);
            }
        }

        private void Reddet()
        {
            if (_selected == null) return;
            if (!MessageHelper.ShowConfirmation("Bu taslağı reddetmek istediğinize emin misiniz?"))
                return;

            try
            {
                var err = InterfaceFactory.Ai.IcerikReddet(_selected.IcerikId);
                if (DMLManager.IslemKontrol(err, "Taslak reddedildi."))
                    RefreshList();
            }
            catch (Exception ex)
            {
                MessageHelper.ShowError("Reddetme hatası: " + ex.Message);
            }
        }

        private void TumunuOnayla()
        {
            var bekleyen = InterfaceFactory.Ai.IcerikListele("BEKLEYEN") ?? new List<AiIcerikListeDto>();
            if (bekleyen.Count == 0)
            {
                MessageHelper.ShowInfo("Onay bekleyen taslak yok.");
                return;
            }

            if (!MessageHelper.ShowConfirmation(string.Format("{0} taslağın tümünü onaylamak istiyor musunuz?", bekleyen.Count)))
                return;

            int ok = 0;
            foreach (var item in bekleyen)
            {
                var err = InterfaceFactory.Ai.IcerikOnayla(item.IcerikId);
                if (err == null) ok++;
            }

            MessageHelper.ShowSuccess(string.Format("{0} / {1} taslak onaylandı.", ok, bekleyen.Count));
            RefreshList();
        }

        private void YenileSecili()
        {
            if (_selected == null) return;

            try
            {
                Cursor = Cursors.WaitCursor;
                var sablon = !string.IsNullOrWhiteSpace(_selected.SablonKod)
                    ? _selected.SablonKod
                    : ResolveSablonKod();

                var sonuc = InterfaceFactory.Ai.IcerikUret(_selected.UrunId, sablon);
                if (sonuc.Basarili)
                {
                    MessageHelper.ShowSuccess("Taslak yenilendi.");
                    RefreshList();
                    // Focus newest for this product
                    var newest = (InterfaceFactory.Ai.IcerikListele("BEKLEYEN") ?? new List<AiIcerikListeDto>())
                        .Where(x => x.UrunId == _selected.UrunId)
                        .OrderByDescending(x => x.OlusturmaTarih)
                        .FirstOrDefault();
                    if (newest != null)
                        FocusItem(newest.IcerikId);
                }
                else
                {
                    MessageHelper.ShowError("Üretim başarısız: " + sonuc.Hata);
                }
            }
            catch (Exception ex)
            {
                MessageHelper.ShowError("Yenileme hatası: " + ex.Message);
            }
            finally
            {
                Cursor = Cursors.Default;
            }
        }

        private void UretYeniIcerik()
        {
            using (var dlg = new XtraForm())
            {
                dlg.Text = "Yeni İçerik Üret";
                dlg.FormBorderStyle = FormBorderStyle.FixedDialog;
                dlg.StartPosition = FormStartPosition.CenterParent;
                dlg.ClientSize = new Size(420, 200);
                dlg.MaximizeBox = false;
                dlg.MinimizeBox = false;
                dlg.BackColor = ModernTheme.Colors.Background;

                var lblU = new LabelControl { Text = "Ürün", Location = new Point(20, 20) };
                var lkpU = new LookUpEdit { Location = new Point(20, 40), Size = new Size(370, 28) };
                lkpU.Properties.DataSource = lkpYeniUrun.Properties.DataSource;
                lkpU.Properties.DisplayMember = "UrunAdi";
                lkpU.Properties.ValueMember = "UrunId";
                lkpU.Properties.NullText = "Ürün seçin…";

                var lblS = new LabelControl { Text = "Şablon", Location = new Point(20, 80) };
                var lkpS = new LookUpEdit { Location = new Point(20, 100), Size = new Size(370, 28) };
                lkpS.Properties.DataSource = lkpYeniSablon.Properties.DataSource;
                lkpS.Properties.DisplayMember = "SablonAdi";
                lkpS.Properties.ValueMember = "SablonKod";
                lkpS.Properties.NullText = "Şablon seçin…";
                lkpS.EditValue = lkpYeniSablon.EditValue ?? ResolveSablonKod();

                var btnOk = new SimpleButton { Text = "Üret", DialogResult = DialogResult.OK, Location = new Point(210, 150), Size = new Size(90, 32) };
                var btnCancel = new SimpleButton { Text = "İptal", DialogResult = DialogResult.Cancel, Location = new Point(310, 150), Size = new Size(80, 32) };
                ModernTheme.ApplyModernButton(btnOk, ModernTheme.Colors.Primary, true);
                ModernTheme.ApplyModernButton(btnCancel, ModernTheme.Colors.Surface, false);

                dlg.Controls.AddRange(new Control[] { lblU, lkpU, lblS, lkpS, btnOk, btnCancel });
                dlg.AcceptButton = btnOk;
                dlg.CancelButton = btnCancel;

                if (dlg.ShowDialog(FindForm()) != DialogResult.OK)
                    return;

                if (lkpU.EditValue == null || lkpS.EditValue == null)
                {
                    MessageHelper.ShowWarning("Ürün ve şablon seçimi zorunlu.");
                    return;
                }

                try
                {
                    Cursor = Cursors.WaitCursor;
                    var urunId = Convert.ToInt32(lkpU.EditValue);
                    var sablon = lkpS.EditValue.ToString();
                    var sonuc = InterfaceFactory.Ai.IcerikUret(urunId, sablon);
                    if (sonuc.Basarili)
                    {
                        MessageHelper.ShowSuccess("İçerik üretildi ve taslak kuyruğuna eklendi.");
                        _durumGrup = "BEKLEYEN";
                        StyleTab(true);
                        RefreshList();
                    }
                    else
                    {
                        MessageHelper.ShowError("Üretim başarısız: " + sonuc.Hata);
                    }
                }
                catch (Exception ex)
                {
                    MessageHelper.ShowError("Üretim hatası: " + ex.Message);
                }
                finally
                {
                    Cursor = Cursors.Default;
                }
            }
        }

        private void FocusItem(int icerikId)
        {
            for (int i = 0; i < gvKuyruk.RowCount; i++)
            {
                var row = gvKuyruk.GetRow(i) as QueueRow;
                if (row != null && row.IcerikId == icerikId)
                {
                    gvKuyruk.FocusedRowHandle = i;
                    return;
                }
            }
        }

        #endregion

        private class QueueRow
        {
            public int IcerikId { get; set; }
            public string DisplayBlock { get; set; }
            public AiIcerikListeDto Item { get; set; }
        }
    }
}
