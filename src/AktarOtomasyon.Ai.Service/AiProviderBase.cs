using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using AktarOtomasyon.Ai.Interface;
using AktarOtomasyon.Util.DataAccess;

namespace AktarOtomasyon.Ai.Service
{
    /// <summary>
    /// AI Provider temel sınıfı.
    /// KURAL: Provider değişimi sadece config ile yapılabilir.
    /// KURAL: Gizli anahtarlar environment variable ile tutulur.
    /// </summary>
    public abstract class AiProviderBase
    {
        protected string ApiKey { get; private set; }
        protected string Model { get; private set; }
        protected int TimeoutSeconds { get; private set; }
        protected int MaxRetry { get; private set; }

        protected AiProviderBase()
        {
            // Öncelik: ortam değişkeni → yerel gizli dosya → App.config
            ApiKey = ResolveApiKey();

            Model = Environment.GetEnvironmentVariable("AI_MODEL")
                    ?? ConfigurationManager.AppSettings["AI_MODEL"]
                    ?? "gemini-2.0-flash";

            var timeoutStr = ConfigurationManager.AppSettings["AI_TIMEOUT_SECONDS"];
            int t;
            TimeoutSeconds = int.TryParse(timeoutStr, out t) ? t : 60;

            var retryStr = ConfigurationManager.AppSettings["AI_MAX_RETRY"];
            int r;
            MaxRetry = int.TryParse(retryStr, out r) ? r : 2;
        }

        private static string ResolveApiKey()
        {
            var key = CleanApiKey(Environment.GetEnvironmentVariable("AI_API_KEY"));
            if (!string.IsNullOrEmpty(key))
                return key;

            key = CleanApiKey(ReadLocalApiKeyFile());
            if (!string.IsNullOrEmpty(key))
                return key;

            return CleanApiKey(ConfigurationManager.AppSettings["AI_API_KEY"]);
        }

        private static string CleanApiKey(string raw)
        {
            if (string.IsNullOrWhiteSpace(raw))
                return null;

            var key = raw.Trim().Trim('"').Trim('\'');
            if (key.Length == 0)
                return null;

            // Placeholder / örnek değerler
            var upper = key.ToUpperInvariant();
            if (upper.Contains("YOUR_") || upper.Contains("PLACEHOLDER") || upper == "CHANGEME"
                || upper == "API_KEY" || upper == "GEMINI_API_KEY")
                return null;

            return key;
        }

        private static string ReadLocalApiKeyFile()
        {
            try
            {
                var baseDir = AppDomain.CurrentDomain.BaseDirectory;
                var candidates = new[]
                {
                    System.IO.Path.Combine(baseDir, "App_Data", "ai.local.key"),
                    System.IO.Path.Combine(baseDir, "ai.local.key"),
                    System.IO.Path.Combine(baseDir, "..", "..", "..", "App_Data", "ai.local.key")
                };

                foreach (var path in candidates)
                {
                    var full = System.IO.Path.GetFullPath(path);
                    if (!System.IO.File.Exists(full))
                        continue;
                    var text = System.IO.File.ReadAllText(full);
                    if (string.IsNullOrWhiteSpace(text))
                        continue;
                    // İlk satır veya AI_API_KEY=... formatı
                    foreach (var line in text.Split(new[] { '\r', '\n' }, StringSplitOptions.RemoveEmptyEntries))
                    {
                        var trimmed = line.Trim();
                        if (trimmed.StartsWith("#"))
                            continue;
                        if (trimmed.StartsWith("AI_API_KEY=", StringComparison.OrdinalIgnoreCase))
                            return trimmed.Substring("AI_API_KEY=".Length).Trim();
                        return trimmed;
                    }
                }
            }
            catch
            {
                // ignore file read errors
            }
            return null;
        }

        /// <summary>
        /// Config'e göre doğru provider'ı döndürür.
        /// </summary>
        public static AiProviderBase GetProvider()
        {
            var provider = Environment.GetEnvironmentVariable("AI_PROVIDER")
                           ?? ConfigurationManager.AppSettings["AI_PROVIDER"]
                           ?? "GEMINI";

            switch (provider.ToUpperInvariant())
            {
                case "OPENAI":
                    return new OpenAiProvider();
                case "LOCAL":
                    return new LocalAiProvider();
                case "GEMINI":
                default:
                    return new GeminiProvider();
            }
        }

        /// <summary>
        /// İçerik üretir.
        /// </summary>
        public abstract AiUretimSonuc Generate(int urunId, string sablonKod);

        /// <summary>
        /// Retrieves product information for AI context building.
        /// </summary>
        protected AiUrunBilgiModel GetUrunBilgi(int urunId)
        {
            try
            {
                using (var sMan = new SqlManager())
                {
                    var cmd = sMan.CreateCommand("sp_ai_urun_bilgi_getir", CommandType.StoredProcedure);
                    cmd.Parameters.Add(new SqlParameter("@urun_id", SqlDbType.Int) { Value = urunId });

                    var dt = sMan.ExecuteQuery(cmd);
                    if (dt.Rows.Count == 0)
                        return null;

                    var row = dt.Rows[0];
                    return new AiUrunBilgiModel
                    {
                        UrunId = Convert.ToInt32(row["urun_id"]),
                        UrunKod = row["urun_kod"].ToString(),
                        UrunAdi = row["urun_adi"].ToString(),
                        KategoriAdi = row["kategori_adi"] != DBNull.Value ? row["kategori_adi"].ToString() : null,
                        BirimAdi = row["birim_adi"] != DBNull.Value ? row["birim_adi"].ToString() : null,
                        SatisFiyati = row["satis_fiyati"] != DBNull.Value ? Convert.ToDecimal(row["satis_fiyati"]) : (decimal?)null,
                        Aciklama = row["aciklama"] != DBNull.Value ? row["aciklama"].ToString() : null
                    };
                }
            }
            catch (Exception)
            {
                return null;
            }
        }

        /// <summary>
        /// Retrieves template and builds prompt with product context.
        /// </summary>
        protected string BuildPrompt(int urunId, string sablonKod)
        {
            try
            {
                // Get template
                AiSablonModel sablon;
                using (var sMan = new SqlManager())
                {
                    var cmd = sMan.CreateCommand("sp_ai_sablon_getir", CommandType.StoredProcedure);
                    cmd.Parameters.Add(new SqlParameter("@sablon_kod", SqlDbType.NVarChar, 50)
                        { Value = sablonKod });

                    var dt = sMan.ExecuteQuery(cmd);
                    if (dt.Rows.Count == 0)
                        return null;

                    var row = dt.Rows[0];
                    sablon = new AiSablonModel
                    {
                        PromptSablonu = row["prompt_sablonu"].ToString()
                    };
                }

                // Get product data
                var urun = GetUrunBilgi(urunId);
                if (urun == null)
                    return null;

                // Replace placeholders
                var prompt = sablon.PromptSablonu
                    .Replace("{URUN_ADI}", urun.UrunAdi ?? "")
                    .Replace("{URUN_KOD}", urun.UrunKod ?? "")
                    .Replace("{KATEGORI}", urun.KategoriAdi ?? "")
                    .Replace("{BIRIM}", urun.BirimAdi ?? "")
                    .Replace("{FIYAT}", urun.SatisFiyati.HasValue ? urun.SatisFiyati.Value.ToString("N2") : "")
                    .Replace("{ACIKLAMA}", urun.Aciklama ?? "");

                return prompt;
            }
            catch (Exception)
            {
                return null;
            }
        }
    }

    /// <summary>
    /// Google Gemini provider.
    /// </summary>
    public class GeminiProvider : AiProviderBase
    {
        // v1beta: güncel flash modelleri için daha uyumlu
        private const string GEMINI_API_ENDPOINT = "https://generativelanguage.googleapis.com/v1beta/models/{0}:generateContent?key={1}";

        public override AiUretimSonuc Generate(int urunId, string sablonKod)
        {
            try
            {
                // 1. Validate API key
                if (string.IsNullOrWhiteSpace(ApiKey))
                {
                    return new AiUretimSonuc
                    {
                        Basarili = false,
                        Hata = "Geçerli Gemini API anahtarı yok.\n\n"
                             + "1) Ortam değişkeni: setx AI_API_KEY \"AIza...\"\n"
                             + "2) veya dosya: App_Data\\ai.local.key (tek satır anahtar)\n"
                             + "3) Google AI Studio: https://aistudio.google.com/apikey\n\n"
                             + "App.config içindeki YOUR_GEMINI_API_KEY / boş değer kullanılmaz."
                    };
                }

                // 2. Build prompt from template + product data
                var prompt = BuildPrompt(urunId, sablonKod);
                if (string.IsNullOrWhiteSpace(prompt))
                {
                    return new AiUretimSonuc
                    {
                        Basarili = false,
                        Hata = string.Format("Şablon '{0}' bulunamadı veya ürün bilgisi eksik.", sablonKod)
                    };
                }

                // 3. Call Gemini API with retry logic
                string icerik = null;
                string lastError = null;

                for (int retry = 0; retry <= MaxRetry; retry++)
                {
                    try
                    {
                        icerik = CallGeminiApi(prompt);
                        if (!string.IsNullOrWhiteSpace(icerik))
                            break; // Success
                    }
                    catch (Exception ex)
                    {
                        lastError = ex.Message;
                        // Geçersiz anahtar / model gibi kalıcı hatalarda tekrar deneme
                        var msg = (ex.Message ?? string.Empty).ToUpperInvariant();
                        if (msg.Contains("API_KEY_INVALID") || msg.Contains("API KEY NOT VALID")
                            || msg.Contains("INVALID_ARGUMENT") || msg.Contains("PERMISSION_DENIED")
                            || msg.Contains("NOT_FOUND"))
                        {
                            break;
                        }
                        if (retry < MaxRetry)
                        {
                            System.Threading.Thread.Sleep(1000 * (retry + 1)); // Progressive backoff
                        }
                    }
                }

                if (string.IsNullOrWhiteSpace(icerik))
                {
                    return new AiUretimSonuc
                    {
                        Basarili = false,
                        Hata = string.Format("Gemini API çağrısı başarısız (deneme: {0}). Son hata: {1}", MaxRetry + 1, lastError)
                    };
                }

                // 4. Return success
                return new AiUretimSonuc
                {
                    Basarili = true,
                    UretilenIcerik = icerik
                };
            }
            catch (Exception ex)
            {
                return new AiUretimSonuc
                {
                    Basarili = false,
                    Hata = string.Format("Gemini Provider hatası: {0}", ex.Message)
                };
            }
        }

        /// <summary>
        /// Makes HTTP call to Gemini API.
        /// </summary>
        private string CallGeminiApi(string prompt)
        {
            // Ensure TLS 1.2 is used (Google requires it)
            System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls12 | System.Net.SecurityProtocolType.Tls13;

            var url = string.Format(GEMINI_API_ENDPOINT, Model, ApiKey);

            // Build JSON request body
            var requestBody = new
            {
                contents = new[]
                {
                    new
                    {
                        parts = new[]
                        {
                            new { text = prompt }
                        }
                    }
                }
            };

            var jsonRequest = Newtonsoft.Json.JsonConvert.SerializeObject(requestBody);

            try
            {
                // HTTP POST request
                var request = System.Net.WebRequest.Create(url) as System.Net.HttpWebRequest;
                request.Method = "POST";
                request.ContentType = "application/json; charset=utf-8";
                if (TimeoutSeconds > 0)
                {
                    request.Timeout = TimeoutSeconds * 1000;
                }

                using (var streamWriter = new System.IO.StreamWriter(request.GetRequestStream(), System.Text.Encoding.UTF8))
                {
                    streamWriter.Write(jsonRequest);
                }

                using (var response = request.GetResponse() as System.Net.HttpWebResponse)
                using (var streamReader = new System.IO.StreamReader(response.GetResponseStream(), System.Text.Encoding.UTF8))
                {
                    var jsonResponse = streamReader.ReadToEnd();
                    return ParseGeminiResponse(jsonResponse);
                }
            }
            catch (System.Net.WebException webEx)
            {
                // Extract detailed error from response if available
                string detailedError = webEx.Message;
                if (webEx.Response != null)
                {
                    using (var errorStream = webEx.Response.GetResponseStream())
                    using (var reader = new System.IO.StreamReader(errorStream, System.Text.Encoding.UTF8))
                    {
                        detailedError += " Response: " + reader.ReadToEnd();
                    }
                }
                
                throw new Exception(string.Format("API Error (URL: {0}): {1}", url, detailedError));
            }
        }

        /// <summary>
        /// Parses Gemini API JSON response to extract generated text.
        /// </summary>
        private string ParseGeminiResponse(string jsonResponse)
        {
            try
            {
                // Parse JSON response
                // Expected structure: { "candidates": [{ "content": { "parts": [{ "text": "..." }] } }] }
                dynamic response = Newtonsoft.Json.JsonConvert.DeserializeObject(jsonResponse);

                if (response != null && response.candidates != null && response.candidates.Count > 0)
                {
                    var firstCandidate = response.candidates[0];
                    if (firstCandidate != null && firstCandidate.content != null &&
                        firstCandidate.content.parts != null && firstCandidate.content.parts.Count > 0)
                    {
                        var text = firstCandidate.content.parts[0].text;
                        if (text != null)
                        {
                            return text.ToString();
                        }
                    }
                }

                throw new Exception("Gemini API yanıtı beklenen formatta değil.");
            }
            catch (Exception ex)
            {
                throw new Exception(string.Format("Gemini yanıtı ayrıştırılamadı: {0}", ex.Message));
            }
        }
    }

    /// <summary>
    /// OpenAI provider.
    /// </summary>
    public class OpenAiProvider : AiProviderBase
    {
        public override AiUretimSonuc Generate(int urunId, string sablonKod)
        {
            // TODO: OpenAI API entegrasyonu
            return new AiUretimSonuc
            {
                Basarili = false,
                Hata = "OpenAI entegrasyonu henüz implemente edilmedi."
            };
        }
    }

    /// <summary>
    /// Yerel LLM provider.
    /// </summary>
    public class LocalAiProvider : AiProviderBase
    {
        public override AiUretimSonuc Generate(int urunId, string sablonKod)
        {
            // TODO: Yerel LLM entegrasyonu
            return new AiUretimSonuc
            {
                Basarili = false,
                Hata = "Yerel LLM entegrasyonu henüz implemente edilmedi."
            };
        }
    }
}
