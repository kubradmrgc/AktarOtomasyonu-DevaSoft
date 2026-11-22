-- =============================================
-- Fix: Turkce karakter bozulmasi (ai_sablon + kul_ekran)
-- UTF-8 mojibake / yanlis seed kaynakli etiketleri duzeltir
-- =============================================
USE [AktarOtomasyon]
GO
SET NOCOUNT ON
GO

UPDATE dbo.ai_sablon SET
    sablon_adi = N'Ürün Açıklaması',
    aciklama = N'Genel ürün açıklaması şablonu'
WHERE sablon_kod = N'URUN_ACIKLAMA';

UPDATE dbo.ai_sablon SET
    sablon_adi = N'SEO Anahtar Kelimeler',
    aciklama = N'SEO anahtar kelime şablonu'
WHERE sablon_kod = N'URUN_SEO';

UPDATE dbo.ai_sablon SET
    sablon_adi = N'Kullanım Talimatları',
    aciklama = N'Kullanım talimatları şablonu'
WHERE sablon_kod = N'URUN_KULLANIM';

UPDATE dbo.kul_ekran SET menudeki_adi = N'AI İçerik Asistanı' WHERE ekran_kod = N'AI_ICERIK';
UPDATE dbo.kul_ekran SET menudeki_adi = N'AI Şablon Yönetim' WHERE ekran_kod = N'AI_SABLON_YNT';
UPDATE dbo.kul_ekran SET menudeki_adi = N'AI Modül' WHERE ekran_kod = N'AI_MODUL';
UPDATE dbo.kul_ekran SET menudeki_adi = N'AI Versiyonlar' WHERE ekran_kod = N'AI_VERSIYON';
UPDATE dbo.kul_ekran SET menudeki_adi = N'Ürünler ve Stok' WHERE ekran_kod = N'URUN_STOK';

PRINT N'Turkce etiketler duzeltildi.';
GO
