-- Aktar Diyarı import - categories
USE [AktarOtomasyon]
GO

IF NOT EXISTS (SELECT 1 FROM urun_kategori WHERE kategori_kod = 'BAHARAT')
BEGIN
    INSERT INTO urun_kategori (kategori_kod, kategori_adi, aktif)
    VALUES ('BAHARAT', N'Baharatlar', 1);
    PRINT '  + BAHARAT eklendi';
END
GO

IF NOT EXISTS (SELECT 1 FROM urun_kategori WHERE kategori_kod = 'BITKI')
BEGIN
    INSERT INTO urun_kategori (kategori_kod, kategori_adi, aktif)
    VALUES ('BITKI', N'Bitkisel Ürünler', 1);
    PRINT '  + BITKI eklendi';
END
GO

IF NOT EXISTS (SELECT 1 FROM urun_kategori WHERE kategori_kod = 'CAY')
BEGIN
    INSERT INTO urun_kategori (kategori_kod, kategori_adi, aktif)
    VALUES ('CAY', N'Çay ve İçecekler', 1);
    PRINT '  + CAY eklendi';
END
GO

IF NOT EXISTS (SELECT 1 FROM urun_kategori WHERE kategori_kod = 'YAG')
BEGIN
    INSERT INTO urun_kategori (kategori_kod, kategori_adi, aktif)
    VALUES ('YAG', N'Doğal Yağlar', 1);
    PRINT '  + YAG eklendi';
END
GO

IF NOT EXISTS (SELECT 1 FROM urun_kategori WHERE kategori_kod = 'TOHUM')
BEGIN
    INSERT INTO urun_kategori (kategori_kod, kategori_adi, aktif)
    VALUES ('TOHUM', N'Tohum ve Taneler', 1);
    PRINT '  + TOHUM eklendi';
END
GO

IF NOT EXISTS (SELECT 1 FROM urun_kategori WHERE kategori_kod = 'KOZMETIK')
BEGIN
    INSERT INTO urun_kategori (kategori_kod, kategori_adi, aktif)
    VALUES ('KOZMETIK', N'Doğal Kozmetik', 1);
    PRINT '  + KOZMETIK eklendi';
END
GO

IF NOT EXISTS (SELECT 1 FROM urun_kategori WHERE kategori_kod = 'TAKVIYE')
BEGIN
    INSERT INTO urun_kategori (kategori_kod, kategori_adi, aktif)
    VALUES ('TAKVIYE', N'Takviye Ürünleri', 1);
    PRINT '  + TAKVIYE eklendi';
END
GO

IF NOT EXISTS (SELECT 1 FROM urun_kategori WHERE kategori_kod = 'SIVI')
BEGIN
    INSERT INTO urun_kategori (kategori_kod, kategori_adi, aktif)
    VALUES ('SIVI', N'Sıvı Ürünler', 1);
    PRINT '  + SIVI eklendi';
END
GO

IF NOT EXISTS (SELECT 1 FROM urun_kategori WHERE kategori_kod = 'KAHVE')
BEGIN
    INSERT INTO urun_kategori (kategori_kod, kategori_adi, aktif)
    VALUES ('KAHVE', N'Kahve', 1);
    PRINT '  + KAHVE eklendi';
END
GO

IF NOT EXISTS (SELECT 1 FROM urun_kategori WHERE kategori_kod = 'TATLI')
BEGIN
    INSERT INTO urun_kategori (kategori_kod, kategori_adi, aktif)
    VALUES ('TATLI', N'Tatlı ve İkramlık', 1);
    PRINT '  + TATLI eklendi';
END
GO

IF NOT EXISTS (SELECT 1 FROM urun_kategori WHERE kategori_kod = 'DIGER')
BEGIN
    INSERT INTO urun_kategori (kategori_kod, kategori_adi, aktif)
    VALUES ('DIGER', N'Diğer', 1);
    PRINT '  + DIGER eklendi';
END
GO

IF NOT EXISTS (SELECT 1 FROM urun_kategori WHERE kategori_kod = 'MACUN')
BEGIN
    INSERT INTO urun_kategori (kategori_kod, kategori_adi, aktif)
    VALUES ('MACUN', N'Macun ve Karışımlar', 1);
    PRINT '  + MACUN eklendi';
END
GO

IF NOT EXISTS (SELECT 1 FROM urun_kategori WHERE kategori_kod = 'BAL')
BEGIN
    INSERT INTO urun_kategori (kategori_kod, kategori_adi, aktif)
    VALUES ('BAL', N'Bal ve Arı Ürünleri', 1);
    PRINT '  + BAL eklendi';
END
GO
