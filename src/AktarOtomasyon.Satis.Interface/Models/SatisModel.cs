using System;
using System.Collections.Generic;

namespace AktarOtomasyon.Satis.Interface
{
    public class SatisModel
    {
        public int SatisId { get; set; }
        public string SatisNo { get; set; }
        public DateTime SatisTarih { get; set; }
        public decimal ToplamTutar { get; set; }
        public string OdemeTip { get; set; }
        public int? KullaniciId { get; set; }
        public string Aciklama { get; set; }
        public List<SatisDetayModel> Detaylar { get; set; }

        public SatisModel()
        {
            Detaylar = new List<SatisDetayModel>();
            OdemeTip = "NAKIT";
            SatisTarih = DateTime.Now;
        }
    }

    public class SatisDetayModel
    {
        public int DetayId { get; set; }
        public int SatisId { get; set; }
        public int UrunId { get; set; }
        public string UrunAdi { get; set; }
        public decimal Miktar { get; set; }
        public decimal BirimFiyat { get; set; }
        public decimal Tutar { get; set; }
    }
}
