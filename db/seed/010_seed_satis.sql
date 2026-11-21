-- =============================================
-- Seed: Örnek satış fişleri (dashboard dolu görünsün)
-- =============================================

USE [AktarOtomasyon]
GO

IF OBJECT_ID(N'dbo.satis', N'U') IS NULL
BEGIN
    PRINT 'satis tablosu yok - seed atlandi.';
    RETURN;
END
GO

-- Temiz yeniden seed (demo)
DELETE FROM dbo.stok_hareket WHERE referans_tip = N'SATIS';
DELETE FROM dbo.satis_detay;
DELETE FROM dbo.satis;
GO

DECLARE @urun1 INT, @urun2 INT, @urun3 INT;
SELECT TOP 1 @urun1 = urun_id FROM dbo.urun WHERE aktif = 1 ORDER BY urun_id;
SELECT TOP 1 @urun2 = urun_id FROM dbo.urun WHERE aktif = 1 AND urun_id <> @urun1 ORDER BY urun_id;
SELECT TOP 1 @urun3 = urun_id FROM dbo.urun WHERE aktif = 1 AND urun_id NOT IN (@urun1, @urun2) ORDER BY urun_id;

IF @urun1 IS NULL
BEGIN
    PRINT 'Urun bulunamadi - seed atlandi.';
    RETURN;
END

DECLARE @i INT = 0;
DECLARE @gun DATE;
DECLARE @satis_id INT;
DECLARE @satis_no NVARCHAR(30);
DECLARE @fiyat1 DECIMAL(18,2), @fiyat2 DECIMAL(18,2), @fiyat3 DECIMAL(18,2);

SELECT @fiyat1 = ISNULL(satis_fiyati, 100) FROM dbo.urun WHERE urun_id = @urun1;
SELECT @fiyat2 = ISNULL(satis_fiyati, 80) FROM dbo.urun WHERE urun_id = ISNULL(@urun2, @urun1);
SELECT @fiyat3 = ISNULL(satis_fiyati, 60) FROM dbo.urun WHERE urun_id = ISNULL(@urun3, @urun1);

WHILE @i < 7
BEGIN
    SET @gun = DATEADD(DAY, -@i, CAST(GETDATE() AS DATE));

    -- Her gün 2-4 fiş
    DECLARE @fis INT = 0;
    WHILE @fis < (2 + (@i % 3))
    BEGIN
        SET @satis_no = N'FIS' + FORMAT(@gun, 'yyyyMMdd') + RIGHT(N'0000' + CAST((@i * 10 + @fis + 1) AS NVARCHAR(10)), 4);

        INSERT INTO dbo.satis (satis_no, satis_tarih, toplam_tutar, odeme_tip, kullanici_id, aciklama, olusturma_tarih)
        VALUES (
            @satis_no,
            DATEADD(HOUR, 9 + @fis, CAST(@gun AS DATETIME)),
            0,
            CASE WHEN @fis % 2 = 0 THEN N'NAKIT' ELSE N'KART' END,
            1,
            N'Demo satis',
            GETDATE()
        );

        SET @satis_id = SCOPE_IDENTITY();

        INSERT INTO dbo.satis_detay (satis_id, urun_id, miktar, birim_fiyat, tutar)
        VALUES (@satis_id, @urun1, 1 + (@fis % 2), @fiyat1, (1 + (@fis % 2)) * @fiyat1);

        IF @urun2 IS NOT NULL
        BEGIN
            INSERT INTO dbo.satis_detay (satis_id, urun_id, miktar, birim_fiyat, tutar)
            VALUES (@satis_id, @urun2, 0.5 + (@fis * 0.25), @fiyat2, (0.5 + (@fis * 0.25)) * @fiyat2);
        END

        IF @urun3 IS NOT NULL AND @fis % 2 = 1
        BEGIN
            INSERT INTO dbo.satis_detay (satis_id, urun_id, miktar, birim_fiyat, tutar)
            VALUES (@satis_id, @urun3, 1, @fiyat3, @fiyat3);
        END

        UPDATE dbo.satis
        SET toplam_tutar = (SELECT SUM(tutar) FROM dbo.satis_detay WHERE satis_id = @satis_id)
        WHERE satis_id = @satis_id;

        -- Stok çıkışı (seed için basit)
        INSERT INTO dbo.stok_hareket (urun_id, hareket_tip, miktar, referans_tip, referans_id, aciklama, kullanici_id, hareket_tarih)
        SELECT urun_id, N'CIKIS', miktar, N'SATIS', @satis_id, N'Demo satis ' + @satis_no, 1, DATEADD(HOUR, 9 + @fis, CAST(@gun AS DATETIME))
        FROM dbo.satis_detay WHERE satis_id = @satis_id;

        SET @fis = @fis + 1;
    END

    SET @i = @i + 1;
END
GO

PRINT '010_seed_satis.sql tamamlandi.';
GO
