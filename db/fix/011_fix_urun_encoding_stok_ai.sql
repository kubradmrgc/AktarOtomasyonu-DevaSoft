-- =============================================
-- Fix: urun adi encoding, negatif stok, AI seed, ekstra urunler
-- =============================================
USE [AktarOtomasyon]
GO
SET NOCOUNT ON
GO

PRINT N'011_fix_urun_encoding_stok_ai basliyor...';

-- 1) Urun adlarini duzgun Turkce karakterlerle guncelle
UPDATE dbo.urun SET urun_adi = N'Zerdeçal' WHERE urun_kod = N'BAH003';
UPDATE dbo.urun SET urun_adi = N'Kırmızı Pul Biber' WHERE urun_kod = N'BAH004';
UPDATE dbo.urun SET urun_adi = N'Tarçın (Toz)' WHERE urun_kod = N'BAH005';
UPDATE dbo.urun SET urun_adi = N'Antep Fıstığı (İçi)' WHERE urun_kod = N'KUR001';
UPDATE dbo.urun SET urun_adi = N'Badem (İçi)' WHERE urun_kod = N'KUR002';
UPDATE dbo.urun SET urun_adi = N'Ceviz (İçi)' WHERE urun_kod = N'KUR003';
UPDATE dbo.urun SET urun_adi = N'Fındık (İçi)' WHERE urun_kod = N'KUR004';
UPDATE dbo.urun SET urun_adi = N'Kuru Üzüm' WHERE urun_kod = N'KUR005';
UPDATE dbo.urun SET urun_adi = N'Kırmızı Mercimek' WHERE urun_kod = N'BAK001';
UPDATE dbo.urun SET urun_adi = N'Yeşil Mercimek' WHERE urun_kod = N'BAK002';
UPDATE dbo.urun SET urun_adi = N'Bulgur (İnce)' WHERE urun_kod = N'BAK005';
PRINT N'Urun adlari duzeltildi.';

-- 2) Negatif stoklari duzelt (eksi = asiri CIKIS; satis degil)
DECLARE @adminId INT = (SELECT TOP 1 kullanici_id FROM dbo.kullanici WHERE kullanici_adi = N'admin');
IF @adminId IS NULL SET @adminId = 1;

;WITH StokOzet AS (
    SELECT urun_id,
           SUM(CASE WHEN hareket_tip IN (N'GIRIS', N'SAYIM') THEN miktar ELSE -miktar END) AS mevcut
    FROM dbo.stok_hareket
    GROUP BY urun_id
)
INSERT INTO dbo.stok_hareket (urun_id, hareket_tip, miktar, hareket_tarih, aciklama, kullanici_id, referans_tip, referans_id)
SELECT
    s.urun_id,
    N'GIRIS',
    CASE
        WHEN s.mevcut < 0 THEN ABS(s.mevcut) + 2.0   -- 0'in ustune kritik seviyeye cek
        WHEN s.mevcut < 2 THEN 2.0 - s.mevcut
        ELSE 0
    END,
    GETDATE(),
    N'Dashboard stok duzeltme (negatif/kritik)',
    @adminId,
    N'DUZELTME',
    NULL
FROM StokOzet s
WHERE s.mevcut < 2;
PRINT N'Negatif/kritik stok GIRIS duzeltmeleri yazildi.';

-- 3) Yeni bitkisel urunler (AI icerik odakli katalog genisletme)
DECLARE @katBaharat INT = (SELECT TOP 1 kategori_id FROM dbo.urun_kategori WHERE kategori_adi LIKE N'%Baharat%' OR kategori_kod LIKE N'%BAH%');
DECLARE @birimKg INT = (SELECT TOP 1 birim_id FROM dbo.urun_birim WHERE birim_kod = N'KG' OR birim_adi LIKE N'%kg%');
IF @birimKg IS NULL SET @birimKg = (SELECT TOP 1 birim_id FROM dbo.urun_birim);
IF @katBaharat IS NULL SET @katBaharat = (SELECT TOP 1 kategori_id FROM dbo.urun_kategori);

IF @birimKg IS NOT NULL AND @katBaharat IS NOT NULL
BEGIN
    IF NOT EXISTS (SELECT 1 FROM dbo.urun WHERE urun_kod = N'BIT001')
        INSERT INTO dbo.urun (urun_kod, urun_adi, kategori_id, birim_id, aktif, olusturma_tarih)
        VALUES (N'BIT001', N'Ihlamur Çiçeği', @katBaharat, @birimKg, 1, GETDATE());
    IF NOT EXISTS (SELECT 1 FROM dbo.urun WHERE urun_kod = N'BIT002')
        INSERT INTO dbo.urun (urun_kod, urun_adi, kategori_id, birim_id, aktif, olusturma_tarih)
        VALUES (N'BIT002', N'Tıbbi Adaçayı', @katBaharat, @birimKg, 1, GETDATE());
    IF NOT EXISTS (SELECT 1 FROM dbo.urun WHERE urun_kod = N'BIT003')
        INSERT INTO dbo.urun (urun_kod, urun_adi, kategori_id, birim_id, aktif, olusturma_tarih)
        VALUES (N'BIT003', N'Hibiskus Çayı', @katBaharat, @birimKg, 1, GETDATE());
    IF NOT EXISTS (SELECT 1 FROM dbo.urun WHERE urun_kod = N'BIT004')
        INSERT INTO dbo.urun (urun_kod, urun_adi, kategori_id, birim_id, aktif, olusturma_tarih)
        VALUES (N'BIT004', N'Çörek Otu Yağı', @katBaharat, @birimKg, 1, GETDATE());
    IF NOT EXISTS (SELECT 1 FROM dbo.urun WHERE urun_kod = N'BIT005')
        INSERT INTO dbo.urun (urun_kod, urun_adi, kategori_id, birim_id, aktif, olusturma_tarih)
        VALUES (N'BIT005', N'Kudret Narı Macunu', @katBaharat, @birimKg, 1, GETDATE());
    IF NOT EXISTS (SELECT 1 FROM dbo.urun WHERE urun_kod = N'BIT006')
        INSERT INTO dbo.urun (urun_kod, urun_adi, kategori_id, birim_id, aktif, olusturma_tarih)
        VALUES (N'BIT006', N'Propolis Damlası', @katBaharat, @birimKg, 1, GETDATE());
    IF NOT EXISTS (SELECT 1 FROM dbo.urun WHERE urun_kod = N'BIT007')
        INSERT INTO dbo.urun (urun_kod, urun_adi, kategori_id, birim_id, aktif, olusturma_tarih)
        VALUES (N'BIT007', N'Organik Tarçın Kabuğu', @katBaharat, @birimKg, 1, GETDATE());
    IF NOT EXISTS (SELECT 1 FROM dbo.urun WHERE urun_kod = N'BIT008')
        INSERT INTO dbo.urun (urun_kod, urun_adi, kategori_id, birim_id, aktif, olusturma_tarih)
        VALUES (N'BIT008', N'Zencefil Tozu', @katBaharat, @birimKg, 1, GETDATE());
END
PRINT N'Yeni urunler eklendi (varsa atlandi).';

-- Stok ayari + baslangic stogu yeni urunler icin
INSERT INTO dbo.urun_stok_ayar (urun_id, kritik_stok, min_stok, siparis_miktari)
SELECT u.urun_id, 5, 2, 10
FROM dbo.urun u
WHERE u.urun_kod LIKE N'BIT%'
  AND NOT EXISTS (SELECT 1 FROM dbo.urun_stok_ayar sa WHERE sa.urun_id = u.urun_id);

INSERT INTO dbo.stok_hareket (urun_id, hareket_tip, miktar, hareket_tarih, aciklama, kullanici_id, referans_tip)
SELECT u.urun_id, N'GIRIS',
       CASE u.urun_kod
           WHEN N'BIT001' THEN 1.8
           WHEN N'BIT002' THEN 4.2
           WHEN N'BIT003' THEN 3.0
           WHEN N'BIT004' THEN 4.0
           WHEN N'BIT005' THEN 6.0
           WHEN N'BIT006' THEN 8.0
           WHEN N'BIT007' THEN 12.0
           WHEN N'BIT008' THEN 2.5
           ELSE 5.0
       END,
       GETDATE(), N'Ilk stok (demo)', @adminId, N'SEED'
FROM dbo.urun u
WHERE u.urun_kod LIKE N'BIT%'
  AND NOT EXISTS (SELECT 1 FROM dbo.stok_hareket h WHERE h.urun_id = u.urun_id);

-- 4) AI onay bekleyen icerikler (dashboard odak)
IF NOT EXISTS (SELECT 1 FROM dbo.ai_urun_icerik WHERE durum IN (N'TASLAK', N'ONAY_BEKLIYOR'))
BEGIN
    INSERT INTO dbo.ai_urun_icerik (urun_id, icerik, durum, sablon_kod, provider, kullanici_id, olusturma_tarih)
    SELECT u.urun_id,
           N'{"fayda":"' + u.urun_adi + N' doğal destek sağlar, bağışıklığı güçlendirir.","kullanim":"Günde 1-2 porsiyon, ılık su ile.","uyari":"Hamilelikte doktor önerisi olmadan kullanmayın.","kombinasyon":"Ihlamur ve zencefil ile uyumludur."}',
           N'TASLAK',
           N'URUN_DETAY_V1',
           N'DevaSoft-AI',
           @adminId,
           DATEADD(MINUTE, -ROW_NUMBER() OVER (ORDER BY u.urun_id) * 17, GETDATE())
    FROM dbo.urun u
    WHERE u.aktif = 1
      AND u.urun_kod IN (N'BIT001', N'BIT002', N'BIT003', N'BIT004', N'BAH001', N'BAH003', N'BIT008', N'BIT005');

    -- Bir kismi ONAY_BEKLIYOR
    UPDATE TOP (4) dbo.ai_urun_icerik
    SET durum = N'ONAY_BEKLIYOR'
    WHERE durum = N'TASLAK';
END
PRINT N'AI icerik seed tamam.';

PRINT N'011_fix_urun_encoding_stok_ai tamamlandi.';
GO
