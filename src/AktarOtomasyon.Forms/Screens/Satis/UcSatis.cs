using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using AktarOtomasyon.Forms.Base;
using AktarOtomasyon.Forms.Common;
using AktarOtomasyon.Forms.Managers;
using AktarOtomasyon.Satis.Interface;
using AktarOtomasyon.Urun.Interface;

namespace AktarOtomasyon.Forms.Screens.Satis
{
    public partial class UcSatis : UcBase
    {
        private List<SepetItem> _sepet = new List<SepetItem>();
        private UrunModel _aktifUrun = null;

        public UcSatis()
        {
            InitializeComponent();
        }

        public override void LoadData()
        {
            _sepet.Clear();
            RefreshSepet();
            txtBarkod.Focus();
        }

        public void AddProductByBarcode(string barkod)
        {
            if (string.IsNullOrWhiteSpace(barkod)) return;

            var urun = InterfaceFactory.Urun.GetirBarkod(barkod);
            if (urun != null)
            {
                SetAktifUrun(urun);
                SepeteEkle(urun, 1);
            }
            else
            {
                MessageHelper.ShowWarning("Ürün bulunamadı: " + barkod);
                txtBarkod.Text = "";
                txtBarkod.Focus();
            }
        }

        private void txtBarkod_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                AddProductByBarcode(txtBarkod.Text.Trim());
                txtBarkod.Text = "";
                e.Handled = true;
                e.SuppressKeyPress = true; // Prevent beep
            }
        }

        private void btnSepeteEkle_Click(object sender, EventArgs e)
        {
             if (_aktifUrun == null)
            {
                // Try from textbox if not loaded
                if(!string.IsNullOrWhiteSpace(txtBarkod.Text))
                {
                    AddProductByBarcode(txtBarkod.Text.Trim());
                    txtBarkod.Text = "";
                }
                else
                {
                    MessageHelper.ShowWarning("Lütfen barkod okutun veya ürün seçin.");
                }
                return;
            }

            SepeteEkle(_aktifUrun, numMiktar.Value);
            // Reset active product after add? Maybe keep it for multiple adds.
            // Let's reset input focus
            txtBarkod.Focus();
            txtBarkod.SelectAll();
        }

        private void SetAktifUrun(UrunModel urun)
        {
            _aktifUrun = urun;
            lblUrunAdi.Text = TextHelper.FixEncoding(urun.UrunAdi);
            lblFiyat.Text = string.Format("{0:C2}", urun.SatisFiyati);

            // Gorsel Yukle (Basit version)
            // UcUrunKatalog'daki logic benzeri
            // (Placeholder for simplicity, can enhance later)
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
            gcSepet.DataSource = null; // Reset
            gcSepet.DataSource = _sepet;
            gcSepet.RefreshDataSource();

            decimal total = _sepet.Sum(x => x.ToplamTutar);
            lblGenelToplam.Text = string.Format("{0:C2}", total);

            // Format Grid
            GridHelper.ApplyStandardFormatting(gvSepet);
            GridHelper.FormatQuantityColumn(colMiktar);
            
            // Auto width
            gvSepet.BestFitColumns();
        }

        private void btnSatisYap_Click(object sender, EventArgs e)
        {
            if (_sepet.Count == 0)
            {
                MessageHelper.ShowWarning("Sepet boş.");
                return;
            }

            if (MessageHelper.ShowConfirmation("Satışı onaylıyor musunuz?"))
            {
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

                    var result = InterfaceFactory.Satis.SatisKaydet(model);
                    if (result != null)
                    {
                        MessageHelper.ShowError(result);
                        return;
                    }

                    MessageHelper.ShowInfo("Satış başarıyla tamamlandı.");
                    _sepet.Clear();
                    RefreshSepet();
                    _aktifUrun = null;
                    lblUrunAdi.Text = "Ürün Seçilmedi";
                    lblFiyat.Text = "0,00 ₺";
                }
                catch (Exception ex)
                {
                    ErrorManager.LogMessage("Satış Hatası: " + ex.Message, "SATIS");
                    MessageHelper.ShowError("İşlem sırasında beklenmeyen bir hata oluştu.");
                }
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
