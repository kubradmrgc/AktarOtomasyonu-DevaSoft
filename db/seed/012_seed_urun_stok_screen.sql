-- =============================================
-- URUN_STOK screen registration (kul_ekran)
-- =============================================
USE [AktarOtomasyon]
GO

IF NOT EXISTS (SELECT 1 FROM [dbo].[kul_ekran] WHERE [ekran_kod] = 'URUN_STOK')
BEGIN
    INSERT INTO [dbo].[kul_ekran] ([ekran_kod], [menudeki_adi], [form_adi], [modul], [aktif], [olusturma_tarih])
    VALUES ('URUN_STOK', N'Ürünler ve Stok', 'FrmUrunStok', 'Stok', 1, GETDATE())

    PRINT 'URUN_STOK screen registered.'
END
ELSE
BEGIN
    PRINT 'URUN_STOK screen already exists.'
END
GO
