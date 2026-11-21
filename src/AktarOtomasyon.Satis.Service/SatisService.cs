using System;
using System.Data;
using System.Data.SqlClient;
using AktarOtomasyon.Satis.Interface;
using AktarOtomasyon.Util.DataAccess;

namespace AktarOtomasyon.Satis.Service
{
    public class SatisService : ISatisInterface
    {
        public string SatisKaydet(SatisModel model)
        {
            try
            {
                if (model == null)
                    return "Satış modeli boş olamaz.";
                if (model.Detaylar == null || model.Detaylar.Count == 0)
                    return "Sepet boş.";

                foreach (var detay in model.Detaylar)
                {
                    if (detay.UrunId <= 0)
                        return "Geçersiz ürün.";
                    if (detay.Miktar <= 0)
                        return "Miktar sıfırdan büyük olmalıdır.";
                    if (detay.BirimFiyat < 0)
                        return "Birim fiyat negatif olamaz.";
                }

                using (var sMan = new SqlManager())
                {
                    var detayTable = new DataTable();
                    detayTable.Columns.Add("urun_id", typeof(int));
                    detayTable.Columns.Add("miktar", typeof(decimal));
                    detayTable.Columns.Add("birim_fiyat", typeof(decimal));

                    foreach (var detay in model.Detaylar)
                    {
                        detayTable.Rows.Add(detay.UrunId, detay.Miktar, detay.BirimFiyat);
                    }

                    var cmd = sMan.CreateCommand("sp_satis_kaydet", CommandType.StoredProcedure);
                    cmd.Parameters.Add(new SqlParameter("@odeme_tip", SqlDbType.NVarChar, 20)
                    {
                        Value = string.IsNullOrWhiteSpace(model.OdemeTip) ? "NAKIT" : model.OdemeTip
                    });
                    cmd.Parameters.Add(new SqlParameter("@kullanici_id", SqlDbType.Int)
                    {
                        Value = model.KullaniciId.HasValue ? (object)model.KullaniciId.Value : DBNull.Value
                    });
                    cmd.Parameters.Add(new SqlParameter("@aciklama", SqlDbType.NVarChar, 500)
                    {
                        Value = string.IsNullOrWhiteSpace(model.Aciklama) ? (object)DBNull.Value : model.Aciklama
                    });

                    var tvp = new SqlParameter("@detaylar", SqlDbType.Structured)
                    {
                        TypeName = "dbo.SatisDetayTip",
                        Value = detayTable
                    };
                    cmd.Parameters.Add(tvp);

                    var output = new SqlParameter("@satis_id", SqlDbType.Int)
                    {
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(output);

                    sMan.ExecuteNonQuery(cmd);

                    if (output.Value != null && output.Value != DBNull.Value)
                        model.SatisId = Convert.ToInt32(output.Value);

                    return null;
                }
            }
            catch (SqlException sqlEx)
            {
                return sqlEx.Message;
            }
            catch (Exception ex)
            {
                return "Satış kaydedilemedi: " + ex.Message;
            }
        }
    }
}
