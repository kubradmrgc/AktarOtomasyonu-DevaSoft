-- =============================================
-- Satış Stored Procedures
-- TVP + sp_satis_kaydet (transaction, stok CIKIS)
-- =============================================

USE [AktarOtomasyon]
GO

IF TYPE_ID(N'dbo.SatisDetayTip') IS NULL
BEGIN
    CREATE TYPE [dbo].[SatisDetayTip] AS TABLE
    (
        [urun_id] INT NOT NULL,
        [miktar] DECIMAL(18,2) NOT NULL,
        [birim_fiyat] DECIMAL(18,2) NOT NULL
    );
END
GO

IF OBJECT_ID('sp_satis_kaydet', 'P') IS NOT NULL
    DROP PROCEDURE sp_satis_kaydet;
GO

CREATE PROCEDURE [dbo].[sp_satis_kaydet]
    @odeme_tip NVARCHAR(20) = N'NAKIT',
    @kullanici_id INT = NULL,
    @aciklama NVARCHAR(500) = NULL,
    @detaylar dbo.SatisDetayTip READONLY,
    @satis_id INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    IF NOT EXISTS (SELECT 1 FROM @detaylar)
    BEGIN
        RAISERROR(N'Satis detayi bos olamaz.', 16, 1);
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM @detaylar WHERE miktar <= 0 OR birim_fiyat < 0 OR urun_id <= 0)
    BEGIN
        RAISERROR(N'Gecersiz urun, miktar veya birim fiyat.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRAN;

        DECLARE @satis_no NVARCHAR(30);
        DECLARE @seq INT;

        SELECT @seq = ISNULL(MAX(satis_id), 0) + 1 FROM dbo.satis WITH (UPDLOCK, HOLDLOCK);
        SET @satis_no = N'FIS' + FORMAT(GETDATE(), 'yyyyMMdd') + RIGHT(N'0000' + CAST(@seq AS NVARCHAR(10)), 4);

        INSERT INTO dbo.satis (satis_no, satis_tarih, toplam_tutar, odeme_tip, kullanici_id, aciklama)
        VALUES (@satis_no, GETDATE(), 0, ISNULL(@odeme_tip, N'NAKIT'), @kullanici_id, @aciklama);

        SET @satis_id = SCOPE_IDENTITY();

        INSERT INTO dbo.satis_detay (satis_id, urun_id, miktar, birim_fiyat, tutar)
        SELECT
            @satis_id,
            d.urun_id,
            d.miktar,
            d.birim_fiyat,
            d.miktar * d.birim_fiyat
        FROM @detaylar d;

        DECLARE @urun_id INT, @miktar DECIMAL(18,2);
        DECLARE detay_cursor CURSOR LOCAL FAST_FORWARD FOR
            SELECT urun_id, miktar FROM @detaylar;

        OPEN detay_cursor;
        FETCH NEXT FROM detay_cursor INTO @urun_id, @miktar;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            DECLARE @onceki_bakiye DECIMAL(18,2);
            DECLARE @sonraki_bakiye DECIMAL(18,2);

            SELECT @onceki_bakiye = ISNULL(SUM(
                CASE WHEN hareket_tip IN (N'GIRIS', N'SAYIM') THEN miktar ELSE -miktar END
            ), 0)
            FROM dbo.stok_hareket
            WHERE urun_id = @urun_id;

            SET @sonraki_bakiye = @onceki_bakiye - @miktar;

            INSERT INTO dbo.stok_hareket (
                urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye,
                referans_tip, referans_id, aciklama, kullanici_id, hareket_tarih
            )
            VALUES (
                @urun_id, N'CIKIS', @miktar, @onceki_bakiye, @sonraki_bakiye,
                N'SATIS', @satis_id, N'Perakende Satis ' + @satis_no, @kullanici_id, GETDATE()
            );

            FETCH NEXT FROM detay_cursor INTO @urun_id, @miktar;
        END

        CLOSE detay_cursor;
        DEALLOCATE detay_cursor;

        UPDATE dbo.satis
        SET toplam_tutar = (
            SELECT ISNULL(SUM(tutar), 0) FROM dbo.satis_detay WHERE satis_id = @satis_id
        )
        WHERE satis_id = @satis_id;

        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRAN;

        IF CURSOR_STATUS('local', 'detay_cursor') >= 0
        BEGIN
            CLOSE detay_cursor;
            DEALLOCATE detay_cursor;
        END

        DECLARE @err NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR(@err, 16, 1);
    END CATCH
END
GO

PRINT 'sp_satis_kaydet olusturuldu.';
GO
