-- Aktar Diyarı import - stock settings
USE [AktarOtomasyon]
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00001';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 80, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00002';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 80, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00003';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 80, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00004';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 80, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00005';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 80, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00006';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 80, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00007';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 80, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00008';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 80, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00009';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 80, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00010';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 80, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00011';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 80, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00012';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 80, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00013';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 80, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00014';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 80, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00015';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 80, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00016';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 70, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00017';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 70, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00018';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 70, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00019';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 70, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00020';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 70, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00021';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 70, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00022';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 70, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00023';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 70, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00024';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 70, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00025';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 70, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00026';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 70, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00027';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 70, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00028';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 70, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00029';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 70, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00030';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 10, 70, 5, 10);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00031';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 60, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00032';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 60, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00033';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 60, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00034';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 60, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00035';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 60, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00036';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 60, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00037';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 60, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00038';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 60, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00039';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 60, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00040';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 60, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00041';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 60, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00042';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 60, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00043';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 40, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00044';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 40, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00045';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 40, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00046';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 40, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00047';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 40, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00048';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 40, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00049';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 50, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00050';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 50, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00051';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 50, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00052';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 50, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00053';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 50, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00054';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 50, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00055';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 35, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00056';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 35, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00057';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 35, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00058';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 35, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00059';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 35, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00060';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 35, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00061';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 35, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00062';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 35, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00063';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 40, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00064';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 40, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00065';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 40, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00066';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 40, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00067';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 40, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00068';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 40, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00069';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 40, 3, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00070';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 40, 3, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00071';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 40, 3, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00072';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 40, 3, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00073';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 40, 3, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00074';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 40, 3, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00075';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 40, 3, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00076';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 40, 3, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00077';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 40, 3, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00078';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 40, 3, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00079';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 45, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00080';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 45, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00081';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 45, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00082';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 45, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00083';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 45, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00084';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 8, 45, 4, 8);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00085';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 12, 90, 5, 12);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00086';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 12, 90, 5, 12);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00087';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 12, 90, 5, 12);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00088';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 12, 90, 5, 12);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00089';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 12, 90, 5, 12);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00090';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 12, 90, 5, 12);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00091';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 12, 90, 5, 12);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00092';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 12, 90, 5, 12);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00093';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 40, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00094';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 40, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00095';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 40, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00096';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 40, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00097';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 40, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00098';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 40, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00099';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 40, 3, 6);
END
GO

DECLARE @uid INT;
SELECT @uid = urun_id FROM urun WHERE urun_kod = 'ADY-00100';
IF @uid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM urun_stok_ayar WHERE urun_id = @uid)
BEGIN
    INSERT INTO urun_stok_ayar (urun_id, min_stok, max_stok, kritik_stok, siparis_miktari)
    VALUES (@uid, 6, 40, 3, 6);
END
GO
