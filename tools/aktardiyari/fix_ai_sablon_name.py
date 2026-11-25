# -*- coding: utf-8 -*-
import pyodbc

conn = pyodbc.connect(
    "Driver={ODBC Driver 17 for SQL Server};"
    "Server=.\\SQLEXPRESS;Database=AktarOtomasyon;Trusted_Connection=yes;"
)
cur = conn.cursor()
cur.execute(
    "UPDATE ai_sablon SET sablon_adi = ?, aciklama = ? WHERE sablon_kod = 'URUN_DETAY_V1'",
    "Ürün Detay Ekranı - Yapılandırılmış İçerik",
    "Ürün detay ekranı için yapılandırılmış AI içerik (fayda, kullanım, uyarı, kombinasyon).",
)
conn.commit()
cur.execute("SELECT sablon_kod, sablon_adi FROM ai_sablon WHERE sablon_kod = 'URUN_DETAY_V1'")
print(cur.fetchone())
conn.close()
