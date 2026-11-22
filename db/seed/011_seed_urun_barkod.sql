-- =============================================
-- Gercek urun taramasi: barkod + eksik fiyat
-- EAN-13 benzeri benzersiz barkodlar (869... TR prefix)
-- =============================================
USE [AktarOtomasyon]
GO
SET NOCOUNT ON
GO

PRINT N'011_seed_urun_barkod basliyor...';

-- Her urune benzersiz barkod (869 + 9 hane urun_id pad)
UPDATE u
SET
    u.barkod = N'869' + RIGHT(N'000000000' + CAST(u.urun_id AS NVARCHAR(9)), 9) + N'1',
    u.guncelleme_tarih = GETDATE()
FROM dbo.urun u
WHERE u.aktif = 1
  AND (u.barkod IS NULL OR LTRIM(RTRIM(u.barkod)) = N'');

-- BIT urunlerine satis/alis fiyati
UPDATE dbo.urun SET alis_fiyati = 95,  satis_fiyati = 165 WHERE urun_kod = N'BIT001' AND satis_fiyati IS NULL;
UPDATE dbo.urun SET alis_fiyati = 80,  satis_fiyati = 140 WHERE urun_kod = N'BIT002' AND satis_fiyati IS NULL;
UPDATE dbo.urun SET alis_fiyati = 70,  satis_fiyati = 125 WHERE urun_kod = N'BIT003' AND satis_fiyati IS NULL;
UPDATE dbo.urun SET alis_fiyati = 180, satis_fiyati = 290 WHERE urun_kod = N'BIT004' AND satis_fiyati IS NULL;
UPDATE dbo.urun SET alis_fiyati = 110, satis_fiyati = 195 WHERE urun_kod = N'BIT005' AND satis_fiyati IS NULL;
UPDATE dbo.urun SET alis_fiyati = 150, satis_fiyati = 260 WHERE urun_kod = N'BIT006' AND satis_fiyati IS NULL;
UPDATE dbo.urun SET alis_fiyati = 90,  satis_fiyati = 155 WHERE urun_kod = N'BIT007' AND satis_fiyati IS NULL;
UPDATE dbo.urun SET alis_fiyati = 85,  satis_fiyati = 145 WHERE urun_kod = N'BIT008' AND satis_fiyati IS NULL;

-- Barkod unique index (yoksa)
SET QUOTED_IDENTIFIER ON;
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'UX_urun_barkod' AND object_id = OBJECT_ID(N'dbo.urun'))
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX UX_urun_barkod
    ON dbo.urun(barkod)
    WHERE barkod IS NOT NULL AND barkod <> N'';
END
SET QUOTED_IDENTIFIER OFF;

PRINT N'Barkod atama ozeti:';
SELECT
    COUNT(*) AS toplam,
    SUM(CASE WHEN barkod IS NOT NULL AND barkod <> N'' THEN 1 ELSE 0 END) AS barkodlu,
    SUM(CASE WHEN satis_fiyati IS NULL THEN 1 ELSE 0 END) AS fiyatsiz
FROM dbo.urun
WHERE aktif = 1;

SELECT TOP 10 urun_kod, urun_adi, barkod, satis_fiyati
FROM dbo.urun
WHERE aktif = 1
ORDER BY urun_id;

PRINT N'011_seed_urun_barkod tamamlandi.';
PRINT N'Ornek tarama: 8690000000011 (Karabiber) veya urun_kod BAH001';
GO
