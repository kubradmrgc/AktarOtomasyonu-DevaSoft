using AktarOtomasyon.Util.DataAccess;

namespace AktarOtomasyon.Forms.Common
{
    /// <summary>
    /// Metin işlemleri için yardımcı sınıf.
    /// Encoding sorunlarını düzeltmek için kullanılır.
    /// </summary>
    public static class TextHelper
    {
        /// <summary>
        /// Bozuk karakterli (UTF-8 byte'ları Windows-1252 olarak okunmuş) metinleri düzeltir.
        /// Örnek: "DoÄŸal" -> "Doğal", "ÃœrÃ¼n" -> "Ürün"
        /// </summary>
        public static string FixEncoding(string text)
        {
            return EncodingHelper.FixUtf8Mojibake(text);
        }
    }
}
