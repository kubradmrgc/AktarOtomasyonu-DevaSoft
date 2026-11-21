-- =============================================
-- Dashboard SP: Bugünkü Satış Özeti
-- =============================================

USE [AktarOtomasyon]
GO

IF OBJECT_ID('sp_dash_bugun_satis_ozet', 'P') IS NOT NULL
    DROP PROCEDURE sp_dash_bugun_satis_ozet;
GO

CREATE PROCEDURE [dbo].[sp_dash_bugun_satis_ozet]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @bugun DATE = CAST(GETDATE() AS DATE);
    DECLARE @dun DATE = DATEADD(DAY, -1, @bugun);

    DECLARE @bugun_ciro DECIMAL(18,2) = 0;
    DECLARE @fis_adet INT = 0;
    DECLARE @ort_sepet DECIMAL(18,2) = 0;
    DECLARE @dun_ciro DECIMAL(18,2) = 0;
    DECLARE @yuzde_degisim DECIMAL(18,2) = 0;

    SELECT
        @bugun_ciro = ISNULL(SUM(toplam_tutar), 0),
        @fis_adet = COUNT(*)
    FROM dbo.satis
    WHERE CAST(satis_tarih AS DATE) = @bugun;

    SET @ort_sepet = CASE WHEN @fis_adet > 0 THEN @bugun_ciro / @fis_adet ELSE 0 END;

    SELECT @dun_ciro = ISNULL(SUM(toplam_tutar), 0)
    FROM dbo.satis
    WHERE CAST(satis_tarih AS DATE) = @dun;

    SET @yuzde_degisim = CASE
        WHEN @dun_ciro > 0 THEN ((@bugun_ciro - @dun_ciro) / @dun_ciro) * 100.0
        WHEN @bugun_ciro > 0 THEN 100.0
        ELSE 0
    END;

    SELECT
        @bugun_ciro AS bugun_ciro,
        @fis_adet AS fis_adet,
        @ort_sepet AS ort_sepet,
        @dun_ciro AS dun_ciro,
        @yuzde_degisim AS yuzde_degisim;
END
GO

PRINT 'sp_dash_bugun_satis_ozet olusturuldu.';
GO
