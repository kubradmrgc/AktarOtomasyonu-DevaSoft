-- Fix Turkish category names (Unicode-safe). Run with: sqlcmd -I -f 65001
SET QUOTED_IDENTIFIER ON;
SET ANSI_NULLS ON;
GO
USE [AktarOtomasyon]
GO

UPDATE urun_kategori SET kategori_adi = N'Baharatlar' WHERE kategori_kod = 'BAHARAT';
UPDATE urun_kategori SET kategori_adi = N'Kuruyemişler' WHERE kategori_kod = 'KURUYEMIS';
UPDATE urun_kategori SET kategori_adi = N'Bakliyatlar' WHERE kategori_kod = 'BAKLIYAT';
UPDATE urun_kategori SET kategori_adi = N'Şekerlemeler' WHERE kategori_kod = 'SEKER';
UPDATE urun_kategori SET kategori_adi = N'Kahve ve Çay' WHERE kategori_kod = 'KAHVE';
UPDATE urun_kategori SET kategori_adi = N'Diğer' WHERE kategori_kod = 'DIGER';
UPDATE urun_kategori SET kategori_adi = N'Bitkisel Ürünler' WHERE kategori_kod = 'BITKI';
UPDATE urun_kategori SET kategori_adi = N'Çay ve İçecekler' WHERE kategori_kod = 'CAY';
UPDATE urun_kategori SET kategori_adi = N'Doğal Yağlar' WHERE kategori_kod = 'YAG';
UPDATE urun_kategori SET kategori_adi = N'Tohum ve Taneler' WHERE kategori_kod = 'TOHUM';
UPDATE urun_kategori SET kategori_adi = N'Doğal Kozmetik' WHERE kategori_kod = 'KOZMETIK';
UPDATE urun_kategori SET kategori_adi = N'Takviye Ürünleri' WHERE kategori_kod = 'TAKVIYE';
UPDATE urun_kategori SET kategori_adi = N'Sıvı Ürünler' WHERE kategori_kod = 'SIVI';
UPDATE urun_kategori SET kategori_adi = N'Tatlı ve İkramlık' WHERE kategori_kod = 'TATLI';
UPDATE urun_kategori SET kategori_adi = N'Macun ve Karışımlar' WHERE kategori_kod = 'MACUN';
UPDATE urun_kategori SET kategori_adi = N'Bal ve Arı Ürünleri' WHERE kategori_kod = 'BAL';
GO

PRINT 'Kategori adlari duzeltildi.';
GO
