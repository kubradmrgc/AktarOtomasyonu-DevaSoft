-- =============================================
-- AI_ICERIK screen registration (kul_ekran)
-- =============================================
USE [AktarOtomasyon]
GO

IF NOT EXISTS (SELECT 1 FROM [dbo].[kul_ekran] WHERE [ekran_kod] = 'AI_ICERIK')
BEGIN
    INSERT INTO [dbo].[kul_ekran] ([ekran_kod], [menudeki_adi], [form_adi], [modul], [aktif], [olusturma_tarih])
    VALUES ('AI_ICERIK', N'AI İçerik Asistanı', 'FrmAiIcerik', 'AI', 1, GETDATE())

    PRINT 'AI_ICERIK screen registered.'
END
ELSE
BEGIN
    PRINT 'AI_ICERIK screen already exists.'
END
GO
