using System;
using System.Collections.Generic;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;
using System.Windows.Forms;
using AktarOtomasyon.Ai.Interface;
using AktarOtomasyon.Forms.Base;
using AktarOtomasyon.Forms.Common;
using AktarOtomasyon.Forms.Managers;
using AktarOtomasyon.Satis.Interface;
using AktarOtomasyon.Urun.Interface;
using AktarOtomasyon.Urun.Interface.Models;
using DevExpress.XtraEditors;
using DevExpress.XtraGrid.Views.Grid;
using Newtonsoft.Json;

namespace AktarOtomasyon.Forms.Screens.Satis
{
    public partial class UcSatis : UcBase
    {
        private List<SepetItem> _sepet = new List<SepetItem>();
        private UrunModel _aktifUrun;
        private List<UrunListeItemDto> _urunListe = new List<UrunListeItemDto>();

        private SearchLookUpEdit lkpUrunAra;
        private GroupControl grpRecete;
        private LabelControl lblReceteBaslik;
        private MemoEdit memoKullanim;
        private MemoEdit memoFayda;
        private LabelControl lblUyari;

        private PanelControl pnlSepetIslem;
        private SimpleButton btnUrunIptal;
        private SimpleButton btnFisIptal;
        private SimpleButton btnEtiketYazdir;
        private CheckEdit chkEtiketYazdir;

        public UcSatis()
        {
            InitializeComponent();
            BuildExtraUi();
            WireExtraEvents();
            ApplyTheme();
        }

        public override void LoadData()
        {
            _sepet.Clear();
            RefreshSepet();
            LoadUrunLookup();
            txtBarkod.Properties.NullText = "Barkod, ürün kodu veya ürün adı…";
            txtBarkod.Properties.NullValuePrompt = "Barkod, ürün kodu veya ürün adı…";
            txtBarkod.Properties.NullValuePromptShowForEmptyValue = true;
            ClearAktifUrun();
            txtBarkod.Focus();
        }

        #region Extra UI

        private void BuildExtraUi()
        {
            // İsimle arama
            var lblAra = new LabelControl
            {
                Text = "Ürün Adı ile Ara:",
                Location = new Point(20, 95),
                Name = "lblUrunAra"
            };

            lkpUrunAra = new SearchLookUpEdit
            {
                Location = new Point(20, 115),
                Size = new Size(300, 28),
                Name = "lkpUrunAra"
            };
            lkpUrunAra.Properties.NullText = "İsim yazın veya seçin…";
            lkpUrunAra.Properties.DisplayMember = "UrunAdi";
            lkpUrunAra.Properties.ValueMember = "UrunId";
            lkpUrunAra.Properties.ShowClearButton = true;

            // Mevcut etiketleri aşağı kaydır
            lblUrunAdi.Location = new Point(20, 155);
            lblFiyat.Location = new Point(20, 185);
            lblMiktar.Location = new Point(20, 220);
            numMiktar.Location = new Point(20, 240);
            btnSepeteEkle.Location = new Point(140, 235);

            // Reçete paneli (görsel yerine / altında)
            picUrun.Visible = false;

            grpRecete = new GroupControl
            {
                Text = "Kullanım Reçetesi (Onaylı AI)",
                Location = new Point(12, 290),
                Size = new Size(320, 280),
                Anchor = AnchorStyles.Top | AnchorStyles.Bottom | AnchorStyles.Left | AnchorStyles.Right,
                Name = "grpRecete"
            };

            lblReceteBaslik = new LabelControl
            {
                Text = "Ürün seçildiğinde kullanım oranı burada görünür.",
                Location = new Point(12, 28),
                AutoSizeMode = LabelAutoSizeMode.None,
                Size = new Size(290, 36),
                Name = "lblReceteBaslik"
            };

            var lblKul = new LabelControl { Text = "Hazırlama / Oran", Location = new Point(12, 68) };
            memoKullanim = new MemoEdit
            {
                Location = new Point(12, 88),
                Size = new Size(290, 70),
                Name = "memoKullanim"
            };
            memoKullanim.Properties.ReadOnly = true;
            memoKullanim.Properties.ScrollBars = ScrollBars.Vertical;

            var lblFay = new LabelControl { Text = "Kısa Açıklama", Location = new Point(12, 165) };
            memoFayda = new MemoEdit
            {
                Location = new Point(12, 185),
                Size = new Size(290, 50),
                Name = "memoFayda"
            };
            memoFayda.Properties.ReadOnly = true;
            memoFayda.Properties.ScrollBars = ScrollBars.Vertical;

            lblUyari = new LabelControl
            {
                Text = "",
                Location = new Point(12, 242),
                AutoSizeMode = LabelAutoSizeMode.None,
                Size = new Size(290, 28),
                Name = "lblUyari"
            };

            grpRecete.Controls.Add(lblReceteBaslik);
            grpRecete.Controls.Add(lblKul);
            grpRecete.Controls.Add(memoKullanim);
            grpRecete.Controls.Add(lblFay);
            grpRecete.Controls.Add(memoFayda);
            grpRecete.Controls.Add(lblUyari);

            grpUrunGiris.Controls.Add(lblAra);
            grpUrunGiris.Controls.Add(lkpUrunAra);
            grpUrunGiris.Controls.Add(grpRecete);

            BuildSepetToolbar();
            BuildAltBarExtras();

            grpUrunGiris.Resize += (s, e) =>
            {
                int w = Math.Max(260, grpUrunGiris.Width - 40);
                lkpUrunAra.Width = w;
                txtBarkod.Width = w;
                grpRecete.Width = w + 8;
                grpRecete.Height = Math.Max(180, grpUrunGiris.Height - grpRecete.Top - 16);
                memoKullanim.Width = grpRecete.Width - 30;
                memoFayda.Width = grpRecete.Width - 30;
                lblReceteBaslik.Width = grpRecete.Width - 30;
                lblUyari.Width = grpRecete.Width - 30;
            };
        }

        private void BuildSepetToolbar()
        {
            pnlSepetIslem = new PanelControl
            {
                Dock = DockStyle.Bottom,
                Height = 52,
                Name = "pnlSepetIslem",
                BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.NoBorder
            };

            btnUrunIptal = new SimpleButton
            {
                Text = "Ürün İptal",
                Location = new Point(12, 10),
                Size = new Size(110, 32),
                Name = "btnUrunIptal"
            };

            btnFisIptal = new SimpleButton
            {
                Text = "Fiş İptal",
                Location = new Point(130, 10),
                Size = new Size(100, 32),
                Name = "btnFisIptal"
            };

            btnEtiketYazdir = new SimpleButton
            {
                Text = "Etiket Yazdır",
                Location = new Point(238, 10),
                Size = new Size(120, 32),
                Name = "btnEtiketYazdir"
            };

            pnlSepetIslem.Controls.Add(btnUrunIptal);
            pnlSepetIslem.Controls.Add(btnFisIptal);
            pnlSepetIslem.Controls.Add(btnEtiketYazdir);

            pnlSepetIslem.Dock = DockStyle.Bottom;
            grpSepet.Controls.Add(pnlSepetIslem);
            gcSepet.Dock = DockStyle.Fill;
            gcSepet.SendToBack();
            pnlSepetIslem.BringToFront();
        }

        private void BuildAltBarExtras()
        {
            pnlAlt.Height = 96;

            chkEtiketYazdir = new CheckEdit
            {
                Text = "Satış sonrası kullanım etiketi yazdır",
                Location = new Point(20, 58),
                Size = new Size(280, 24),
                Name = "chkEtiketYazdir"
            };
            chkEtiketYazdir.Checked = true;
            pnlAlt.Controls.Add(chkEtiketYazdir);

            lblToplamBaslik.Location = new Point(20, 18);
            lblGenelToplam.Location = new Point(150, 8);
        }

        private void WireExtraEvents()
        {
            lkpUrunAra.EditValueChanged += lkpUrunAra_EditValueChanged;
            btnUrunIptal.Click += btnUrunIptal_Click;
            btnFisIptal.Click += btnFisIptal_Click;
            btnEtiketYazdir.Click += btnEtiketYazdir_Click;
            gvSepet.KeyDown += gvSepet_KeyDown;
        }

        private void ApplyTheme()
        {
            ModernTheme.ApplyModernButton(btnSepeteEkle, ModernTheme.Colors.Primary, true);
            ModernTheme.ApplyModernButton(btnSatisYap, ModernTheme.Colors.Success, true);
            ModernTheme.ApplyModernButton(btnUrunIptal, ModernTheme.Colors.Warning, true);
            ModernTheme.ApplyModernButton(btnFisIptal, ModernTheme.Colors.Danger, true);
            ModernTheme.ApplyModernButton(btnEtiketYazdir, ModernTheme.Colors.Olive, true);
            ModernTheme.ApplyModernGroup(grpUrunGiris);
            ModernTheme.ApplyModernGroup(grpSepet);
            if (grpRecete != null)
                ModernTheme.ApplyModernGroup(grpRecete);

            lblReceteBaslik.Appearance.ForeColor = ModernTheme.Colors.TextSecondary;
            lblReceteBaslik.Appearance.Options.UseForeColor = true;
            lblUyari.Appearance.ForeColor = ModernTheme.Colors.Terracotta;
            lblUyari.Appearance.Options.UseForeColor = true;
            lblUyari.Appearance.Font = ModernTheme.Typography.Caption;
            lblUyari.Appearance.Options.UseFont = true;
        }

        #endregion

        private void LoadUrunLookup()
        {
            try
            {
                _urunListe = InterfaceFactory.Urun.Listele(new UrunFiltreDto { Aktif = true })
                             ?? new List<UrunListeItemDto>();
                foreach (var u in _urunListe)
                    u.UrunAdi = TextHelper.FixEncoding(u.UrunAdi);

                lkpUrunAra.Properties.DataSource = _urunListe;
                lkpUrunAra.Properties.PopulateViewColumns();

                var view = lkpUrunAra.Properties.View;
                if (view != null)
                {
                    view.PopulateColumns();
                    foreach (DevExpress.XtraGrid.Columns.GridColumn col in view.Columns)
                        col.Visible = false;

                    if (view.Columns["UrunKod"] != null)
                    {
                        view.Columns["UrunKod"].Visible = true;
                        view.Columns["UrunKod"].Caption = "Kod";
                        view.Columns["UrunKod"].Width = 80;
                        view.Columns["UrunKod"].VisibleIndex = 0;
                    }
                    if (view.Columns["UrunAdi"] != null)
                    {
                        view.Columns["UrunAdi"].Visible = true;
                        view.Columns["UrunAdi"].Caption = "Ürün Adı";
                        view.Columns["UrunAdi"].Width = 180;
                        view.Columns["UrunAdi"].VisibleIndex = 1;
                    }
                    if (view.Columns["Barkod"] != null)
                    {
                        view.Columns["Barkod"].Visible = true;
                        view.Columns["Barkod"].Caption = "Barkod";
                        view.Columns["Barkod"].Width = 110;
                        view.Columns["Barkod"].VisibleIndex = 2;
                    }
                    if (view.Columns["SatisFiyati"] != null)
                    {
                        view.Columns["SatisFiyati"].Visible = true;
                        view.Columns["SatisFiyati"].Caption = "Fiyat";
                        view.Columns["SatisFiyati"].VisibleIndex = 3;
                    }

                    view.OptionsView.ShowGroupPanel = false;
                    lkpUrunAra.Properties.PopupView = view;
                }
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage("UcSatis.LoadUrunLookup: " + ex.Message, "SATIS");
            }
        }

        private void lkpUrunAra_EditValueChanged(object sender, EventArgs e)
        {
            if (lkpUrunAra.EditValue == null) return;
            int urunId;
            if (!int.TryParse(lkpUrunAra.EditValue.ToString(), out urunId)) return;

            var urun = InterfaceFactory.Urun.Getir(urunId);
            if (urun == null) return;

            if (!urun.SatisFiyati.HasValue || urun.SatisFiyati.Value <= 0)
            {
                MessageHelper.ShowWarning("Ürünün satış fiyatı tanımlı değil: " + TextHelper.FixEncoding(urun.UrunAdi));
                return;
            }

            SetAktifUrun(urun);
            SepeteEkle(urun, numMiktar.Value > 0 ? numMiktar.Value : 1m);
            txtBarkod.Focus();
        }

        public void AddProductByBarcode(string barkod)
        {
            if (string.IsNullOrWhiteSpace(barkod)) return;

            var urun = InterfaceFactory.Urun.GetirBarkod(barkod.Trim());
            if (urun != null)
            {
                if (!urun.SatisFiyati.HasValue || urun.SatisFiyati.Value <= 0)
                {
                    MessageHelper.ShowWarning("Ürünün satış fiyatı tanımlı değil: " + TextHelper.FixEncoding(urun.UrunAdi));
                    txtBarkod.Focus();
                    txtBarkod.SelectAll();
                    return;
                }

                SetAktifUrun(urun);
                SepeteEkle(urun, numMiktar.Value > 0 ? numMiktar.Value : 1m);
                txtBarkod.Text = "";
                // Sync lookup selection without re-adding
                lkpUrunAra.EditValueChanged -= lkpUrunAra_EditValueChanged;
                lkpUrunAra.EditValue = urun.UrunId;
                lkpUrunAra.EditValueChanged += lkpUrunAra_EditValueChanged;
                txtBarkod.Focus();
            }
            else
            {
                MessageHelper.ShowWarning("Ürün bulunamadı (barkod / kod / ad): " + barkod);
                txtBarkod.Focus();
                txtBarkod.SelectAll();
            }
        }

        private void txtBarkod_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                AddProductByBarcode(txtBarkod.Text.Trim());
                e.Handled = true;
                e.SuppressKeyPress = true;
            }
        }

        private void btnSepeteEkle_Click(object sender, EventArgs e)
        {
            if (_aktifUrun == null)
            {
                if (!string.IsNullOrWhiteSpace(txtBarkod.Text))
                {
                    AddProductByBarcode(txtBarkod.Text.Trim());
                }
                else
                {
                    MessageHelper.ShowWarning("Barkod okutun veya ürün adıyla arayın.");
                }
                return;
            }

            SepeteEkle(_aktifUrun, numMiktar.Value);
            txtBarkod.Focus();
            txtBarkod.SelectAll();
        }

        private void SetAktifUrun(UrunModel urun)
        {
            _aktifUrun = urun;
            var culture = new CultureInfo("tr-TR");
            lblUrunAdi.Text = TextHelper.FixEncoding(urun.UrunAdi);
            lblFiyat.Text = string.Format(
                culture,
                "{0:C2}  •  {1}",
                urun.SatisFiyati ?? 0m,
                string.IsNullOrWhiteSpace(urun.Barkod) ? urun.UrunKod : urun.Barkod);

            LoadAiRecete(urun.UrunId, TextHelper.FixEncoding(urun.UrunAdi));
        }

        private void ClearAktifUrun()
        {
            _aktifUrun = null;
            lblUrunAdi.Text = "Ürün Seçilmedi";
            lblFiyat.Text = "0,00 ₺";
            lblReceteBaslik.Text = "Ürün seçildiğinde kullanım oranı burada görünür.";
            memoKullanim.Text = "";
            memoFayda.Text = "";
            lblUyari.Text = "";
            lkpUrunAra.EditValueChanged -= lkpUrunAra_EditValueChanged;
            lkpUrunAra.EditValue = null;
            lkpUrunAra.EditValueChanged += lkpUrunAra_EditValueChanged;
        }

        private void LoadAiRecete(int urunId, string urunAdi)
        {
            try
            {
                var icerik = InterfaceFactory.Ai.IcerikGetir(urunId);
                if (icerik == null || string.IsNullOrWhiteSpace(icerik.Icerik))
                {
                    lblReceteBaslik.Text = urunAdi + " — onaylı AI içeriği yok";
                    memoKullanim.Text = "Bu ürün için onaylanmış kullanım tarifi bulunamadı.\nAI İçerik Asistanı’ndan üretip onaylayabilirsiniz.";
                    memoFayda.Text = "";
                    lblUyari.Text = "";
                    return;
                }

                var parsed = ParseAiContent(TextHelper.FixEncoding(icerik.Icerik));
                lblReceteBaslik.Text = string.Format("{0} — Onaylı tarif", urunAdi);

                memoKullanim.Text = !string.IsNullOrWhiteSpace(parsed.Kullanim)
                    ? parsed.Kullanim
                    : "Kullanım / oran bilgisi tanımlı değil.";

                memoFayda.Text = !string.IsNullOrWhiteSpace(parsed.Aciklama)
                    ? parsed.Aciklama
                    : "";

                if (!string.IsNullOrWhiteSpace(parsed.Uyari))
                    lblUyari.Text = "⚠ " + parsed.Uyari;
                else if (!string.IsNullOrWhiteSpace(parsed.Kombinasyon))
                    lblUyari.Text = "Birlikte: " + parsed.Kombinasyon;
                else
                    lblUyari.Text = "";
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage("LoadAiRecete: " + ex.Message, "SATIS");
                lblReceteBaslik.Text = "AI içerik okunamadı";
                memoKullanim.Text = "";
                memoFayda.Text = "";
                lblUyari.Text = "";
            }
        }

        private class AiJson
        {
            [JsonProperty("fayda")]
            public string Fayda { get; set; }
            [JsonProperty("kullanim")]
            public string Kullanim { get; set; }
            [JsonProperty("uyari")]
            public string Uyari { get; set; }
            [JsonProperty("kombinasyon")]
            public string Kombinasyon { get; set; }
            [JsonProperty("aciklama")]
            public string Aciklama { get; set; }
            [JsonProperty("baslik")]
            public string Baslik { get; set; }
        }

        private class ParsedAi
        {
            public string Aciklama { get; set; }
            public string Kullanim { get; set; }
            public string Uyari { get; set; }
            public string Kombinasyon { get; set; }
        }

        private ParsedAi ParseAiContent(string raw)
        {
            var result = new ParsedAi();
            if (string.IsNullOrWhiteSpace(raw))
                return result;

            try
            {
                var json = ExtractJson(raw);
                var obj = JsonConvert.DeserializeObject<AiJson>(json);
                if (obj != null)
                {
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
                // plain text
            }

            result.Aciklama = TextHelper.FixEncoding(raw);
            return result;
        }

        private static string ExtractJson(string text)
        {
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

        private void SepeteEkle(UrunModel urun, decimal miktar)
        {
            var existing = _sepet.FirstOrDefault(x => x.UrunId == urun.UrunId);
            if (existing != null)
            {
                existing.Miktar += miktar;
            }
            else
            {
                _sepet.Add(new SepetItem
                {
                    UrunId = urun.UrunId,
                    UrunAdi = TextHelper.FixEncoding(urun.UrunAdi),
                    SatisFiyati = urun.SatisFiyati ?? 0,
                    Miktar = miktar
                });
            }
            RefreshSepet();
        }

        private void RefreshSepet()
        {
            gcSepet.DataSource = null;
            gcSepet.DataSource = _sepet;
            gcSepet.RefreshDataSource();

            decimal total = _sepet.Sum(x => x.ToplamTutar);
            lblGenelToplam.Text = string.Format(CultureInfo.GetCultureInfo("tr-TR"), "{0:C2}", total);

            GridHelper.ApplyStandardFormatting(gvSepet);
            GridHelper.FormatQuantityColumn(colMiktar);
            gvSepet.BestFitColumns();
        }

        private void btnUrunIptal_Click(object sender, EventArgs e)
        {
            UrunIptal();
        }

        private void btnFisIptal_Click(object sender, EventArgs e)
        {
            FisIptal();
        }

        private void btnEtiketYazdir_Click(object sender, EventArgs e)
        {
            if (_sepet.Count == 0)
            {
                MessageHelper.ShowWarning("Yazdırılacak ürün yok. Önce sepete ekleyin.");
                return;
            }

            var focused = gvSepet.GetFocusedRow() as SepetItem;
            if (focused != null)
            {
                YazdirEtiketler(new List<SepetItem> { focused });
            }
            else
            {
                YazdirEtiketler(_sepet.ToList());
            }
        }

        private void gvSepet_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Delete)
            {
                UrunIptal();
                e.Handled = true;
            }
            else if (e.KeyCode == Keys.Escape)
            {
                FisIptal();
                e.Handled = true;
            }
        }

        private void UrunIptal()
        {
            var item = gvSepet.GetFocusedRow() as SepetItem;
            if (item == null)
            {
                MessageHelper.ShowWarning("İptal edilecek ürünü sepette seçin.");
                return;
            }

            if (!MessageHelper.ShowConfirmation(
                string.Format("\"{0}\" sepetten çıkarılsın mı?", item.UrunAdi)))
                return;

            _sepet.Remove(item);
            RefreshSepet();
            if (_aktifUrun != null && _aktifUrun.UrunId == item.UrunId)
                ClearAktifUrun();
            txtBarkod.Focus();
        }

        private void FisIptal()
        {
            if (_sepet.Count == 0)
            {
                ClearAktifUrun();
                txtBarkod.Focus();
                return;
            }

            if (!MessageHelper.ShowConfirmation("Fiş iptal edilsin mi? Sepetteki tüm ürünler silinecek."))
                return;

            _sepet.Clear();
            RefreshSepet();
            ClearAktifUrun();
            txtBarkod.Focus();
        }

        private void YazdirEtiketler(IList<SepetItem> items)
        {
            if (items == null || items.Count == 0)
                return;

            var culture = CultureInfo.GetCultureInfo("tr-TR");
            var labels = new List<KullanimEtiketPrinter.EtiketModel>();

            foreach (var item in items)
            {
                var parsed = GetAiForUrun(item.UrunId);
                labels.Add(new KullanimEtiketPrinter.EtiketModel
                {
                    UrunAdi = item.UrunAdi,
                    MiktarText = string.Format(culture, "{0:0.###}", item.Miktar),
                    Kullanim = !string.IsNullOrWhiteSpace(parsed.Kullanim)
                        ? parsed.Kullanim
                        : "Onaylı kullanım tarifi bulunamadı.",
                    Aciklama = parsed.Aciklama,
                    Uyari = parsed.Uyari
                });
            }

            KullanimEtiketPrinter.PrintLabels(labels, showPrinterDialog: true);
        }

        private ParsedAi GetAiForUrun(int urunId)
        {
            try
            {
                var icerik = InterfaceFactory.Ai.IcerikGetir(urunId);
                if (icerik == null || string.IsNullOrWhiteSpace(icerik.Icerik))
                    return new ParsedAi();
                return ParseAiContent(TextHelper.FixEncoding(icerik.Icerik));
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage("GetAiForUrun: " + ex.Message, "SATIS");
                return new ParsedAi();
            }
        }

        private void btnSatisYap_Click(object sender, EventArgs e)
        {
            if (_sepet.Count == 0)
            {
                MessageHelper.ShowWarning("Sepet boş.");
                return;
            }

            if (!MessageHelper.ShowConfirmation("Satışı onaylıyor musunuz?"))
                return;

            try
            {
                var model = new SatisModel
                {
                    OdemeTip = "NAKIT",
                    KullaniciId = SessionManager.IsAuthenticated ? (int?)SessionManager.KullaniciId : null,
                    Aciklama = "Perakende Satış"
                };

                foreach (var item in _sepet)
                {
                    model.Detaylar.Add(new SatisDetayModel
                    {
                        UrunId = item.UrunId,
                        UrunAdi = item.UrunAdi,
                        Miktar = item.Miktar,
                        BirimFiyat = item.SatisFiyati,
                        Tutar = item.ToplamTutar
                    });
                }

                // Etiket için sepet kopyası (temizlemeden önce)
                var etiketKaynak = _sepet.ToList();
                bool etiketYaz = chkEtiketYazdir != null && chkEtiketYazdir.Checked;

                var result = InterfaceFactory.Satis.SatisKaydet(model);
                if (result != null)
                {
                    MessageHelper.ShowError(result);
                    return;
                }

                MessageHelper.ShowInfo("Satış başarıyla tamamlandı.");
                _sepet.Clear();
                RefreshSepet();
                ClearAktifUrun();

                if (etiketYaz)
                    YazdirEtiketler(etiketKaynak);

                txtBarkod.Focus();
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage("Satış Hatası: " + ex.Message, "SATIS");
                MessageHelper.ShowError("İşlem sırasında beklenmeyen bir hata oluştu.");
            }
        }
    }

    public class SepetItem
    {
        public int UrunId { get; set; }
        public string UrunAdi { get; set; }
        public decimal Miktar { get; set; }
        public decimal SatisFiyati { get; set; }
        public decimal ToplamTutar { get { return Miktar * SatisFiyati; } }
    }
}
