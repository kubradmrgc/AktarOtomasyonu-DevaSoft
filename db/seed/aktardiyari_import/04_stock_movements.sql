-- Aktar Diyarı import - stock movements (presentation scenario)
USE [AktarOtomasyon]
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00001';
SET @miktar = 14.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00002';
SET @miktar = 11.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00003';
SET @miktar = 78.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (yuksek)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00004';
SET @miktar = 13.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00005';
SET @miktar = 21.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00006';
SET @miktar = 13.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00007';
SET @miktar = 17.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00008';
SET @miktar = 33.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00009';
SET @miktar = 16.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00010';
SET @miktar = 3.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (kritik)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00011';
SET @miktar = 80.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (yuksek)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00012';
SET @miktar = 19.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00013';
SET @miktar = 3.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (kritik)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00014';
SET @miktar = 34.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00015';
SET @miktar = 37.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00016';
SET @miktar = 12.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00017';
SET @miktar = 39.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00018';
SET @miktar = 12.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00019';
SET @miktar = 37.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00020';
SET @miktar = 13.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00021';
SET @miktar = 3.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (kritik)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00022';
SET @miktar = 3.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (kritik)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00023';
SET @miktar = 13.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00024';
SET @miktar = 4.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (kritik)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00025';
SET @miktar = 20.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00026';
SET @miktar = 10.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00027';
SET @miktar = 4.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (kritik)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00028';
SET @miktar = 36.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00029';
SET @miktar = 31.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00030';
SET @miktar = 3.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (kritik)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00031';
SET @miktar = 59.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (yuksek)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00032';
SET @miktar = 26.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00033';
SET @miktar = 3.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (kritik)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00034';
SET @miktar = 50.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (yuksek)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00035';
SET @miktar = 17.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00036';
SET @miktar = 2.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (kritik)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00037';
SET @miktar = 2.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (kritik)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00038';
SET @miktar = 23.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00039';
SET @miktar = 11.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00040';
SET @miktar = 8.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00041';
SET @miktar = 1.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (kritik)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00042';
SET @miktar = 11.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00043';
SET @miktar = 22.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00044';
SET @miktar = 10.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00045';
SET @miktar = 1.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (kritik)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00046';
SET @miktar = 12.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00047';
SET @miktar = 13.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00048';
SET @miktar = 19.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00049';
SET @miktar = 8.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00050';
SET @miktar = 9.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00051';
SET @miktar = 1.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (kritik)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00052';
SET @miktar = 8.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00053';
SET @miktar = 12.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00054';
SET @miktar = 2.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (kritik)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00055';
SET @miktar = 11.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00056';
SET @miktar = 35.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (yuksek)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00057';
SET @miktar = 10.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00058';
SET @miktar = 13.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00059';
SET @miktar = 8.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00060';
SET @miktar = 15.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00061';
SET @miktar = 11.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00062';
SET @miktar = 13.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00063';
SET @miktar = 20.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00064';
SET @miktar = 1.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (kritik)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00065';
SET @miktar = 19.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00066';
SET @miktar = 9.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00067';
SET @miktar = 23.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00068';
SET @miktar = 20.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00069';
SET @miktar = 11.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00070';
SET @miktar = 23.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00071';
SET @miktar = 19.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00072';
SET @miktar = 8.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00073';
SET @miktar = 22.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00074';
SET @miktar = 23.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00075';
SET @miktar = 8.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00076';
SET @miktar = 2.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (kritik)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00077';
SET @miktar = 30.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (yuksek)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00078';
SET @miktar = 11.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00079';
SET @miktar = 37.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (yuksek)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00080';
SET @miktar = 11.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00081';
SET @miktar = 25.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00082';
SET @miktar = 9.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00083';
SET @miktar = 3.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (kritik)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00084';
SET @miktar = 2.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (kritik)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00085';
SET @miktar = 15.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00086';
SET @miktar = 47.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00087';
SET @miktar = 87.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (yuksek)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00088';
SET @miktar = 40.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00089';
SET @miktar = 85.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (yuksek)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00090';
SET @miktar = 13.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00091';
SET @miktar = 14.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00092';
SET @miktar = 23.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00093';
SET @miktar = 21.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00094';
SET @miktar = 2.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (kritik)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00095';
SET @miktar = 20.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00096';
SET @miktar = 6.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00097';
SET @miktar = 6.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00098';
SET @miktar = 2.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (kritik)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00099';
SET @miktar = 15.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (normal)', @admin, GETDATE());
END
GO

DECLARE @uid INT, @admin INT, @onceki DECIMAL(18,3), @miktar DECIMAL(18,3);
SELECT TOP 1 @admin = kullanici_id FROM kullanici WHERE kullanici_adi = 'admin';
IF @admin IS NULL SET @admin = 1;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00100';
SET @miktar = 6.0;
IF @uid IS NOT NULL
AND NOT EXISTS (SELECT 1 FROM stok_hareket WHERE urun_id = @uid AND referans_tip = 'ADY_IMPORT')
BEGIN
    SET @onceki = 0;
    INSERT INTO stok_hareket
        (urun_id, hareket_tip, miktar, onceki_bakiye, sonraki_bakiye, referans_tip, aciklama, kullanici_id, hareket_tarih)
    VALUES
        (@uid, 'GIRIS', @miktar, @onceki, @miktar, 'ADY_IMPORT', N'Aktar Diyarı demo açılış stoğu (dusuk)', @admin, GETDATE());
END
GO

PRINT 'Stok hareketleri eklendi.';
GO
