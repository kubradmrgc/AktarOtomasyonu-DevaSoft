using System;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Windows.Forms;
using AktarOtomasyon.Forms.Base;
using AktarOtomasyon.Forms.Common;
using AktarOtomasyon.Forms.Managers;
using AktarOtomasyon.Util.DataAccess;
using DevExpress.XtraCharts;
using DevExpress.XtraEditors;

namespace AktarOtomasyon.Forms.Screens.Dashboard
{
    /// <summary>
    /// Ana Dashboard UserControl.
    /// Sprint 9: Real-time dashboard with SP integration, Modern Widget Layout
    /// STANDART: Tüm business logic burada - form sadece shell.
    /// </summary>
    public partial class UcANA_DASH : UcBase
    {
        public UcANA_DASH()
        {
            InitializeComponent();
        }

        public override void LoadData()
        {
            try
            {
                ApplyWelcomeText();
                ApplyCardStyling();

                GridHelper.ApplyStandardFormatting(gvBildirimler);
                GridHelper.ApplyStandardFormatting(gvHareketler);

                GridHelper.FormatDateColumn(colTarih);
                GridHelper.FormatDateColumn(colHareketTarih);
                GridHelper.FormatQuantityColumn(colMiktar);

                LoadKritikStokWidget();
                LoadBekleyenSiparisWidget();
                LoadBildirimWidget();
                LoadBugunSatisWidget();
                LoadSonHareketlerWidget();
                SetupSalesTrendChart();
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage(string.Format("Dashboard.LoadData error: {0}", ex.Message), "DASHBOARD");
                MessageHelper.ShowError("Dashboard yüklenirken hata oluştu.");
            }
        }

        /// <summary>
        /// Applies modern card styling with hover effects to dashboard widgets
        /// </summary>
        private void ApplyCardStyling()
        {
            BackColor = ModernTheme.Colors.Background;
            pnlRoot.Appearance.BackColor = ModernTheme.Colors.Background;
            pnlHeader.Appearance.BackColor = ModernTheme.Colors.Background;
            pnlTopWidgets.Appearance.BackColor = ModernTheme.Colors.Background;
            pnlCenter.Appearance.BackColor = ModernTheme.Colors.Background;
            pnlActions.Appearance.BackColor = ModernTheme.Colors.Background;

            ModernTheme.ApplyModernCard(widgetKritikStok);
            ModernTheme.ApplyModernCard(widgetBekleyenSiparis);
            ModernTheme.ApplyModernCard(widgetTotalUrun);
            ModernTheme.ApplyModernCard(widgetBildirim);

            ModernTheme.ApplyModernGroup(grpChart);
            ModernTheme.ApplyModernGroup(grpBildirimlerGrid);
            ModernTheme.ApplyModernGroup(grpHareketlerGrid);
            ModernTheme.ApplyModernButton(btnRefresh, ModernTheme.Colors.PrimaryLight);
            ModernTheme.ApplyModernButton(btnYeniSatis, ModernTheme.Colors.Primary, true);
            ModernTheme.ApplyModernButton(btnUrunEkle, ModernTheme.Colors.Olive, true);
            ModernTheme.ApplyModernButton(btnSiparisOlustur, ModernTheme.Colors.Terracotta, true);
            ModernTheme.ApplyModernButton(btnAiIcerik, ModernTheme.Colors.PrimaryDark, true);

            ApplyModernLabelStyles();
        }

        /// <summary>
        /// Applies modern typography to dashboard labels
        /// </summary>
        private void ApplyModernLabelStyles()
        {
            lblWelcome.Appearance.ForeColor = ModernTheme.Colors.Primary;
            lblSubtitle.Appearance.ForeColor = ModernTheme.Colors.TextSecondary;

            // Title labels
            lblKritikStokTitle.Appearance.Font = ModernTheme.Typography.H6;
            lblBekleyenSiparisTitle.Appearance.Font = ModernTheme.Typography.H6;
            lblTotalUrunTitle.Appearance.Font = ModernTheme.Typography.H6;
            lblBildirimTitle.Appearance.Font = ModernTheme.Typography.H6;
            lblKritikStokTitle.Appearance.ForeColor = ModernTheme.Colors.TextSecondary;
            lblBekleyenSiparisTitle.Appearance.ForeColor = ModernTheme.Colors.TextSecondary;
            lblTotalUrunTitle.Appearance.ForeColor = ModernTheme.Colors.TextSecondary;
            lblBildirimTitle.Appearance.ForeColor = ModernTheme.Colors.TextSecondary;
            lblKritikStokTitle.Appearance.Options.UseForeColor = true;
            lblBekleyenSiparisTitle.Appearance.Options.UseForeColor = true;
            lblTotalUrunTitle.Appearance.Options.UseForeColor = true;
            lblBildirimTitle.Appearance.Options.UseForeColor = true;

            // Count labels (large numbers)
            lblKritikStokCount.Appearance.Font = ModernTheme.Typography.H2;
            lblBekleyenSiparisCount.Appearance.Font = ModernTheme.Typography.H2;
            lblTotalUrunCount.Appearance.Font = ModernTheme.Typography.H2;
            lblBildirimCount.Appearance.Font = ModernTheme.Typography.H2;
            lblTotalUrunCount.Appearance.ForeColor = ModernTheme.Colors.Primary;
            lblKritikStokCount.Appearance.ForeColor = ModernTheme.Colors.Terracotta;
            lblBekleyenSiparisCount.Appearance.ForeColor = ModernTheme.Colors.Warning;
            lblBildirimCount.Appearance.ForeColor = ModernTheme.Colors.Success;
            lblTotalUrunCount.Appearance.Options.UseForeColor = true;
            lblKritikStokCount.Appearance.Options.UseForeColor = true;
            lblBekleyenSiparisCount.Appearance.Options.UseForeColor = true;
            lblBildirimCount.Appearance.Options.UseForeColor = true;

            // Description labels
            lblKritikStokDesc.Appearance.Font = ModernTheme.Typography.Caption;
            lblBekleyenSiparisDesc.Appearance.Font = ModernTheme.Typography.Caption;
            lblTotalUrunDesc.Appearance.Font = ModernTheme.Typography.Caption;
            lblBildirimDesc.Appearance.Font = ModernTheme.Typography.Caption;
            lblKritikStokDesc.Appearance.ForeColor = ModernTheme.Colors.TextSecondary;
            lblBekleyenSiparisDesc.Appearance.ForeColor = ModernTheme.Colors.TextSecondary;
            lblTotalUrunDesc.Appearance.ForeColor = ModernTheme.Colors.TextSecondary;
            lblBildirimDesc.Appearance.ForeColor = ModernTheme.Colors.TextSecondary;
            lblKritikStokDesc.Appearance.Options.UseForeColor = true;
            lblBekleyenSiparisDesc.Appearance.Options.UseForeColor = true;
            lblTotalUrunDesc.Appearance.Options.UseForeColor = true;
            lblBildirimDesc.Appearance.Options.UseForeColor = true;
        }

        private void ApplyWelcomeText()
        {
            string displayName = SessionManager.IsAuthenticated
                ? (SessionManager.AdSoyad ?? SessionManager.KullaniciAdi)
                : null;

            if (string.IsNullOrWhiteSpace(displayName))
                displayName = "DevaSoft";

            var parts = displayName.Trim().Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
            var firstName = parts.Length > 0 ? parts[0] : displayName.Trim();
            lblWelcome.Text = string.Format("Hoş geldiniz, {0}", firstName);
            lblSubtitle.Text = DateTime.Now.ToString("dd MMMM yyyy dddd", new CultureInfo("tr-TR"));
        }

        /// <summary>
        /// Loads critical stock summary widget
        /// </summary>
        private void LoadKritikStokWidget()
        {
            try
            {
                var stokService = InterfaceFactory.Stok;
                var kritikStoklar = stokService.KritikListele();

                int kritikAdet = kritikStoklar != null ? kritikStoklar.Count : 0;
                lblKritikStokCount.Text = kritikAdet.ToString();

                lblKritikStokCount.Appearance.ForeColor = kritikAdet > 0
                    ? ModernTheme.Colors.Terracotta
                    : ModernTheme.Colors.Success;
                lblKritikStokCount.Appearance.Options.UseForeColor = true;
                lblKritikStokDesc.Text = kritikAdet > 0 ? "Acil ürün sayısı" : "Stoklar dengede";

                if (kritikAdet > 0)
                {
                    lblKritikStokCount.Font = new Font(lblKritikStokCount.Font, FontStyle.Bold);
                }
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage(string.Format("LoadKritikStokWidget error: {0}", ex.Message), "DASHBOARD");
                lblKritikStokCount.Text = "?";
                lblKritikStokDesc.Text = "Veri alınamadı";
            }
        }

        /// <summary>
        /// Loads pending order summary widget
        /// Calls: sp_dash_bekleyen_siparis_ozet
        /// </summary>
        private void LoadBekleyenSiparisWidget()
        {
            try
            {
                using (var sMan = new SqlManager())
                {
                    var cmd = sMan.CreateCommand("sp_dash_bekleyen_siparis_ozet");
                    var dt = sMan.ExecuteQuery(cmd);

                    if (dt != null && dt.Rows.Count > 0)
                    {
                        var row = dt.Rows[0];
                        int taslakAdet = Convert.ToInt32(row["taslak_adet"]);
                        int gonderildiAdet = Convert.ToInt32(row["gonderildi_adet"]);
                        int kismiAdet = Convert.ToInt32(row["kismi_teslim_adet"]);
                        decimal bekleyenTutar = Convert.ToDecimal(row["bekleyen_tutar"]);

                        // Total pending count
                        int toplamBekleyen = taslakAdet + gonderildiAdet + kismiAdet;
                        lblBekleyenSiparisCount.Text = toplamBekleyen.ToString();

                        lblBekleyenSiparisDesc.Text = bekleyenTutar > 0
                            ? bekleyenTutar.ToString("C2", new CultureInfo("tr-TR"))
                            : "İşlem bekliyor";
                        lblBekleyenSiparisCount.Appearance.ForeColor = toplamBekleyen > 0
                            ? ModernTheme.Colors.Warning
                            : ModernTheme.Colors.Success;
                        lblBekleyenSiparisCount.Appearance.Options.UseForeColor = true;
                    }
                    else
                    {
                        lblBekleyenSiparisCount.Text = "0";
                        lblBekleyenSiparisDesc.Text = "Bekleyen yok";
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage(string.Format("LoadBekleyenSiparisWidget error: {0}", ex.Message), "DASHBOARD");
                lblBekleyenSiparisCount.Text = "?";
                lblBekleyenSiparisDesc.Text = "Veri alınamadı";
            }
        }

        /// <summary>
        /// Loads AI pending count; falls back to unread notifications for older databases.
        /// </summary>
        private void LoadBildirimWidget()
        {
            try
            {
                int aiPendingCount = TryGetAiPendingCount();
                if (aiPendingCount >= 0)
                {
                    lblBildirimCount.Text = aiPendingCount.ToString();
                    lblBildirimDesc.Text = aiPendingCount > 0 ? "AI içerik onayı" : "Onay bekleyen yok";
                    lblBildirimCount.Appearance.ForeColor = aiPendingCount > 0
                        ? ModernTheme.Colors.Success
                        : ModernTheme.Colors.TextSecondary;
                    lblBildirimCount.Appearance.Options.UseForeColor = true;
                    return;
                }

                using (var sMan = new SqlManager())
                {
                    var cmd = sMan.CreateCommand("sp_dash_son_bildirimler");
                    cmd.Parameters.AddWithValue("@limit", 10);
                    var dt = sMan.ExecuteQuery(cmd);

                    if (dt != null && dt.Rows.Count > 0)
                    {
                        // Count unread notifications
                        int okunmamisSayisi = 0;
                        foreach (System.Data.DataRow row in dt.Rows)
                        {
                            if (!Convert.ToBoolean(row["okundu"]))
                                okunmamisSayisi++;
                        }

                        lblBildirimCount.Text = okunmamisSayisi.ToString();
                        lblBildirimDesc.Text = "Bildirim fallback";
                        lblBildirimCount.Appearance.ForeColor = okunmamisSayisi > 0
                            ? ModernTheme.Colors.Success
                            : ModernTheme.Colors.TextSecondary;
                        lblBildirimCount.Appearance.Options.UseForeColor = true;
                        grdBildirimler.DataSource = dt;
                    }
                    else
                    {
                        lblBildirimCount.Text = "0";
                        lblBildirimDesc.Text = "Onay bekleyen yok";
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage(string.Format("LoadBildirimWidget error: {0}", ex.Message), "DASHBOARD");
                lblBildirimCount.Text = "?";
                lblBildirimDesc.Text = "Veri alınamadı";
            }
        }

        /// <summary>
        /// Loads recent stock movements widget
        /// </summary>
        private void LoadSonHareketlerWidget()
        {
            try
            {
                using (var sMan = new SqlManager())
                {
                    var cmd = sMan.CreateCommand("sp_dash_son_stok_hareket");
                    cmd.Parameters.AddWithValue("@limit", 20);
                    var dt = sMan.ExecuteQuery(cmd);

                    grdHareketler.DataSource = dt;
                }
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage(string.Format("LoadSonHareketlerWidget error: {0}", ex.Message), "DASHBOARD");
            }
        }

        private int TryGetAiPendingCount()
        {
            try
            {
                using (var sMan = new SqlManager())
                {
                    if (!TableExists(sMan, "ai_urun_icerik"))
                        return -1;

                    var cmd = sMan.CreateCommand(
                        "SELECT COUNT(*) FROM [dbo].[ai_urun_icerik] WHERE [durum] IN ('TASLAK', 'ONAY_BEKLIYOR')",
                        CommandType.Text);
                    var result = sMan.ExecuteScalar(cmd);
                    return result != null && result != DBNull.Value ? Convert.ToInt32(result) : 0;
                }
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage(string.Format("TryGetAiPendingCount error: {0}", ex.Message), "DASHBOARD");
                return -1;
            }
        }

        private void LoadBugunSatisWidget()
        {
            try
            {
                using (var sMan = new SqlManager())
                {
                    if (!TableExists(sMan, "satis"))
                    {
                        lblTotalUrunCount.Text = "₺—";
                        lblTotalUrunDesc.Text = "Veri yakında";
                        return;
                    }

                    var cmd = sMan.CreateCommand(
                        "SELECT ISNULL(SUM([toplam_tutar]), 0) FROM [dbo].[satis] WHERE CONVERT(date, [satis_tarih]) = CONVERT(date, GETDATE())",
                        CommandType.Text);
                    var result = sMan.ExecuteScalar(cmd);
                    var total = result != null && result != DBNull.Value ? Convert.ToDecimal(result) : 0m;

                    lblTotalUrunCount.Text = total > 0
                        ? total.ToString("C0", new CultureInfo("tr-TR"))
                        : "₺0";
                    lblTotalUrunDesc.Text = total > 0 ? "Bugünkü ciro" : "Bugün satış yok";
                }
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage(string.Format("LoadBugunSatisWidget error: {0}", ex.Message), "DASHBOARD");
                lblTotalUrunCount.Text = "₺—";
                lblTotalUrunDesc.Text = "Veri yakında";
            }
        }

        private bool TableExists(SqlManager sMan, string tableName)
        {
            var cmd = sMan.CreateCommand(
                "SELECT CASE WHEN OBJECT_ID(@table_name, 'U') IS NULL THEN 0 ELSE 1 END",
                CommandType.Text);
            cmd.Parameters.AddWithValue("@table_name", "dbo." + tableName);
            var result = sMan.ExecuteScalar(cmd);
            return result != null && Convert.ToInt32(result) == 1;
        }

        private void SetupSalesTrendChart()
        {
            chartSalesTrend.Series.Clear();

            var series = new Series("Satış", ViewType.Bar);
            var culture = new CultureInfo("tr-TR");
            var today = DateTime.Today;

            for (int i = 6; i >= 0; i--)
            {
                var date = today.AddDays(-i);
                var value = i == 0 ? 42 : 12 + ((date.Day * 7) % 28);
                series.Points.Add(new SeriesPoint(culture.DateTimeFormat.GetAbbreviatedDayName(date.DayOfWeek), value));
            }

            var view = series.View as SideBySideBarSeriesView;
            if (view != null)
            {
                view.Color = ModernTheme.Colors.Olive;
                view.FillStyle.FillMode = FillMode.Solid;
                view.BarWidth = 0.55;
            }

            chartSalesTrend.Series.Add(series);
            chartSalesTrend.BackColor = ModernTheme.Colors.Surface;
            chartSalesTrend.AppearanceNameSerializable = "Light";

            var diagram = chartSalesTrend.Diagram as XYDiagram;
            if (diagram != null)
            {
                diagram.AxisX.Label.TextColor = ModernTheme.Colors.TextSecondary;
                diagram.AxisY.Label.TextColor = ModernTheme.Colors.TextSecondary;
                diagram.AxisX.GridLines.Visible = false;
                diagram.AxisY.GridLines.Color = ModernTheme.Colors.Border;
                diagram.AxisY.WholeRange.AlwaysShowZeroLevel = true;
            }

            if (series.Points.Count > 0)
                series.Points[series.Points.Count - 1].Color = ModernTheme.Colors.Primary;
        }

        public override string SaveData()
        {
            // Dashboard has no save operation
            return null;
        }

        public override void ClearData()
        {
            // Dashboard has no clear operation
        }

        public override bool HasChanges()
        {
            // Dashboard has no unsaved changes
            return false;
        }

        /// <summary>
        /// Opens critical stock screen
        /// </summary>
        private void btnKritikStokDetay_Click(object sender, EventArgs e)
        {
            try
            {
                NavigationManager.OpenScreen("STOK_KRITIK", GetMdiParentForm());
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage(string.Format("btnKritikStokDetay_Click error: {0}", ex.Message), "DASHBOARD");
                MessageHelper.ShowError("Kritik stok ekranı açılırken hata oluştu.");
            }
        }

        /// <summary>
        /// Opens pending orders screen
        /// </summary>
        private void btnSiparisDetay_Click(object sender, EventArgs e)
        {
            try
            {
                NavigationManager.OpenScreen("SIP_LISTE", GetMdiParentForm());
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage(string.Format("btnSiparisDetay_Click error: {0}", ex.Message), "DASHBOARD");
                MessageHelper.ShowError("Sipariş ekranı açılırken hata oluştu.");
            }
        }

        /// <summary>
        /// Opens notification center
        /// </summary>
        private void btnBildirimDetay_Click(object sender, EventArgs e)
        {
            try
            {
                NavigationManager.OpenScreen("AI_MODUL", GetMdiParentForm());
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage(string.Format("btnBildirimDetay_Click error: {0}", ex.Message), "DASHBOARD");
                MessageHelper.ShowError("Bildirim merkezi açılırken hata oluştu.");
            }
        }

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadData();
        }

        private void btnYeniSatis_Click(object sender, EventArgs e)
        {
            NavigationManager.OpenScreen("SATIS_YAP", GetMdiParentForm());
        }

        private void btnUrunEkle_Click(object sender, EventArgs e)
        {
            NavigationManager.OpenScreen("URUN_KART", GetMdiParentForm());
        }

        private void btnSiparisOlustur_Click(object sender, EventArgs e)
        {
            NavigationManager.OpenScreen("SIP_TASLAK", GetMdiParentForm(), null);
        }

        private void btnAiIcerik_Click(object sender, EventArgs e)
        {
            NavigationManager.OpenScreen("AI_MODUL", GetMdiParentForm());
        }

        private Form GetMdiParentForm()
        {
            return ParentForm != null ? (ParentForm.MdiParent ?? ParentForm) : null;
        }
    }
}
