using System;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace AktarOtomasyon.Util.DataAccess
{
    /// <summary>
    /// UTF-8 baytların yanlış codepage ile Unicode'a yazılmasından oluşan mojibake düzeltmesi.
    /// Desteklenen bozulmalar:
    /// - Windows-1252: "ÃœrÃ¼n" → "Ürün", "SipariÅŸ" → "Sipariş"
    /// - Latin-1 / byte-as-char: "Å\u009eekerlemeler" → "Şekerlemeler" (Ş = UTF-8 C5 9E)
    /// </summary>
    public static class EncodingHelper
    {
        private static readonly Regex MojibakeHint = new Regex(
            @"[ÃÂÅÆÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ\u0080-\u009F]",
            RegexOptions.Compiled);

        private static readonly char[] TurkishLetters = "ğüşıöçĞÜŞİÖÇ".ToCharArray();

        public static string FixUtf8Mojibake(string text)
        {
            if (string.IsNullOrEmpty(text))
                return text;

            // Zaten düzgün Türkçe ve mojibake ipucu yoksa dokunma
            if (!MojibakeHint.IsMatch(text) && CountTurkish(text) > 0)
                return text;

            string best = text;
            int bestScore = Score(text);

            TryCandidate(ref best, ref bestScore, DecodeLatin1BytesAsUtf8(text));
            TryCandidate(ref best, ref bestScore, DecodeCodepageAsUtf8(text, 1252));
            TryCandidate(ref best, ref bestScore, DecodeCodepageAsUtf8(text, 28591)); // ISO-8859-1

            return best;
        }

        private static void TryCandidate(ref string best, ref int bestScore, string candidate)
        {
            if (string.IsNullOrEmpty(candidate) || candidate == best)
                return;
            int score = Score(candidate);
            if (score > bestScore)
            {
                best = candidate;
                bestScore = score;
            }
        }

        /// <summary>
        /// Her Unicode codepoint'i (0-255) ham bayt kabul edip UTF-8 çözer.
        /// SQL/seed Latin-1 bozulması için: Ş (C5 9E) → U+00C5 + U+009E
        /// </summary>
        private static string DecodeLatin1BytesAsUtf8(string text)
        {
            if (text.Any(c => c > 0xFF))
                return null;

            try
            {
                var bytes = new byte[text.Length];
                for (int i = 0; i < text.Length; i++)
                    bytes[i] = (byte)text[i];

                var utf8 = Encoding.GetEncoding("utf-8",
                    EncoderFallback.ExceptionFallback,
                    DecoderFallback.ExceptionFallback);
                return utf8.GetString(bytes);
            }
            catch
            {
                return null;
            }
        }

        private static string DecodeCodepageAsUtf8(string text, int codepage)
        {
            try
            {
                var src = Encoding.GetEncoding(codepage,
                    EncoderFallback.ExceptionFallback,
                    DecoderFallback.ExceptionFallback);
                var utf8 = Encoding.GetEncoding("utf-8",
                    EncoderFallback.ExceptionFallback,
                    DecoderFallback.ExceptionFallback);
                return utf8.GetString(src.GetBytes(text));
            }
            catch
            {
                return null;
            }
        }

        private static int CountTurkish(string text)
        {
            int n = 0;
            foreach (var c in text)
            {
                if (TurkishLetters.Contains(c))
                    n++;
            }
            return n;
        }

        private static int Score(string text)
        {
            if (string.IsNullOrEmpty(text))
                return int.MinValue;

            int score = 0;
            score += CountTurkish(text) * 20;

            // Mojibake / kontrol karakterleri cezası
            foreach (var c in text)
            {
                if (c >= 0x80 && c <= 0x9F)
                    score -= 50;
                if (c == 'Ã' || c == 'Â' || c == 'Å')
                    score -= 15;
                if (c == '\uFFFD')
                    score -= 40;
            }

            if (MojibakeHint.IsMatch(text))
                score -= 10;

            return score;
        }

        public static string GetString(DataRow row, string column)
        {
            if (row == null || string.IsNullOrEmpty(column) || !row.Table.Columns.Contains(column))
                return null;
            if (row[column] == DBNull.Value)
                return null;
            return FixUtf8Mojibake(Convert.ToString(row[column]));
        }

        public static string GetString(object value)
        {
            if (value == null || value == DBNull.Value)
                return null;
            return FixUtf8Mojibake(Convert.ToString(value));
        }
    }
}
