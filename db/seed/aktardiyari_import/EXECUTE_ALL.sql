-- Run all Aktar Diyarı import seeds
USE [AktarOtomasyon]
GO
:r 01_categories.sql
:r 02_products.sql
:r 03_stock_settings.sql
:r 04_stock_movements.sql
PRINT 'Aktar Diyarı import tamamlandı.';
GO
