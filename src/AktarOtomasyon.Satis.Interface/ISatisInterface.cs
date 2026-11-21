namespace AktarOtomasyon.Satis.Interface
{
    public interface ISatisInterface
    {
        /// <summary>
        /// Satış fişini kaydeder. null = başarı, mesaj = hata.
        /// </summary>
        string SatisKaydet(SatisModel model);
    }
}
