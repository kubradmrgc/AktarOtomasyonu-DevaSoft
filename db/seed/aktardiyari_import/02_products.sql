-- Aktar Diyarı import - products
SET QUOTED_IDENTIFIER ON;
SET ANSI_NULLS ON;
GO
USE [AktarOtomasyon]
GO

PRINT 'Aktar Diyarı ürünleri ekleniyor...';
GO

-- ADY-00001: Ac.kekik 250 Gr
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00001')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BAHARAT';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00001', N'Ac.kekik 250 Gr', @kat, @birim, 76.70, 118.00, '8684727013691', N'Ac.kekik 250 Gr - demo import', 1);
END
GO

-- ADY-00002: Ac.nane Limon 250 Gr.
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00002')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BAHARAT';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00002', N'Ac.nane Limon 250 Gr.', @kat, @birim, 76.70, 118.00, '8684727013738', N'Ac.nane Limon 250 Gr. - demo import', 1);
END
GO

-- ADY-00003: Ac.tarçın 250 Gr.
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00003')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BAHARAT';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00003', N'Ac.tarçın 250 Gr.', @kat, @birim, 76.70, 118.00, '8684727013790', N'Ac.tarçın 250 Gr. - demo import', 1);
END
GO

-- ADY-00004: Acı Biber Yağı
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00004')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BAHARAT';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'ML';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00004', N'Acı Biber Yağı', @kat, @birim, 1420.84, 2185.90, '8684727093747', N'Ürün Bilgisi Aktar Diyarı Acı Biber Yağı 1000 ML: Doğanın Ateşli Dokunuşu Mutfaklarınıza! Aktar Diyarı kalitesiyle sunulan 1000 ML Acı Biber Yağı, yemeklerinize eşsiz bir lezzet ve yakıcı bir tat katmak için ideal. En taze acı biberlerden özenle soğuk sıkım yöntemiyle elde edilen', 1);
END
GO

-- ADY-00005: Ahu Tarçın Tablet
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00005')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BAHARAT';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00005', N'Ahu Tarçın Tablet', @kat, @birim, 113.75, 175.00, '8684727013622', N'Ahu Tarçın Tablet - demo import', 1);
END
GO

-- ADY-00006: Aks Kekik Suyu 1 Lt
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00006')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BAHARAT';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00006', N'Aks Kekik Suyu 1 Lt', @kat, @birim, 156.65, 241.00, '8684727009335', N'Ürün Bilgisi Shiffa Home kalitesiyle sunulan 1 litrelik Aks Kekik Suyu, doğanın eşsiz armağanlarından biri olarak sofralarınızda yerini alıyor. Aktar Depo güvencesiyle sizlere ulaşan bu özel ürün, kekik yağının saf ve yoğun formunu pratik bir şekilde kullanımınıza sunuyor. Doğrud', 1);
END
GO

-- ADY-00007: Extra Acı Pul Biber
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00007')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BAHARAT';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00007', N'Extra Acı Pul Biber', @kat, @birim, 267.74, 411.90, '8684727001803', N'Ürün Bilgisi Aktar Diyarı kalitesiyle sofralarınıza sıcaklık ve lezzet katacak Extra Acı Pul Biberimiz 1000 gramlık paketlerde sizleri bekliyor. Doğanın bize sunduğu en özel tatlardan biri olan bu pul biber, özenle seçilmiş en kaliteli biberlerin güneşte kurutulup, tane tane ayrı', 1);
END
GO

-- ADY-00008: Kekik Bilya Tomurcuk
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00008')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BAHARAT';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00008', N'Kekik Bilya Tomurcuk', @kat, @birim, 649.94, 999.90, '8684727033538', N'Ürün Bilgisi Aktar Diyarı''nın özenle seçilmiş Kekik Bilya Tomurcuk 1000 GR ürünü ile mutfağınıza ve yaşamınıza doğanın eşsiz dokunuşunu katın. Bu özel bitki, sofraların vazgeçilmez lezzetlendiricilerinden biri olmasının yanı sıra, mutfaklarınıza geleneksel bir aroma katacaktır. A', 1);
END
GO

-- ADY-00009: Kekik Şekeri Kg
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00009')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BAHARAT';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00009', N'Kekik Şekeri Kg', @kat, @birim, 367.90, 566.00, '8684727029210', N'Kekik Şekeri Kg - demo import', 1);
END
GO

-- ADY-00010: Krdn Kekik Yağı 20 Cc.
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00010')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BAHARAT';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00010', N'Krdn Kekik Yağı 20 Cc.', @kat, @birim, 200.20, 308.00, '8684727009939', N'Ürün Bilgisi Karden Krdn Kekik Yağı 20 Cc. ile doğanın gücünü evinize taşıyın. Aktar Depo güvencesiyle sunduğumuz bu özel kekik yağı, geleneksel yöntemlerle elde edilmiş saf ve yoğun bir formüle sahiptir. Antik çağlardan beri kullanılan kekik, içeriğindeki zengin bileşenler sayes', 1);
END
GO

-- ADY-00011: Krdn Kimyon Yağı 20 Ml
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00011')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BAHARAT';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00011', N'Krdn Kimyon Yağı 20 Ml', @kat, @birim, 114.40, 176.00, '8684727009977', N'Ürün Bilgisi Karden''in doğal ve saf Krdn Kimyon Yağı 20 Ml ile sofralarınıza ve sağlığınıza otantik bir lezzet katın. Aktar Depo güvencesiyle sunulan bu değerli kimyon yağı, eşsiz aroması ve zengin içeriğiyle öne çıkıyor. Yemeklerinize derinlik katmak, çorbalarınıza ferahlık verm', 1);
END
GO

-- ADY-00012: Krdn Nane Yağı 20 Cc
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00012')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BAHARAT';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00012', N'Krdn Nane Yağı 20 Cc', @kat, @birim, 146.25, 225.00, '8684727010096', N'Ürün Bilgisi Karden Krdn Nane Yağı 20 Cc ile ferahlığın ve doğal iyiliğin kapısını aralayın. Aktar Depo güvencesiyle sunulan bu özel nane yağı, mentolün canlandırıcı etkisiyle hem bedeninizi hem de ruhunuzu tazelemek için ideal bir seçenektir. Karden''in kalitesiyle üretilen bu sa', 1);
END
GO

-- ADY-00013: Krdn Tarçın Aroması 20 Cc
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00013')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BAHARAT';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00013', N'Krdn Tarçın Aroması 20 Cc', @kat, @birim, 109.20, 168.00, '8684727010232', N'Ürün Bilgisi Karden''in eşsiz Krdn Tarçın Aroması 20 Cc ile mutfağınıza sıcak ve baharatlı bir dokunuş katın. Bu özel tarçın yağı, Aktar Depo''nun özenle seçtiği, kalitesiyle öne çıkan ürünlerinden biridir. Karden Krdn Tarçın Aroması 20 Cc, tatlılardan tuzlulara, içeceklerden hamur', 1);
END
GO

-- ADY-00014: Krk Zerdeçal Yağı 20 Cc
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00014')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BAHARAT';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00014', N'Krk Zerdeçal Yağı 20 Cc', @kat, @birim, 94.90, 146.00, '8684727010744', N'Ürün Bilgisi Karakaş Krk Zerdeçal Yağı 20 Cc ile doğanın sunduğu şifayı evinize getirin. Aktar Depo güvencesiyle sizlere ulaşan bu özel zerdeçal yağı, geleneksel bilgilerle modern yaşamın ihtiyaçlarını bir araya getiriyor. Zerdeçalın güçlü bileşenlerinden elde edilen bu saf yağ, ', 1);
END
GO

-- ADY-00015: Kutusuz Zerdeçal Sabunu 100 Gr
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00015')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BAHARAT';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00015', N'Kutusuz Zerdeçal Sabunu 100 Gr', @kat, @birim, 40.30, 62.00, '8684727057893', N'Kutusuz Zerdeçal Sabunu 100 Gr - demo import', 1);
END
GO

-- ADY-00016: Altınbaşak Andız Otu
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00016')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BITKI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00016', N'Altınbaşak Andız Otu', @kat, @birim, 226.78, 348.90, '8684727037840', N'Ürün Bilgisi Aktar Diyarı''nın özenle hazırladığı Altınbaşak Andız Otu 1 kg, doğanın sunduğu eşsiz bir hediyedir. Binlerce yıldır geleneksel kullanımlarıyla bilinen bu değerli bitki, mutfaklarınıza ve yaşamınıza farklı bir dokunuş katacaktır. Aktar Diyarı güvencesiyle sunulan bu ö', 1);
END
GO

-- ADY-00017: Andız Kökü Dökme  Aktar Diyari
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00017')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BITKI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00017', N'Andız Kökü Dökme  Aktar Diyari', @kat, @birim, 649.94, 999.90, '8684727014674', N'Ürün Bilgisi Aktar Diyarı''nın özenle seçilmiş, %100 doğal Andız Kökü ile tanışın. Aktar Diyarı kalitesiyle sunduğumuz 1 Kg''lık dökme Andız Kökü, geleneksel aktarlık deneyimini evinize taşıyor. Bitkisel ürünler kategorisinde yer alan bu özel ürünümüz, doğanın sunduğu zenginliklerd', 1);
END
GO

-- ADY-00018: Aşlık Otu-Açlık Otu
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00018')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BITKI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00018', N'Aşlık Otu-Açlık Otu', @kat, @birim, 139.03, 213.90, '8684727090807', N'Ürün Bilgisi Aktar Diyarı güvencesiyle sunulan 1000 gramlık Aşlık Otu-Açlık Otu ile doğanın şifasını mutfağınıza taşıyın. Aktar Diyarı olarak, en taze ve en kaliteli bitkileri özenle seçerek sizlere ulaştırıyoruz. Bu özel bitki, geleneksel mutfaklarda yerini alan ve pek çok farkl', 1);
END
GO

-- ADY-00019: Aşlık Otu-Açlık Otu Öğütülmüş
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00019')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BITKI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00019', N'Aşlık Otu-Açlık Otu Öğütülmüş', @kat, @birim, 158.53, 243.90, '8684727047719', N'Ürün Bilgisi Aktar Diyarı''nın özenle öğütülmüş Aşlık Otu-Açlık Otu ürünü ile doğanın gücünü mutfağınıza taşıyın. 1 kilogramlık bu özel ürün, geleneksel kullanımına saygı duyularak hazırlanmıştır. Aktar Diyarı, doğallığı ve kaliteyi ilke edinerek, her bir ürününü titizlikle seçer ', 1);
END
GO

-- ADY-00020: At Kuyruğu - Kırkkilit Otu
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00020')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BITKI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00020', N'At Kuyruğu - Kırkkilit Otu', @kat, @birim, 219.63, 337.90, '8684727001438', N'Ürün Bilgisi Aktar Diyarı kalitesiyle sunulan 1000 GR At Kuyruğu - Kırkkilit Otu ile doğanın gücünü evinize taşıyın. Doğal bitki kategorisinin değerli bir üyesi olan bu ürün, yüzyıllardır geleneksel kullanımlarıyla bilinen at kuyruğu bitkisini sofralarınıza veya kişisel bakım rut', 1);
END
GO

-- ADY-00021: At Kuyruğu Kırkkilit Otu Öğütülmüş
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00021')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BITKI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00021', N'At Kuyruğu Kırkkilit Otu Öğütülmüş', @kat, @birim, 241.08, 370.90, '8684727045845', N'Ürün Bilgisi Aktar Diyarı güvencesiyle sunulan At Kuyruğu Kırkkilit Otu Öğütülmüş 1 Kg, doğanın sunduğu eşsiz bir armağanı sofralarınıza taşıyor. Yüksek kalitede seçilmiş kırkkilit otlarının özenle öğütülmesiyle hazırlanan bu ürün, bitkiler kategorisinin değerli bir üyesidir. At ', 1);
END
GO

-- ADY-00022: Ayrık Otu Kökü Öğütülmüş
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00022')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BITKI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00022', N'Ayrık Otu Kökü Öğütülmüş', @kat, @birim, 156.59, 240.90, '8684727044466', N'Ürün Bilgisi Latince adı ''Agropyron repens'' olan Ayrık otu, buğdaygiller familyasındandır. Anavatanı, Kuzey yarımküre ve Anadolu''dur. Yabani olarak boş tarlalar ve yol kenarlarında yetişir.', 1);
END
GO

-- ADY-00023: Bodur Mahmut Acı Yavşan Otu
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00023')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BITKI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00023', N'Bodur Mahmut Acı Yavşan Otu', @kat, @birim, 300.30, 462.00, '8684727043858', N'Ürün Bilgisi Aktar Diyarı''nın özenle hazırladığı Bodur Mahmut Acı Yavşan Otu 1 Kg ile doğanın eşsiz armağanlarından birini evinize taşıyın. Yıllardır aktarlık geleneğini yaşatan Aktar Diyarı güvencesiyle sunduğumuz bu özel bitki, hem mutfakta hem de geleneksel kullanımlarda yerin', 1);
END
GO

-- ADY-00024: Çakşır Kökü Tozu  Aktar Diyarı
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00024')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BITKI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00024', N'Çakşır Kökü Tozu  Aktar Diyarı', @kat, @birim, 373.69, 574.90, '8684727035532', N'Ürün Bilgisi Aktar Diyarı''nın özenle hazırladığı 1000 gramlık Çakşır Kökü Tozu, doğanın sunduğu eşsiz bir hediyedir. Aktar Diyarı markası olarak, en kaliteli bitkileri titizlikle seçerek sizlere ulaştırıyoruz. Çakşır kökü, geleneksel olarak pek çok alanda tercih edilen bir bitkid', 1);
END
GO

-- ADY-00025: İsveç İksiri Bitkileri
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00025')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BITKI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00025', N'İsveç İksiri Bitkileri', @kat, @birim, 221.65, 341.00, '8684727028886', N'Ürün Bilgisi Aktar Depo İsveç İksiri Bitkileri', 1);
END
GO

-- ADY-00026: Kayış Kıran Otu
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00026')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BITKI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00026', N'Kayış Kıran Otu', @kat, @birim, 411.38, 632.90, '8684727047283', N'Ürün Bilgisi Aktar Diyarı''nın özenle hazırladığı 1 Kg Kayış Kıran Otu ile doğanın gücünü keşfedin. Bitkiler kategorisinin bu eşsiz ürünü, Aktar Diyarı güvencesiyle sofralarınıza ve yaşamınıza sağlık katıyor. Kayış kıran otu, yüzyıllardır geleneksel tıpta çeşitli amaçlarla kullanı', 1);
END
GO

-- ADY-00027: Limon Otu Yaprak
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00027')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BITKI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00027', N'Limon Otu Yaprak', @kat, @birim, 649.94, 999.90, '8684727039066', N'Ürün Bilgisi Aktar Diyarı kalitesiyle sunduğumuz Limon Otu Yaprak 1000 Gr, doğanın sunduğu eşsiz bir armağandır. Güvenilirliğimiz ve doğal ürünlere olan bağlılığımızla tanınan Aktar Diyarı, bu özel bitkiyi sofralarınıza ve yaşamınıza taşıyor. Limon otu, taze ve ferahlatıcı kokusu', 1);
END
GO

-- ADY-00028: Melisa(oğul Otu)toz Ekstrat
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00028')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BITKI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00028', N'Melisa(oğul Otu)toz Ekstrat', @kat, @birim, 1553.50, 2390.00, '8684727076474', N'Melisa(oğul Otu)toz Ekstrat - demo import', 1);
END
GO

-- ADY-00029: Meryem Ana Eli Otuet
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00029')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BITKI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00029', N'Meryem Ana Eli Otuet', @kat, @birim, 48.10, 74.00, '8684727086442', N'Ürün Bilgisi Aktar Diyarı güvencesiyle sunulan Meryem Ana Eli Otu 1 Adet, doğanın eşsiz armağanlarından biridir. Aktar Diyarı''nın özenle seçtiği bu özel bitki, geleneksel kullanımlarıyla adından söz ettirir. Meryem Ana Eli Otu, bitkiler kategorisinde benzersiz bir yer tutar. Ürün', 1);
END
GO

-- ADY-00030: Mesteki Sakızı-Mezda-Köknar Sakızı
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00030')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'BITKI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00030', N'Mesteki Sakızı-Mezda-Köknar Sakızı', @kat, @birim, 2748.13, 4227.90, '8684727047771', N'Ürün Bilgisi Mesteki Sakızı-Mezda-Köknar Sakızı 1 Kg Halk arasında Mezdeki, Mezleği veya Köknar Ağacı Sakızı olarak da bilinen mezda sakızı köknar ağacının kozalaklarından süzülen doğal bir sakız türüdür. Zahmetli bir şekilde toplanan mezda sakızı köknar ağaçlarının kozalalarında', 1);
END
GO

-- ADY-00031: Ac.adaçayı 250 Gr
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00031')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'CAY';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00031', N'Ac.adaçayı 250 Gr', @kat, @birim, 76.70, 118.00, '8684727013639', N'Ac.adaçayı 250 Gr - demo import', 1);
END
GO

-- ADY-00032: Ac.ıhlamur 250gr
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00032')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'CAY';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00032', N'Ac.ıhlamur 250gr', @kat, @birim, 76.70, 118.00, '8684727013660', N'Ac.ıhlamur 250gr - demo import', 1);
END
GO

-- ADY-00033: Adaçayı Yağı-Acı Elma Yağı
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00033')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'CAY';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'ML';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00033', N'Adaçayı Yağı-Acı Elma Yağı', @kat, @birim, 6457.69, 9934.90, '8684727074548', N'Ürün Bilgisi Aktar Diyarı Adaçayı Yağı-Acı Elma Yağı 1000 ML ile doğanın gücünü keşfedin. Bu eşsiz karışım, cildiniz ve saçınız için zengin bir bakım sunar. Adaçayı yağının canlandırıcı etkisiyle Acı Elma yağının besleyici özelliklerini bir araya getiren Aktar Diyarı kalitesiyle,', 1);
END
GO

-- ADY-00034: Akşah Seylan Çayı 400 Gr
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00034')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'CAY';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00034', N'Akşah Seylan Çayı 400 Gr', @kat, @birim, 287.95, 443.00, '8684727014803', N'Akşah Seylan Çayı 400 Gr - demo import', 1);
END
GO

-- ADY-00035: Atom Çayı  Aktar Diyarı
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00035')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'CAY';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00035', N'Atom Çayı  Aktar Diyarı', @kat, @birim, 72.80, 112.00, '8684727041465', N'Ürün Bilgisi Atom Çayı (Küp)Atom Çayı:Kış mevsiminin vazgeçilmezi olan kış çayları, içimizi ısıtacak evimizi saracak kokusuyla şifa niyetine içilmelidir.Kış çayı, soğuk havalarda vücudumuzun kaybettiği mineral ve vitaminleri takviye ederken, vücudun ihtiyaç duyduğu antioksidan ma', 1);
END
GO

-- ADY-00036: Çay Ağacı Sabunu gr
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00036')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'CAY';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00036', N'Çay Ağacı Sabunu gr', @kat, @birim, 55.25, 85.00, '8684727044039', N'Ürün Bilgisi Aktar Diyarı''nın doğadan ilham alan özel Çay Ağacı Sabunu 125 gr ile tanışın. Bu eşsiz ürünümüz, içeriğindeki saf çay ağacı yağı sayesinde cildinize nazik bir bakım sunar. Aktar Diyarı, geleneksel yöntemlerle modern bilimi harmanlayarak sizlere en kaliteli doğal ürün', 1);
END
GO

-- ADY-00037: Dökme Sultan Çayı Toz
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00037')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'CAY';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00037', N'Dökme Sultan Çayı Toz', @kat, @birim, 196.95, 303.00, '8684727013981', N'Dökme Sultan Çayı Toz - demo import', 1);
END
GO

-- ADY-00038: Ihlamur Çiçek Toz
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00038')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'CAY';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00038', N'Ihlamur Çiçek Toz', @kat, @birim, 1335.10, 2054.00, '8684727046606', N'Ürün Bilgisi Aktar Diyarı kalitesiyle sunulan 1000 GR Ihlamur Çiçek Tozu, doğanın eşsiz armağanlarından biridir. Aktar Diyarı olarak, en taze ve en saf bitkileri özenle seçerek sofralarınıza ulaştırmayı hedefliyoruz. Ihlamur çiçeklerinin eşsiz kokusu ve lezzetiyle tanınan bu özel', 1);
END
GO

-- ADY-00039: Kış Çayı 100 gr
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00039')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'CAY';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00039', N'Kış Çayı 100 gr', @kat, @birim, 131.30, 202.00, '8684727051051', N'Ürün Bilgisi , Cuha çiçeği, Mersin yaprağı, Zeytin yaprağı Aynı sefa çiçeği, Gül kurusu yaprak, Adaçayı, Hibisküs, Melisa kültür, küp çay Tarçın kesik, portakal dilimi gül tomurcuk limon kuş burnu Kış aylarının vazgeçilmezi, sıcak ve zengin aromasıyla dikkat çeken kış çayı. - Doğ', 1);
END
GO

-- ADY-00040: Krk Yeşilçay Yağı 20 Cc
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00040')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'CAY';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00040', N'Krk Yeşilçay Yağı 20 Cc', @kat, @birim, 70.20, 108.00, '8684727010713', N'Ürün Bilgisi Karakaş Krk Yeşilçay Yağı 20 Cc, doğanın eşsiz hediyelerinden biri olarak Aktar Depo güvencesiyle sizlere ulaşıyor. Üzüm Yağı kategorisinin değerli bir üyesi olan bu özel ürün, içeriğindeki zenginliklerle adından söz ettiriyor. Karakaş Krk Yeşilçay Yağı, hem geleneks', 1);
END
GO

-- ADY-00041: L.aktar Civanperçemi Çayı
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00041')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'CAY';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00041', N'L.aktar Civanperçemi Çayı', @kat, @birim, 184.60, 284.00, '8684727014025', N'L.aktar Civanperçemi Çayı - demo import', 1);
END
GO

-- ADY-00042: L.aktar Hindiba Çayı
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00042')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'CAY';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00042', N'L.aktar Hindiba Çayı', @kat, @birim, 184.60, 284.00, '8684727014087', N'L.aktar Hindiba Çayı - demo import', 1);
END
GO

-- ADY-00043: Acı Badem Acıbadem
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00043')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'DIGER';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00043', N'Acı Badem Acıbadem', @kat, @birim, 598.59, 920.90, '8684727039677', N'Ürün Bilgisi Aktar Diyarı Acı Badem Beyaz ve pembe çiçekleri olan, uzun boylu bir ağaçtır. Mümkün oldukça az yenilmelidir. Fazla tüketilirse zehirlenmeye yol açar.Sabit yağ ve glikozit ( Amigdalin) içermektedir. Amigdalinin parçalanması ile, zehirli bileşik olan, siyanhidrik asit', 1);
END
GO

-- ADY-00044: Aspir Çiçeği - Haspir - Yemeklik Safran
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00044')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'DIGER';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00044', N'Aspir Çiçeği - Haspir - Yemeklik Safran', @kat, @birim, 649.94, 999.90, '8684727001599', N'Ürün Bilgisi Aktar Diyarı''nın özenle hazırladığı 1 kg''lık Aspir Çiçeği ile mutfaklarınıza hem renk hem de lezzet katın. Yemeklik safran olarak da bilinen haspir, benzersiz sarı rengi ve hafif aromasıyla pilavlarınıza, tavuk yemeklerinize ve diğer pek çok tarifinize sofistike bir ', 1);
END
GO

-- ADY-00045: Bira Mayası SAF Katkısız Orijinal
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00045')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'DIGER';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00045', N'Bira Mayası SAF Katkısız Orijinal', @kat, @birim, 411.38, 632.90, '8684727040703', N'Ürün Bilgisi Bira Mayası Bira mayası mikro besinlerin çok geniş bir yelpazesine sahiptir ve son derece besleyicidir.Bira mayası kuru maya olarak da bilinen ekmek tatli börek gibi hamur işlerini kabartmak icin kullanılmaktadır. Baharatlar', 1);
END
GO

-- ADY-00046: Ceviz Kabuğu  Aktar Diyarı
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00046')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'DIGER';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00046', N'Ceviz Kabuğu  Aktar Diyarı', @kat, @birim, 64.35, 99.00, '8684727040413', N'Ürün Bilgisi Doğada bulunan besinlerin her bir parçası farklı faydalar taşır. Bu besinlerden biri de cevizdir. Ceviz içi hem yetişkinler hem de çocuklar için sayısız faydaya sahip iken, ceviz kabuğu da insan sağlığı için önemli bir besin içeriğine sahiptir. Bir çok hastalık için ', 1);
END
GO

-- ADY-00047: Dilimli Hindistan Cevizi Kurusu
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00047')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'DIGER';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00047', N'Dilimli Hindistan Cevizi Kurusu', @kat, @birim, 494.00, 760.00, '8684727030896', N'Ürün Bilgisi Aktar Depo Dilimli Hindistan Cevizi Kurusu', 1);
END
GO

-- ADY-00048: Goji Berry gojiberry gojiberi
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00048')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'DIGER';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00048', N'Goji Berry gojiberry gojiberi', @kat, @birim, 649.94, 999.90, '8684727001308', N'Ürün Bilgisi Aktar Diyarı''nın özenle seçilmiş 1000 GR Goji Berry ürününü keşfedin. Doğanın sunduğu bu eşsiz bitki, sofralarınıza sağlık ve lezzet katmak için hazır. Aktar Diyarı olarak, en taze ve kaliteli ürünleri sizlere ulaştırmak için titizlikle çalışıyoruz. Goji Berry, zengi', 1);
END
GO

-- ADY-00049: 19 Kumaş Boyası Viktoria Kahve
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00049')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'KAHVE';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00049', N'19 Kumaş Boyası Viktoria Kahve', @kat, @birim, 633.10, 974.00, '8684727019754', N'Ürün Bilgisi Aktar Depo 19 Kumaş Boyası Viktoria Kahve', 1);
END
GO

-- ADY-00050: Alişanoğlu Çekirdek Kahve Kavrulmuş
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00050')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'KAHVE';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00050', N'Alişanoğlu Çekirdek Kahve Kavrulmuş', @kat, @birim, 662.35, 1019.00, '8684727002244', N'Alişanoğlu Çekirdek Kahve Kavrulmuş - demo import', 1);
END
GO

-- ADY-00051: Çiğ Kahve  100 GR
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00051')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'KAHVE';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00051', N'Çiğ Kahve  100 GR', @kat, @birim, 65.65, 101.00, '8684727086312', N'Çiğ Kahve  100 GR - demo import', 1);
END
GO

-- ADY-00052: Çiğ Kahve  250 GR
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00052')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'KAHVE';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00052', N'Çiğ Kahve  250 GR', @kat, @birim, 143.00, 220.00, '8684727081355', N'Çiğ Kahve  250 GR - demo import', 1);
END
GO

-- ADY-00053: Çiğ Kahve Öğütülmüş 500 GR
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00053')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'KAHVE';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00053', N'Çiğ Kahve Öğütülmüş 500 GR', @kat, @birim, 304.85, 469.00, '8684727091767', N'Çiğ Kahve Öğütülmüş 500 GR - demo import', 1);
END
GO

-- ADY-00054: Hazır Kahve Gold 100 GR
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00054')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'KAHVE';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00054', N'Hazır Kahve Gold 100 GR', @kat, @birim, 100.10, 154.00, '8684727088712', N'Hazır Kahve Gold 100 GR - demo import', 1);
END
GO

-- ADY-00055: Alman Kına Taşı 1000 GR
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00055')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'KOZMETIK';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00055', N'Alman Kına Taşı 1000 GR', @kat, @birim, 442.00, 680.00, '8684727020576', N'Ürün Bilgisi Aktar Depo Alman Taşı(gıda Ve Kozm.kullanılamaz)', 1);
END
GO

-- ADY-00056: Alman Taşı Kına Taşı
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00056')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'KOZMETIK';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00056', N'Alman Taşı Kına Taşı', @kat, @birim, 541.38, 832.90, '8684727032302', N'Ürün Bilgisi Aktar Diyarı''nın %100 doğal Alman Taşı Kına Taşı 1000 Gr ile güzelliğinize doğallık katın. Kozmetik ve kişisel bakım rutinlerinizin vazgeçilmezi olacak bu özel ürün, yüzyıllardır bilinen faydalarıyla öne çıkıyor. Aktar Diyarı güvencesiyle sunduğumuz Alman Taşı Kına T', 1);
END
GO

-- ADY-00057: Ceviz Sabunu
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00057')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'KOZMETIK';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00057', N'Ceviz Sabunu', @kat, @birim, 76.05, 117.00, '8684727044282', N'Ürün Bilgisi Aktar Diyarı''nın özenle hazırladığı 125 gr Ceviz Sabunu ile tanışın. Doğanın gücünden ilham alınarak formüle edilen bu özel ürün, Aktar Diyarı''nın kalitesiyle size ulaşıyor. Ceviz sabunu, geleneksel güzellik sırlarını modern cilt bakımıyla birleştiriyor. Cildinizi na', 1);
END
GO

-- ADY-00058: Greenlabel Gül Kremi 50 Ml
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00058')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'KOZMETIK';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00058', N'Greenlabel Gül Kremi 50 Ml', @kat, @birim, 227.50, 350.00, '8684727072025', N'Greenlabel Gül Kremi 50 Ml - demo import', 1);
END
GO

-- ADY-00059: Greenlabel Lavanta&passiflora Şampuanı 400 Ml
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00059')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'KOZMETIK';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00059', N'Greenlabel Lavanta&passiflora Şampuanı 400 Ml', @kat, @birim, 178.75, 275.00, '8684727094058', N'Greenlabel Lavanta&passiflora Şampuanı 400 Ml - demo import', 1);
END
GO

-- ADY-00060: Himalaya Tuzu Mini Sabunu
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00060')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'KOZMETIK';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00060', N'Himalaya Tuzu Mini Sabunu', @kat, @birim, 54.60, 84.00, '8684727030384', N'Himalaya Tuzu Mini Sabunu - demo import', 1);
END
GO

-- ADY-00061: Kına Rgs Ekstra
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00061')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'KOZMETIK';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00061', N'Kına Rgs Ekstra', @kat, @birim, 266.50, 410.00, '8684727025724', N'Kına Rgs Ekstra - demo import', 1);
END
GO

-- ADY-00062: Lavanta Sabunu
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00062')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'KOZMETIK';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00062', N'Lavanta Sabunu', @kat, @birim, 91.00, 140.00, '8684727044015', N'Ürün Bilgisi Aktar Diyarı''nın özenle hazırladığı 125 gr''lık Lavanta Sabunu ile tanışın, cildiniz için doğal bir şifa kaynağı. Aktar Diyarı''nın güvenilirliği ile sunulan bu özel lavanta sabunu, hem günlük bakım rutininizin vazgeçilmez bir parçası olacak hem de cildinize hassas ve ', 1);
END
GO

-- ADY-00063: Bol Pekmezli Cevizli Sucuk
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00063')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'SIVI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00063', N'Bol Pekmezli Cevizli Sucuk', @kat, @birim, 623.94, 959.90, '8684727055455', N'Ürün Bilgisi Bol Pekmezli Cevizli Sucuk



Geleneksel sucuğa eşsiz bir lezzet ve enerji katıyor. Doğadan gelen bu eşsiz birleşim, hem tatlı hem de tuzlu sevenleri memnun ediyor. Bol pekmezli cevizli sucuk ile hem enerji dolu bir atıştırmalık hem de keyifli bir lezzet deneyimine h', 1);
END
GO

-- ADY-00064: Cevizli Sucuk
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00064')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'SIVI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00064', N'Cevizli Sucuk', @kat, @birim, 520.59, 800.90, '8684727005993', N'Ürün Bilgisi Aktar Diyarı Cevizli Sucuk : Doğanın En Lezzetli Hediyesi Aktar Diyarı''nın özenle hazırladığı Cevizli Sucuk, geleneksel lezzeti modern sunumuyla buluşturuyor. İncecik dilimlenmiş, besleyici cevizler ve en taze üzüm pekmeziyle hazırlanan bu eşsiz ikramlık, sofralarını', 1);
END
GO

-- ADY-00065: Ekstra Kelebek Cevizli Sucuk
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00065')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'SIVI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00065', N'Ekstra Kelebek Cevizli Sucuk', @kat, @birim, 520.65, 801.00, '8684727060503', N'Ürün Bilgisi Cevizli sucuk faydaları arasında kalp sağlığını desteklemesi bulunur. Cevizli sucuğun temel maddelerden biri olan ceviz, bitkisel kaynaklı omega-3 yağ asitleri olan alfa-linolenik asit (ALA) içerir. Omega-3 yağ asitleri, kalp hastalıkları riskini azaltır ve kan basın', 1);
END
GO

-- ADY-00066: Fresh Badem Şurubu 1000gr-somato
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00066')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'SIVI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00066', N'Fresh Badem Şurubu 1000gr-somato', @kat, @birim, 243.10, 374.00, '8684727027377', N'Fresh Badem Şurubu 1000gr-somato - demo import', 1);
END
GO

-- ADY-00067: Gerçek Arı Sütü Şişe 1*15 İadesiz
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00067')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'SIVI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00067', N'Gerçek Arı Sütü Şişe 1*15 İadesiz', @kat, @birim, 204.75, 315.00, '8684727016005', N'Ürün Bilgisi Aktar Depo Gerçek Arı Sütü Şişe 1*15 İadesiz', 1);
END
GO

-- ADY-00068: Hem Geri Akış Tütsü Lavanta 10''lu
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00068')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'SIVI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00068', N'Hem Geri Akış Tütsü Lavanta 10''lu', @kat, @birim, 66.95, 103.00, '8684727030070', N'Hem Geri Akış Tütsü Lavanta 10''lu - demo import', 1);
END
GO

-- ADY-00069: Aksuvital Zencefilli Macun 300 Gr
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00069')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TAKVIYE';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00069', N'Aksuvital Zencefilli Macun 300 Gr', @kat, @birim, 476.45, 733.00, '8684727018306', N'Ürün Bilgisi Aktar Depo Aksuvital Zencefilli Macun 300 Gr', 1);
END
GO

-- ADY-00070: AzgınTeke Otu Macunu ERKEK 225 gr
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00070')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TAKVIYE';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00070', N'AzgınTeke Otu Macunu ERKEK 225 gr', @kat, @birim, 384.80, 592.00, '8684727051020', N'Ürün Bilgisi BUTİK ÜRETİM İçeriğindeki tüm bileşenler taze mahsül A kalite olup ,haftalık olarak 300-320 kavanoz kapasiteli  ufak kazanlar da  üretilen en fazla  4-5 ay içinde tüketilmesi gereken  her kullanımında da karıştırılması gereken özel bir karışımdır. Geleneksel Asya tıb', 1);
END
GO

-- ADY-00071: AzgınTeke Otu Macunu ERKEK
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00071')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TAKVIYE';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00071', N'AzgınTeke Otu Macunu ERKEK', @kat, @birim, 384.15, 591.00, '8684727055622', N'Ürün Bilgisi ✔ Aynı gün kargo: Aktar Diyarı güvencesiyle, 15:00''e kadar verilen siparişler aynı gün kargoda. ✔ Kapıda ödeme mi istiyorsunuz? Kapıda ödemeli sipariş için WhatsApp''tan yazmanız yeterli. WhatsApp''tan Kapıda Ödemeli Sipariş Ver AzgınTeke Otu Macunu 225 g , Toroslarda ', 1);
END
GO

-- ADY-00072: AzgınTeke Otu Macunu KADIN
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00072')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TAKVIYE';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00072', N'AzgınTeke Otu Macunu KADIN', @kat, @birim, 384.80, 592.00, '8684727051037', N'Ürün Bilgisi Geleneksel Asya tıbbında yaklaşık 1000 yıldır kullanılmaktadır.;Adet dönemlerinde sancıyı azaltır .İçeriğindeki civanperçemi tozu  ile  ödem artırır. stresi azaltır .Böbrek fonksiyonlarını iyileştirmek, doğurganlığı ve libidoyu artırmak için bir yang toniği yapımında', 1);
END
GO

-- ADY-00073: Balen Sıvı Propolis 30 Ml
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00073')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TAKVIYE';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00073', N'Balen Sıvı Propolis 30 Ml', @kat, @birim, 113.75, 175.00, '8684727016555', N'Ürün Bilgisi Aktar Depo Balen Sıvı Propolis 30 Ml', 1);
END
GO

-- ADY-00074: Bisina Macun Net 400 Gr
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00074')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TAKVIYE';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00074', N'Bisina Macun Net 400 Gr', @kat, @birim, 157.30, 242.00, '8684727018016', N'Ürün Bilgisi Aktar Depo Bisina Macun Net 400 Gr', 1);
END
GO

-- ADY-00075: Gürbüz Padişah Macunu 225 Gr
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00075')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TAKVIYE';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00075', N'Gürbüz Padişah Macunu 225 Gr', @kat, @birim, 73.45, 113.00, '8684727017606', N'Ürün Bilgisi Aktar Depo Gürbüz Padişah Macunu 225 Gr', 1);
END
GO

-- ADY-00076: Mindivan Zencefilli Macun 420 Gr
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00076')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TAKVIYE';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00076', N'Mindivan Zencefilli Macun 420 Gr', @kat, @birim, 267.80, 412.00, '8684727017828', N'Ürün Bilgisi Aktar Depo Mindivan Zencefilli Macun 420 Gr', 1);
END
GO

-- ADY-00077: Osmanlı Sıvı Propolis 20 Cc
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00077')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TAKVIYE';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00077', N'Osmanlı Sıvı Propolis 20 Cc', @kat, @birim, 102.05, 157.00, '8684727016517', N'Ürün Bilgisi Aktar Depo Osmanlı Sıvı Propolis 20 Cc', 1);
END
GO

-- ADY-00078: Propolis Toz %100 Saf Ekstrat
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00078')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TAKVIYE';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00078', N'Propolis Toz %100 Saf Ekstrat', @kat, @birim, 2911.93, 4479.90, '8684727008055', N'Ürün Bilgisi Aktar Diyarı''ndan %100 Saf Propolis Toz Ekstrat 1000 GR: Doğadan Gelen Safiyet Aktar Diyarı''nın özenle hazırladığı %100 saf propolis toz ekstrat, doğal içeriğiyle öne çıkıyor. Gıda takviyeleri kategorisinde yer alan bu özel ürün, 1000 gramlık ambalajı ile uzun süreli', 1);
END
GO

-- ADY-00079: Balen Enginar Plus Kapsül
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00079')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TATLI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00079', N'Balen Enginar Plus Kapsül', @kat, @birim, 489.45, 753.00, '8684727018528', N'Balen Enginar Plus Kapsül - demo import', 1);
END
GO

-- ADY-00080: Balen Sawpalmetto Kapsül -cüce Palmiye
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00080')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TATLI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00080', N'Balen Sawpalmetto Kapsül -cüce Palmiye', @kat, @birim, 240.50, 370.00, '8684727018535', N'Balen Sawpalmetto Kapsül -cüce Palmiye - demo import', 1);
END
GO

-- ADY-00081: Balmumu A Kalite Kapaklı
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00081')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TATLI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00081', N'Balmumu A Kalite Kapaklı', @kat, @birim, 858.00, 1320.00, '8684727020590', N'Ürün Bilgisi Aktar Depo Balmumu A Kalite Kapaklı', 1);
END
GO

-- ADY-00082: Dolmalık Helvalık Yer Fıstığı
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00082')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TATLI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00082', N'Dolmalık Helvalık Yer Fıstığı', @kat, @birim, 504.40, 776.00, '8684727029661', N'Ürün Bilgisi Aktar Depo Dolmalık Helvalık Yer Fıstığı', 1);
END
GO

-- ADY-00083: Pekmez Toprağı 250 GR
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00083')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TATLI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00083', N'Pekmez Toprağı 250 GR', @kat, @birim, 26.65, 41.00, '8684727081546', N'Ürün Bilgisi Aktar Depo Pekmez Toprağı 250 GR', 1);
END
GO

-- ADY-00084: Şenay Andız Pekmezi 450gr
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00084')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TATLI';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00084', N'Şenay Andız Pekmezi 450gr', @kat, @birim, 176.80, 272.00, '8684727027629', N'Şenay Andız Pekmezi 450gr - demo import', 1);
END
GO

-- ADY-00085: Acı Çehre Tohumu Akdiken Yeşil
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00085')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TOHUM';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00085', N'Acı Çehre Tohumu Akdiken Yeşil', @kat, @birim, 649.94, 999.90, '8684727048433', N'Ürün Bilgisi Aktar Diyarı''nın özenle seçtiği, 1 kilogramlık Acı Çehre Tohumu Akdiken Yeşil ile doğanın gücünü mutfağınıza taşıyın. Aktar Diyarı, kalite ve doğallıktan ödün vermeyen yaklaşımıyla sizler için en iyisini sunar. Bu değerli tohumlar, geleneksel tariflerinize eşsiz bir ', 1);
END
GO

-- ADY-00086: Ardıç Tohumu Kırmızı Öğütülmüş
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00086')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TOHUM';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00086', N'Ardıç Tohumu Kırmızı Öğütülmüş', @kat, @birim, 256.69, 394.90, '8684727045012', N'Ürün Bilgisi Aktar Diyarı''nın özenle hazırladığı Ardıç Tohumu Kırmızı Öğütülmüş, mutfaklarınıza ve yaşamınıza doğallık katmak için ideal bir seçenektir. Kalitesiyle öne çıkan Aktar Diyarı markamızın sunduğu bu özel ürün, zengin aroması ve dokusuyla öne çıkar. Öğütülmüş ardıç tohu', 1);
END
GO

-- ADY-00087: Ardıç Tohumu Siyah
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00087')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TOHUM';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00087', N'Ardıç Tohumu Siyah', @kat, @birim, 182.58, 280.90, '8684727042523', N'Ürün Bilgisi Aktar Diyarı''nın özenle seçilmiş Ardıç Tohumu Siyah 1000 GR ürünü ile doğanın gücünü mutfağınıza ve yaşamınıza taşıyın. Bitkiler kategorisinin değerli bir üyesi olan bu özel ardıç tohumu, hem lezzet hem de kullanım çeşitliliği sunar. Aktar Diyarı olarak, en taze ve k', 1);
END
GO

-- ADY-00088: Çörek Otu  Çörekotu
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00088')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TOHUM';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00088', N'Çörek Otu  Çörekotu', @kat, @birim, 211.83, 325.90, '8684727001254', N'Ürün Bilgisi Aktar Diyarı''ndan 1000 GR Çörek Otu ile mutfaklarınıza eşsiz bir lezzet ve doğallık katın. Aktar Diyarı kalitesiyle sunulan bu özel çörek otu, baharat kategorisinin en gözde ürünlerinden biridir. Yoğun aroması ve zengin dokusuyla her tarifinize fark katacak 1000 GR Ç', 1);
END
GO

-- ADY-00089: Mindivan Kereviz Tohumlu Macun 420g
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00089')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TOHUM';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00089', N'Mindivan Kereviz Tohumlu Macun 420g', @kat, @birim, 379.60, 584.00, '8684727017798', N'Ürün Bilgisi Aktar Depo Mindivan Kereviz Tohumlu Macun 420g', 1);
END
GO

-- ADY-00090: Shf Çörek Otu Softjel Kps100*1000mg
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00090')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TOHUM';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00090', N'Shf Çörek Otu Softjel Kps100*1000mg', @kat, @birim, 405.60, 624.00, '8684727094140', N'Ürün Bilgisi Aktar Depo Shf Çörek Otu Softjel Kps100*1000mg', 1);
END
GO

-- ADY-00091: Susam Kabuklu Yerli
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00091')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TOHUM';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00091', N'Susam Kabuklu Yerli', @kat, @birim, 266.44, 409.90, '8684727040055', N'Ürün Bilgisi Susam Kabuklu (Yerli) Susam, Pedeliaceae familyasına ait, ana vatanı Afrika olan bir bitki türü. Asya, Avrupa ve Türkiye''nin sıcak bölgelerinde tarımı yapılmaktadır. Kapsül meyvelerinin içinde çok sayıda tohum bulunur ve bunlar baharat olarak kullanılır. Simit, çörek', 1);
END
GO

-- ADY-00092: Susam Kızaran Simitlik
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00092')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'TOHUM';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00092', N'Susam Kızaran Simitlik', @kat, @birim, 170.23, 261.90, '8684727040048', N'Ürün Bilgisi Susam Kızaran (Simitlik) Susam (Sesamum indicum), Pedeliaceae familyasına ait, anavatanı Afrika olan bir bitki türüdür.Asya, Avrupa ve Türkiye''nin sıcak bölgelerinde tarımı yapılmaktadır. Kapsül meyvelerinin içinde çok sayıda tohum bulunur ve bunlar baharat olarak ku', 1);
END
GO

-- ADY-00093: Argan Yağlı Sabunu
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00093')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'YAG';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00093', N'Argan Yağlı Sabunu', @kat, @birim, 86.45, 133.00, '8684727043995', N'Ürün Bilgisi Aktar Diyarı''nın eşsiz Argan Yağlı Sabunu ile tanışın, 125 gramlık bu özel formül ile cildinize hak ettiği değeri verin. Aktar Diyarı olarak, doğanın en değerli armağanlarından biri olan argan yağının eşsiz faydalarını sizler için bir araya getirdik. Cilt bakımında d', 1);
END
GO

-- ADY-00094: At Kestanesi Yağı
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00094')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'YAG';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'ML';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00094', N'At Kestanesi Yağı', @kat, @birim, 435.44, 669.90, '8684727081225', N'Ürün Bilgisi Aktar Diyarı''nın eşsiz kalitedeki ürünü ile tanışın. Doğanın gücünü evinize taşıyan bu özel yağ, Aktar Diyarı güvencesiyle sizlere ulaşıyor.', 1);
END
GO

-- ADY-00095: Balzam Pelesenk Yağı 1 Kg
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00095')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'YAG';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00095', N'Balzam Pelesenk Yağı 1 Kg', @kat, @birim, 1384.50, 2130.00, '8684727013370', N'Ürün Bilgisi Aktar Depo Balzam Pelesenk Yağı 1 Kg', 1);
END
GO

-- ADY-00096: Bamya Tohumu Yağı
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00096')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'YAG';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'ML';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00096', N'Bamya Tohumu Yağı', @kat, @birim, 2371.14, 3647.90, '8684727066161', N'Ürün Bilgisi Aktar Diyarı Bamya Tohumu Yağı ile doğanın eşsiz faydalarını keşfedin. Saf ve doğal bamya tohumlarından soğuk pres yöntemiyle elde edilen bu değerli yağ, zengin içeriğiyle cilt ve saç bakımınızda mucizeler yaratır. Aktar Diyarı kalitesiyle sunulan Bamya Tohumu Yağı, ', 1);
END
GO

-- ADY-00097: Çam Terebentin Yağı
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00097')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'YAG';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'ML';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00097', N'Çam Terebentin Yağı', @kat, @birim, 2808.59, 4320.90, '8684727059217', N'Ürün Bilgisi Çam terebentin yağı, kozalakların gövdesinden ve iğneli yapraklarının işlemlerden geçmesi sonucunda üretilir. Damıtma yöntemi kullanılarak doğal şekilde üretilen bu nadir yağ, insan vücudu için oldukça faydalıdır. Saç sağlığı amacıyla maske olarak sıklıkla tercih edi', 1);
END
GO

-- ADY-00098: Çörek Otu Yağı
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00098')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'YAG';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'ML';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00098', N'Çörek Otu Yağı', @kat, @birim, 1334.39, 2052.90, '8684727036324', N'Ürün Bilgisi Aktar Diyarı güvencesiyle,  Çörek Otu Yağı ile doğanın mucizesini evinize taşıyın. En kaliteli çörek otu tohumlarından, soğuk sıkım yöntemiyle elde edilen bu saf ve doğal bitkisel yağ, zengin içeriğiyle öne çıkar. Aktar Diyarı markasının kalitesiyle sunulan  Çörek Ot', 1);
END
GO

-- ADY-00099: Çuha Çiçeği Yağı
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00099')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'YAG';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'ML';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00099', N'Çuha Çiçeği Yağı', @kat, @birim, 3164.78, 4868.90, '8684727043230', N'Ürün Bilgisi Aktar Diyarı''nın özenle ürettiği Çuha Çiçeği Yağı ile tanışın. Bitkisel yağlar kategorisinde yer alan bu özel ürün, doğanın sunduğu eşsiz bir armağandır. Aktar Diyarı, yıllardır süregelen tecrübesi ve doğallığa verdiği önemle sizlere en saf ve kaliteli ürünleri sunma', 1);
END
GO

-- ADY-00100: Dökme Çörek Otu Yağı Kg
IF NOT EXISTS (SELECT 1 FROM urun WHERE urun_kod = 'ADY-00100')
BEGIN
    DECLARE @kat INT, @birim INT;
    SELECT @kat = kategori_id FROM urun_kategori WHERE kategori_kod = 'YAG';
    SELECT @birim = birim_id FROM urun_birim WHERE birim_kod = 'KG';
    INSERT INTO urun (urun_kod, urun_adi, kategori_id, birim_id, alis_fiyati, satis_fiyati, barkod, aciklama, aktif)
    VALUES ('ADY-00100', N'Dökme Çörek Otu Yağı Kg', @kat, @birim, 1326.00, 2040.00, '8684727012878', N'Ürün Bilgisi Aktar Depo Dökme Çörek Otu Yağı Kg', 1);
END
GO

PRINT 'Ürün ekleme tamamlandı.';
GO
