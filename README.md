# Aktar Otomasyonu - DevaSoft

Modern, AI destekli aktar ve eczane otomasyon sistemi. Ürün yönetimi, stok takibi, sipariş yönetimi, satış işlemleri ve AI destekli içerik üretimi özelliklerini içeren kapsamlı bir Windows masaüstü uygulamasıdır.

## 📋 İçindekiler

- [Özellikler](#özellikler)
- [Teknoloji Stack](#teknoloji-stack)
- [Sistem Gereksinimleri](#sistem-gereksinimleri)
- [Kurulum](#kurulum)
- [Veritabanı Kurulumu](#veritabanı-kurulumu)
- [Yapılandırma](#yapılandırma)
- [Kullanım](#kullanım)
- [Proje Yapısı](#proje-yapısı)
- [Geliştirme](#geliştirme)
- [Katkıda Bulunma](#katkıda-bulunma)
- [Lisans](#lisans)

## ✨ Özellikler

### 🛍️ Ürün Yönetimi
- Ürün kartı yönetimi (genel bilgiler, stok ayarları, görseller)
- Ürün kataloğu görüntüleme
- Barkod okuma ve yönetimi
- Türkçe karakter desteği
- Ürün görsel yönetimi
- Kategori ve marka yönetimi

### 📦 Stok Yönetimi
- Stok hareket takibi (giriş/çıkış)
- Kritik stok uyarıları
- Stok durumu raporlama
- Otomatik stok güncelleme

### 📋 Sipariş Yönetimi
- Sipariş taslağı oluşturma
- Tedarikçi yönetimi
- Sipariş onay ve takip
- Sipariş geçmişi

### 💰 Satış İşlemleri
- Hızlı satış ekranı
- Barkod ile ürün ekleme
- Sepet yönetimi
- Satış kayıtları

### 🤖 AI Destekli Özellikler
- AI ile ürün içerik üretimi (Gemini entegrasyonu)
- Ürün açıklama, fayda, kullanım, uyarı bilgileri
- Şablon tabanlı içerik üretimi
- AI modül yönetimi

### 📊 Raporlama ve Analiz
- Dashboard ile özet görünüm
- Stok raporları
- Satış raporları
- Sistem tanılama

### 🔐 Güvenlik
- Kullanıcı yetkilendirme sistemi
- Rol tabanlı erişim kontrolü
- Ekran bazlı izin yönetimi
- Audit log kayıtları

### 🎨 Modern Kullanıcı Arayüzü
- DevExpress WinForms bileşenleri
- Modern mavi tonlu tema
- Responsive tasarım
- Animasyonlu geçişler
- Türkçe dil desteği

## 🛠️ Teknoloji Stack

### Backend
- **.NET Framework 4.8** - Ana framework
- **C#** - Programlama dili
- **SQL Server 2019+** - Veritabanı
- **ADO.NET** - Veri erişim katmanı
- **Stored Procedures** - Veritabanı iş mantığı

### Frontend
- **DevExpress WinForms v25.1** - UI Framework
- **WXI Skin** - Modern tema
- **Custom Theme System** - Özelleştirilmiş renk paleti

### Araçlar
- **Visual Studio 2019+** - IDE
- **SQL Server Management Studio** - Veritabanı yönetimi
- **Git** - Versiyon kontrolü

## 💻 Sistem Gereksinimleri

### Minimum Gereksinimler
- **İşletim Sistemi**: Windows 10/11 veya Windows Server 2016+
- **RAM**: 4 GB (8 GB önerilir)
- **Disk Alanı**: 2 GB boş alan
- **.NET Framework**: 4.8 veya üzeri
- **SQL Server**: 2019 Express veya üzeri

### Geliştirme Ortamı
- **Visual Studio**: 2019 veya üzeri
- **DevExpress**: v25.1 (lisans gerekli)
- **SQL Server Management Studio**: 18.0 veya üzeri

## 🚀 Kurulum

### 1. Repository'yi Klonlayın

```bash
git clone git@github.com:kubradmrgc/AktarOtomasyonu-DevaSoft.git
cd AktarOtomasyonu-DevaSoft
```

### 2. Gereksinimleri Yükleyin

1. **.NET Framework 4.8** yükleyin (eğer yoksa)
2. **SQL Server 2019 Express** veya üzeri yükleyin
3. **Visual Studio 2019+** yükleyin
4. **DevExpress WinForms** bileşenlerini yükleyin

### 3. NuGet Paketlerini Yükleyin

Visual Studio'da Solution'ı açın ve NuGet paketlerini restore edin:

```powershell
# Solution klasöründe
dotnet restore
```

veya Visual Studio'da:
- Solution Explorer'da Solution'a sağ tıklayın
- "Restore NuGet Packages" seçeneğini seçin

## 🗄️ Veritabanı Kurulumu

### 1. SQL Server'ı Başlatın

SQL Server servisinin çalıştığından emin olun:

```powershell
# PowerShell (Yönetici olarak)
Get-Service -Name MSSQLSERVER
Start-Service -Name MSSQLSERVER
```

### 2. Veritabanını Oluşturun

SQL Server Management Studio (SSMS) ile bağlanın ve aşağıdaki scriptleri sırayla çalıştırın:

#### Adım 1: Schema Oluşturma
```sql
-- db/schema/001_create_tables.sql
-- db/schema/002_create_indexes.sql
-- db/schema/003_sprint9_indexes.sql
```

#### Adım 2: Stored Procedures
```sql
-- db/sp/ klasöründeki tüm .sql dosyalarını çalıştırın
```

#### Adım 3: Security Schema
```sql
-- db/schema/008_sprint7_security_schema_COMPLETE.sql
```

#### Adım 4: Seed Data
```sql
-- db/seed/EXECUTE_ALL.sql
-- veya
-- db/seed/SIMPLE_SEED.sql
```

### 3. Veritabanı Kullanıcıları (Opsiyonel)

Production ortamı için güvenli kullanıcılar oluşturun:

```sql
-- db/security/001_create_db_users.sql
-- db/security/002_grant_permissions.sql
```

### 4. Connection String'i Yapılandırın

`src/AktarOtomasyon.Forms/App.config` dosyasını düzenleyin:

```xml
<connectionStrings>
  <add name="Db" 
       connectionString="Server=localhost;Database=AktarOtomasyon;Trusted_Connection=True;TrustServerCertificate=True;" 
       providerName="System.Data.SqlClient" />
</connectionStrings>
```

**SQL Server Express için:**
```xml
<add name="Db" 
     connectionString="Server=localhost\SQLEXPRESS;Database=AktarOtomasyon;Trusted_Connection=True;TrustServerCertificate=True;" 
     providerName="System.Data.SqlClient" />
```

## ⚙️ Yapılandırma

### App.config Ayarları

`src/AktarOtomasyon.Forms/App.config` dosyasında aşağıdaki ayarları yapabilirsiniz:

#### Path Ayarları
```xml
<appSettings>
  <add key="ReportPath" value=".\reports" />
  <add key="TemplatePath" value=".\templates" />
</appSettings>
```

#### AI Ayarları
```xml
<appSettings>
  <add key="AI_PROVIDER" value="GEMINI" />
  <add key="AI_MODEL" value="gemini-2.5-flash" />
  <add key="AI_API_KEY" value="YOUR_GEMINI_API_KEY" />
  <add key="AI_TIMEOUT_SECONDS" value="30" />
  <add key="AI_MAX_RETRY" value="3" />
</appSettings>
```

> Gerçek API anahtarını repoya koyma. Lokal `App.config` veya environment variable kullan.

### Environment Variables (Opsiyonel)

Production ortamı için environment variables kullanabilirsiniz:

```powershell
# PowerShell (Yönetici olarak)
[System.Environment]::SetEnvironmentVariable("DB_SERVER", "localhost", "Machine")
[System.Environment]::SetEnvironmentVariable("DB_NAME", "AktarOtomasyon", "Machine")
[System.Environment]::SetEnvironmentVariable("DB_TRUSTED_CONNECTION", "true", "Machine")
```

## 📖 Kullanım

### İlk Giriş

1. Uygulamayı başlatın
2. Varsayılan kullanıcı bilgileri:
   - **Kullanıcı Adı**: `admin`
   - **Şifre**: `admin123` (ilk girişten sonra değiştirin!)

### Temel İşlemler

#### Ürün Ekleme
1. Sidebar'dan **Ürünler > Ürün Kartı** seçin
2. Yeni ürün bilgilerini girin
3. Barkod, fiyat, stok bilgilerini ekleyin
4. **Kaydet** butonuna tıklayın

#### Barkod Okuma (Test)
1. Sidebar'dan **Test Barkod Okuma** seçin
2. Barkod numarasını girin
3. **BARKOD OKU** butonuna tıklayın
4. Ürün bulunduğunda otomatik olarak satış ekranına yönlendirilirsiniz

#### Satış Yapma
1. Sidebar'dan **Satış Yap** seçin
2. Barkod okuyun veya ürün seçin
3. Miktarı girin ve sepete ekleyin
4. **Satış Yap** butonuna tıklayın

#### Sipariş Oluşturma
1. Sidebar'dan **Siparişler > Sipariş Taslağı** seçin
2. Tedarikçi seçin (veya yeni tedarikçi ekleyin)
3. Ürünleri ekleyin
4. Siparişi kaydedin

## 📁 Proje Yapısı

```
aktar_otomasyon/
├── src/                          # Kaynak kodlar
│   ├── AktarOtomasyon.Forms/    # Ana Windows Forms uygulaması
│   ├── AktarOtomasyon.*.Service/ # İş mantığı servisleri
│   ├── AktarOtomasyon.*.Interface/ # Interface tanımları
│   └── AktarOtomasyon.Util.*/   # Yardımcı kütüphaneler
├── db/                          # Veritabanı scriptleri
│   ├── schema/                  # Tablo ve index tanımları
│   ├── sp/                      # Stored procedures
│   ├── seed/                    # Seed data scriptleri
│   ├── security/                # Güvenlik scriptleri
│   └── migrations/              # Migration scriptleri
├── docs/                        # Dokümantasyon
│   ├── architecture.md          # Mimari dokümantasyonu
│   ├── ui-standards.md          # UI standartları
│   └── ...                      # Diğer dokümantasyonlar
├── tools/                       # Yardımcı araçlar
├── images/                      # Ürün görselleri
├── templates/                   # Rapor/çıktı şablonları
└── README.md                    # Bu dosya
```

### Önemli Dosyalar

- **`src/AktarOtomasyon.Forms/Program.cs`** - Uygulama giriş noktası
- **`src/AktarOtomasyon.Forms/FrmMain.cs`** - Ana form
- **`src/AktarOtomasyon.Forms/App.config`** - Uygulama yapılandırması
- **`db/seed/EXECUTE_ALL.sql`** - Tüm seed scriptlerini çalıştırır
- **`docs/QUICK_START.md`** - Hızlı başlangıç kılavuzu

## 🔧 Geliştirme

### Kod Standartları

- **C# Coding Standards**: Microsoft C# Coding Conventions
- **Naming**: PascalCase (classes, methods), camelCase (variables)
- **Comments**: XML documentation comments
- **Error Handling**: Try-catch blokları ve ErrorManager kullanımı

### Mimari Pattern

- **Layered Architecture**: Interface → Service → DataAccess
- **Repository Pattern**: Stored Procedure tabanlı veri erişimi
- **Dependency Injection**: InterfaceFactory pattern
- **UI Pattern**: Form → UserControl (UC-Only Pattern)

### Test Etme

```powershell
# Build
dotnet build

# Run
# Visual Studio'dan F5 ile çalıştırın
```

### Debugging

1. Visual Studio'da breakpoint'ler ekleyin
2. F5 ile debug modunda çalıştırın
3. Log dosyaları: `logs/` klasöründe

## 🐛 Sorun Giderme

### SQL Server Bağlantı Sorunları

Eğer SQL Server'a bağlanamıyorsanız:

1. **SQL Server servisinin çalıştığından emin olun:**
   ```powershell
   Get-Service -Name MSSQLSERVER
   ```

2. **SQL Server Configuration Manager'da protokolleri kontrol edin:**
   - Named Pipes: Enabled
   - TCP/IP: Enabled
   - Port: 1433

3. **Connection string'i kontrol edin:**
   - `App.config` dosyasındaki connection string'i doğrulayın
   - SQL Server Express kullanıyorsanız: `localhost\SQLEXPRESS`

4. **Detaylı bilgi için:**
   - `docs/sql-server-connection-troubleshooting.md` dosyasına bakın
   - `tools/Test-SqlConnection.ps1` scriptini çalıştırın

### Türkçe Karakter Sorunları

Eğer Türkçe karakterler düzgün görünmüyorsa:

1. Veritabanı collation'ını kontrol edin: `Turkish_CI_AS`
2. `TextHelper.FixEncoding()` metodunun kullanıldığından emin olun

### DevExpress Lisans Sorunları

DevExpress bileşenleri için geçerli bir lisans gerekir. Trial sürümü kullanıyorsanız, bazı özellikler sınırlı olabilir.

## 📚 Dokümantasyon

Detaylı dokümantasyon için `docs/` klasörüne bakın:

- **`architecture.md`** - Sistem mimarisi
- **`ui-standards.md`** - UI standartları ve best practices
- **`dataaccess.md`** - Veri erişim katmanı kullanımı
- **`security.md`** - Güvenlik yapılandırması
- **`troubleshooting.md`** - Sorun giderme kılavuzu

## 🤝 Katkıda Bulunma

1. Fork edin
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Değişikliklerinizi commit edin (`git commit -m 'Add amazing feature'`)
4. Branch'inizi push edin (`git push origin feature/amazing-feature`)
5. Pull Request oluşturun

### Commit Mesajları

- `feat:` Yeni özellik
- `fix:` Hata düzeltmesi
- `docs:` Dokümantasyon
- `style:` Kod formatı
- `refactor:` Kod refactoring
- `test:` Test ekleme/düzeltme
- `chore:` Build, config değişiklikleri

## 📝 Changelog

### v1.0.0 (2026) — Aktar Otomasyonu DevaSoft
- ✅ Ürün yönetimi modülü
- ✅ Stok yönetimi modülü
- ✅ Sipariş yönetimi modülü
- ✅ Satış işlemleri modülü
- ✅ AI destekli içerik üretimi (Gemini)
- ✅ Modern UI tasarımı
- ✅ Barkod okuma desteği
- ✅ Raporlama ve dashboard

## 📄 Lisans

Bu proje özel bir projedir. Tüm hakları saklıdır.

## 👥 Yazar

**Kübra DEMİRGÜÇ** (DevaSoft)

- GitHub: [@kubradmrgc](https://github.com/kubradmrgc)
- Repo: [AktarOtomasyonu-DevaSoft](https://github.com/kubradmrgc/AktarOtomasyonu-DevaSoft)

## 📞 İletişim

Sorularınız veya önerileriniz için GitHub Issues kullanabilirsiniz.
