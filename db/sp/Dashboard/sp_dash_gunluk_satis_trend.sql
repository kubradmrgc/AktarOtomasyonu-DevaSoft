-- =============================================
-- Dashboard SP: Günlük Satış Trendi
-- =============================================

USE [AktarOtomasyon]
GO

IF OBJECT_ID('sp_dash_gunluk_satis_trend', 'P') IS NOT NULL
    DROP PROCEDURE sp_dash_gunluk_satis_trend;
GO

CREATE PROCEDURE [dbo].[sp_dash_gunluk_satis_trend]
    @gun INT = 7
AS
BEGIN
    SET NOCOUNT ON;

    IF @gun IS NULL OR @gun < 1 SET @gun = 7;
    IF @gun > 90 SET @gun = 90;

    DECLARE @baslangic DATE = DATEADD(DAY, -(@gun - 1), CAST(GETDATE() AS DATE));

    ;WITH Gunler AS (
        SELECT @baslangic AS gun_tarih
        UNION ALL
        SELECT DATEADD(DAY, 1, gun_tarih)
        FROM Gunler
        WHERE gun_tarih < CAST(GETDATE() AS DATE)
    ),
    Ciro AS (
        SELECT
            CAST(satis_tarih AS DATE) AS gun_tarih,
            SUM(toplam_tutar) AS ciro
        FROM dbo.satis
        WHERE CAST(satis_tarih AS DATE) >= @baslangic
        GROUP BY CAST(satis_tarih AS DATE)
    )
    SELECT
        g.gun_tarih AS tarih,
        CASE DATEPART(WEEKDAY, g.gun_tarih)
            WHEN 1 THEN N'Paz'
            WHEN 2 THEN N'Pzt'
            WHEN 3 THEN N'Sal'
            WHEN 4 THEN N'Çar'
            WHEN 5 THEN N'Per'
            WHEN 6 THEN N'Cum'
            WHEN 7 THEN N'Cmt'
        END AS gun_adi,
        ISNULL(c.ciro, 0) AS ciro,
        AVG(ISNULL(c.ciro, 0) * 1.0) OVER () AS ortalama_ciro
    FROM Gunler g
    LEFT JOIN Ciro c ON c.gun_tarih = g.gun_tarih
    ORDER BY g.gun_tarih
    OPTION (MAXRECURSION 100);
END
GO

PRINT 'sp_dash_gunluk_satis_trend olusturuldu.';
GO
