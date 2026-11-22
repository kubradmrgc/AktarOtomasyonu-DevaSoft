using System;

namespace AktarOtomasyon.Ai.Interface
{
    public class AiIcerikModel
    {
        public int IcerikId { get; set; }
        public int UrunId { get; set; }
        public string Icerik { get; set; }
        public string Durum { get; set; } // Taslak, OnayBekliyor, Aktif
        public string Kaynaklar { get; set; }
        public string SablonKod { get; set; }
        public string Provider { get; set; }
        public int? KullaniciId { get; set; }
        public DateTime OlusturmaTarih { get; set; }
        public int? OnaylayanKullaniciId { get; set; }
        public DateTime? OnayTarih { get; set; }
    }

    public class AiIcerikVersiyonModel
    {
        public int VersiyonId { get; set; }
        public int IcerikId { get; set; }
        public int VersiyonNo { get; set; }
        public string Icerik { get; set; }
        public DateTime OlusturmaTarih { get; set; }
    }

    public class AiSablonModel
    {
        public int SablonId { get; set; }
        public string SablonKod { get; set; }
        public string SablonAdi { get; set; }
        public string PromptSablonu { get; set; }
        public string Aciklama { get; set; }
        public bool Aktif { get; set; }
        public DateTime OlusturmaTarih { get; set; }
        public DateTime? GuncellemeTarih { get; set; }
    }

    public class AiSablonListModel
    {
        public int SablonId { get; set; }
        public string SablonKod { get; set; }
        public string SablonAdi { get; set; }
        public string Aciklama { get; set; }
        public bool Aktif { get; set; }
    }

    public class AiUrunBilgiModel
    {
        public int UrunId { get; set; }
        public string UrunKod { get; set; }
        public string UrunAdi { get; set; }
        public string KategoriAdi { get; set; }
        public string BirimAdi { get; set; }
        public decimal? SatisFiyati { get; set; }
        public string Aciklama { get; set; }
    }

    /// <summary>
    /// AI içerik kuyruk satırı (AI_ICERIK paneli).
    /// </summary>
    public class AiIcerikListeDto
    {
        public int IcerikId { get; set; }
        public int UrunId { get; set; }
        public string UrunKod { get; set; }
        public string UrunAdi { get; set; }
        public string KategoriAdi { get; set; }
        public string SablonKod { get; set; }
        public string SablonAdi { get; set; }
        public string Durum { get; set; }
        public string Icerik { get; set; }
        public string Kaynaklar { get; set; }
        public string Provider { get; set; }
        public DateTime OlusturmaTarih { get; set; }
        public DateTime? OnayTarih { get; set; }

        public string DurumText
        {
            get
            {
                if (string.Equals(Durum, "AKTIF", StringComparison.OrdinalIgnoreCase))
                    return "Onaylandı";
                if (string.Equals(Durum, "REDDEDILDI", StringComparison.OrdinalIgnoreCase))
                    return "Reddedildi";
                return "Onay Bekliyor";
            }
        }

        public string MetaText
        {
            get
            {
                var sablon = string.IsNullOrWhiteSpace(SablonAdi) ? (SablonKod ?? "İçerik") : SablonAdi;
                return string.Format("{0} • {1}", sablon, FormatRelativeTime(OlusturmaTarih));
            }
        }

        private static string FormatRelativeTime(DateTime dt)
        {
            var span = DateTime.Now - dt;
            if (span.TotalMinutes < 60)
                return string.Format("{0:HH:mm}", dt);
            if (span.TotalHours < 24 && dt.Date == DateTime.Today)
                return string.Format("{0:HH:mm}", dt);
            if (dt.Date == DateTime.Today.AddDays(-1))
                return string.Format("Dün {0:HH:mm}", dt);
            return dt.ToString("dd.MM.yyyy HH:mm");
        }
    }
}
