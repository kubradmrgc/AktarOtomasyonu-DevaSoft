using System;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.Drawing.Printing;
using System.Windows.Forms;

namespace AktarOtomasyon.Forms.Common
{
    /// <summary>
    /// Satış sonrası ürüne yapıştırılacak kullanım/oran etiketini Windows yazıcısına gönderir.
    /// POS fişi değildir; küçük etiket formatındadır.
    /// </summary>
    public static class KullanimEtiketPrinter
    {
        public class EtiketModel
        {
            public string UrunAdi { get; set; }
            public string Kullanim { get; set; }
            public string Aciklama { get; set; }
            public string Uyari { get; set; }
            public string MiktarText { get; set; }
        }

        public static bool PrintLabels(IList<EtiketModel> labels, bool showPrinterDialog = true)
        {
            if (labels == null || labels.Count == 0)
                return false;

            var queue = new Queue<EtiketModel>(labels);
            var doc = new PrintDocument();
            doc.DocumentName = "Kullanım Etiketi";
            ApplyPaperSize(doc);
            ApplyPrinterName(doc);

            if (showPrinterDialog)
            {
                using (var dlg = new PrintDialog())
                {
                    dlg.Document = doc;
                    dlg.AllowSomePages = false;
                    dlg.UseEXDialog = true;
                    if (dlg.ShowDialog() != DialogResult.OK)
                        return false;
                    doc.PrinterSettings = dlg.PrinterSettings;
                }
            }
            else if (string.IsNullOrWhiteSpace(doc.PrinterSettings.PrinterName))
            {
                using (var dlg = new PrintDialog())
                {
                    dlg.Document = doc;
                    dlg.UseEXDialog = true;
                    if (dlg.ShowDialog() != DialogResult.OK)
                        return false;
                    doc.PrinterSettings = dlg.PrinterSettings;
                }
            }

            EtiketModel current = null;
            doc.PrintPage += (s, e) =>
            {
                if (current == null && queue.Count > 0)
                    current = queue.Dequeue();

                if (current == null)
                {
                    e.HasMorePages = false;
                    return;
                }

                DrawLabel(e.Graphics, e.MarginBounds, current);
                current = null;
                e.HasMorePages = queue.Count > 0;
            };

            try
            {
                doc.Print();
                return true;
            }
            catch (Exception ex)
            {
                MessageHelper.ShowError("Etiket yazdırılamadı: " + ex.Message);
                return false;
            }
        }

        private static void ApplyPrinterName(PrintDocument doc)
        {
            var name = ConfigurationManager.AppSettings["LABEL_PRINTER_NAME"];
            if (string.IsNullOrWhiteSpace(name))
                return;

            foreach (string installed in PrinterSettings.InstalledPrinters)
            {
                if (string.Equals(installed, name.Trim(), StringComparison.OrdinalIgnoreCase))
                {
                    doc.PrinterSettings.PrinterName = installed;
                    return;
                }
            }
        }

        private static void ApplyPaperSize(PrintDocument doc)
        {
            float widthMm = ReadMm("LABEL_WIDTH_MM", 58f);
            float heightMm = ReadMm("LABEL_HEIGHT_MM", 40f);
            int w = MmToHundredths(widthMm);
            int h = MmToHundredths(heightMm);

            doc.DefaultPageSettings.Margins = new Margins(20, 20, 20, 20);
            try
            {
                doc.DefaultPageSettings.PaperSize = new PaperSize("KullanimEtiket", w, h);
            }
            catch
            {
                // Yazıcı özel boyutu kabul etmezse varsayılan kağıt kullanılır
            }
        }

        private static float ReadMm(string key, float fallback)
        {
            float v;
            var raw = ConfigurationManager.AppSettings[key];
            if (float.TryParse(raw, out v) && v > 10)
                return v;
            return fallback;
        }

        private static int MmToHundredths(float mm)
        {
            return (int)Math.Round(mm / 25.4f * 100f);
        }

        private static void DrawLabel(Graphics g, Rectangle bounds, EtiketModel m)
        {
            g.TextRenderingHint = System.Drawing.Text.TextRenderingHint.ClearTypeGridFit;

            float y = bounds.Top;
            float left = bounds.Left;
            float width = Math.Max(40, bounds.Width);

            using (var fontTitle = new Font("Segoe UI", 10f, FontStyle.Bold))
            using (var fontSection = new Font("Segoe UI", 7.5f, FontStyle.Bold))
            using (var fontBody = new Font("Segoe UI", 7.5f, FontStyle.Regular))
            using (var brush = new SolidBrush(Color.Black))
            using (var pen = new Pen(Color.Black, 1f))
            {
                string title = Truncate(m.UrunAdi ?? "Ürün", 48);
                g.DrawString(title, fontTitle, brush, new RectangleF(left, y, width, 28));
                y += 26;

                if (!string.IsNullOrWhiteSpace(m.MiktarText))
                {
                    g.DrawString("Miktar: " + m.MiktarText, fontBody, brush, left, y);
                    y += 14;
                }

                g.DrawLine(pen, left, y, left + width, y);
                y += 6;

                if (!string.IsNullOrWhiteSpace(m.Kullanim))
                {
                    g.DrawString("KULLANIM / ORAN", fontSection, brush, left, y);
                    y += 12;
                    y = DrawWrapped(g, m.Kullanim, fontBody, brush, left, y, width, bounds.Bottom - 18);
                }

                if (!string.IsNullOrWhiteSpace(m.Aciklama) && y < bounds.Bottom - 28)
                {
                    g.DrawString("NOT", fontSection, brush, left, y);
                    y += 12;
                    y = DrawWrapped(g, m.Aciklama, fontBody, brush, left, y, width, bounds.Bottom - 18);
                }

                if (!string.IsNullOrWhiteSpace(m.Uyari) && y < bounds.Bottom - 16)
                {
                    g.DrawString("Uyarı: " + Truncate(m.Uyari, 90), fontBody, brush,
                        new RectangleF(left, y, width, bounds.Bottom - y));
                }
            }
        }

        private static float DrawWrapped(Graphics g, string text, Font font, Brush brush,
            float x, float y, float width, float maxY)
        {
            if (string.IsNullOrWhiteSpace(text))
                return y;

            var rect = new RectangleF(x, y, width, Math.Max(10, maxY - y));
            g.DrawString(text.Trim(), font, brush, rect);
            var size = g.MeasureString(text.Trim(), font, (int)width);
            return y + Math.Min(size.Height, rect.Height) + 4;
        }

        private static string Truncate(string s, int max)
        {
            if (string.IsNullOrEmpty(s) || s.Length <= max)
                return s ?? "";
            return s.Substring(0, max - 1) + "…";
        }
    }
}
