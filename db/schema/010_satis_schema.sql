-- =============================================
-- Satış Şeması (DevaSoft Dashboard Backend)
-- Tables: satis, satis_detay
-- =============================================

USE [AktarOtomasyon]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[satis]'))
BEGIN
    CREATE TABLE [dbo].[satis] (
        [satis_id] INT IDENTITY(1,1) PRIMARY KEY,
        [satis_no] NVARCHAR(30) NOT NULL UNIQUE,
        [satis_tarih] DATETIME NOT NULL DEFAULT GETDATE(),
        [toplam_tutar] DECIMAL(18,2) NOT NULL DEFAULT 0,
        [odeme_tip] NVARCHAR(20) NOT NULL DEFAULT N'NAKIT', -- NAKIT, KART
        [kullanici_id] INT NULL,
        [aciklama] NVARCHAR(500) NULL,
        [olusturma_tarih] DATETIME NOT NULL DEFAULT GETDATE()
    );
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[satis_detay]'))
BEGIN
    CREATE TABLE [dbo].[satis_detay] (
        [detay_id] INT IDENTITY(1,1) PRIMARY KEY,
        [satis_id] INT NOT NULL,
        [urun_id] INT NOT NULL,
        [miktar] DECIMAL(18,2) NOT NULL,
        [birim_fiyat] DECIMAL(18,2) NOT NULL,
        [tutar] DECIMAL(18,2) NOT NULL,
        FOREIGN KEY ([satis_id]) REFERENCES [dbo].[satis]([satis_id]),
        FOREIGN KEY ([urun_id]) REFERENCES [dbo].[urun]([urun_id])
    );
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'IX_satis_tarih' AND object_id = OBJECT_ID(N'[dbo].[satis]'))
BEGIN
    CREATE NONCLUSTERED INDEX [IX_satis_tarih]
    ON [dbo].[satis]([satis_tarih] DESC)
    INCLUDE ([toplam_tutar], [odeme_tip]);
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = N'IX_satis_detay_satis' AND object_id = OBJECT_ID(N'[dbo].[satis_detay]'))
BEGIN
    CREATE NONCLUSTERED INDEX [IX_satis_detay_satis]
    ON [dbo].[satis_detay]([satis_id])
    INCLUDE ([urun_id], [miktar], [birim_fiyat], [tutar]);
END
GO

PRINT '010_satis_schema.sql tamamlandi.';
GO
