-- =============================================
-- Dashboard SP: Kritik Stok Mini Liste
-- =============================================

USE [AktarOtomasyon]
GO

IF OBJECT_ID('sp_dash_kritik_stok_liste', 'P') IS NOT NULL
    DROP PROCEDURE sp_dash_kritik_stok_liste;
GO

CREATE PROCEDURE [dbo].[sp_dash_kritik_stok_liste]
    @limit INT = 3
AS
BEGIN
    SET NOCOUNT ON;

    IF @limit IS NULL OR @limit < 1 SET @limit = 3;

    ;WITH StokOzet AS (
        SELECT
            h.urun_id,
            SUM(CASE WHEN h.hareket_tip IN (N'GIRIS', N'SAYIM') THEN h.miktar ELSE -h.miktar END) AS mevcut_stok
        FROM dbo.stok_hareket h
        GROUP BY h.urun_id
    )
    SELECT TOP (@limit)
        u.urun_id,
        u.urun_adi,
        ISNULL(so.mevcut_stok, 0) AS mevcut_stok,
        sa.kritik_stok,
        CASE
            WHEN sa.kritik_stok IS NULL OR sa.kritik_stok <= 0 THEN 0
            ELSE CAST(
                CASE
                    WHEN ISNULL(so.mevcut_stok, 0) <= 0 THEN 0
                    WHEN ISNULL(so.mevcut_stok, 0) >= sa.kritik_stok THEN 100
                    ELSE (ISNULL(so.mevcut_stok, 0) / sa.kritik_stok) * 100.0
                END AS DECIMAL(18,2)
            )
        END AS oran
    FROM dbo.urun u
    INNER JOIN dbo.urun_stok_ayar sa ON sa.urun_id = u.urun_id
    LEFT JOIN StokOzet so ON so.urun_id = u.urun_id
    WHERE u.aktif = 1
      AND ISNULL(so.mevcut_stok, 0) <= sa.kritik_stok
    ORDER BY
        CASE WHEN sa.kritik_stok > 0 THEN ISNULL(so.mevcut_stok, 0) / sa.kritik_stok ELSE 0 END ASC,
        u.urun_adi;
END
GO

PRINT 'sp_dash_kritik_stok_liste olusturuldu.';
GO
