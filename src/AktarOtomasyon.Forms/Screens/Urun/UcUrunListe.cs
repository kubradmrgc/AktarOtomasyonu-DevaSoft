using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Windows.Forms;
using AktarOtomasyon.Forms.Base;
using AktarOtomasyon.Forms.Common;
using AktarOtomasyon.Forms.Managers;
using AktarOtomasyon.Urun.Interface.Models;
using DevExpress.XtraGrid.Views.Base;

namespace AktarOtomasyon.Forms.Screens.Urun
{
    /// <summary>
    /// Ürün listesi UserControl.
    /// UC-Only Pattern: Tüm iş mantığı bu sınıfta.
    /// </summary>
    public partial class UcUrunListe : UcBase
    {
        private List<UrunListeItemDto> _allProducts = new List<UrunListeItemDto>();

        public UcUrunListe()
        {
            InitializeComponent();
            ApplyGridStandards();
            gvUrunler.CustomUnboundColumnData += gvUrunler_CustomUnboundColumnData;
        }

        /// <summary>
        /// Applies Sprint 9 grid standards
        /// </summary>
        private void ApplyGridStandards()
        {
            GridHelper.ApplyStandardFormatting(gvUrunler);

            // Hide ID column (keep for selection but don't show)
            if (gvUrunler.Columns["UrunId"] != null)
                GridHelper.FormatIdColumn(gvUrunler.Columns["UrunId"], visible: false);

            // Format date columns if they exist
            if (gvUrunler.Columns["OlusturmaTarih"] != null)
                GridHelper.FormatDateColumn(gvUrunler.Columns["OlusturmaTarih"]);
            if (gvUrunler.Columns["GuncellemeTarih"] != null)
                GridHelper.FormatDateColumn(gvUrunler.Columns["GuncellemeTarih"]);

            // Format money columns
            if (gvUrunler.Columns["AlisFiyati"] != null)
                GridHelper.FormatMoneyColumn(gvUrunler.Columns["AlisFiyati"]);
            if (gvUrunler.Columns["SatisFiyati"] != null)
                GridHelper.FormatMoneyColumn(gvUrunler.Columns["SatisFiyati"]);

            // Format quantity columns
            if (gvUrunler.Columns["MevcutStok"] != null)
                GridHelper.FormatQuantityColumn(gvUrunler.Columns["MevcutStok"]);

            // Format Category GridLookUpEdit
            var gridView = lkpKategori.Properties.PopupView as DevExpress.XtraGrid.Views.Grid.GridView;
            if (gridView != null)
            {
                GridHelper.ApplyStandardFormatting(gridView);
            }
        }

        /// <summary>
        /// Verileri yükler: Kategori lookup ve ürün listesi.
        /// </summary>
        public override void LoadData()
        {
            try
            {
                LoadKategoriLookup();
                ApplyFilter();
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage(string.Format("UcUrunListe.LoadData error: {0}", ex.Message), "URUN");
                MessageHelper.ShowError(string.Format("Veriler yüklenirken hata: {0}", ex.Message));
            }
        }

        /// <summary>
        /// Kategori lookup'ı cache'den yükler.
        /// </summary>
        private void LoadKategoriLookup()
        {
            var kategoriler = UrunLookupProvider.GetKategoriler();

            // "Tüm Kategoriler" seçeneği için 0 değerli dummy item ekle
            var extendedList = new List<UrunKategoriDto>();
            extendedList.Add(new UrunKategoriDto { KategoriId = 0, KategoriAdi = "Tüm Kategoriler" });
            extendedList.AddRange(kategoriler);

            lkpKategori.Properties.DataSource = extendedList;
            lkpKategori.Properties.DisplayMember = "KategoriAdi";
            lkpKategori.Properties.ValueMember = "KategoriId";
            lkpKategori.EditValue = 0; // Varsayılan olarak "Tüm Kategoriler"

            // Configure GridLookUpEdit Columns
            var view = lkpKategori.Properties.PopupView as DevExpress.XtraGrid.Views.Grid.GridView;
            if (view != null)
            {
                view.PopulateColumns();
                if (view.Columns["KategoriId"] != null) view.Columns["KategoriId"].Visible = false;
                if (view.Columns["UstKategoriId"] != null) view.Columns["UstKategoriId"].Visible = false;
                
                if (view.Columns["KategoriAdi"] != null)
                {
                    view.Columns["KategoriAdi"].Caption = "Kategori";
                }
                
                view.BestFitColumns();
                lkpKategori.Properties.BestFitMode = DevExpress.XtraEditors.Controls.BestFitMode.BestFitResizePopup;
            }
        }

        /// <summary>
        /// Filtreyi uygular ve grid'i günceller.
        /// Sprint 9: Enhanced with empty state handling
        /// </summary>
        private void ApplyFilter()
        {
            try
            {
                gvUrunler.BeginUpdate();
                GridHelper.DisableColumnFilters(gvUrunler);

                int? kategoriId = null;
                if (lkpKategori.EditValue != null && lkpKategori.EditValue != DBNull.Value)
                {
                    int kid;
                    if (int.TryParse(lkpKategori.EditValue.ToString(), out kid) && kid > 0)
                        kategoriId = kid;
                }

                var filtre = new UrunFiltreDto
                {
                    Aktif = chkAktif.Checked ? true : (bool?)null,
                    KategoriId = kategoriId,
                    Arama = string.IsNullOrWhiteSpace(txtArama.Text) ? null : txtArama.Text.Trim()
                };

                _allProducts = InterfaceFactory.Urun.Listele(filtre) ?? new List<UrunListeItemDto>();

                if (_allProducts != null)
                {
                    foreach (var item in _allProducts)
                    {
                        item.UrunAdi = TextHelper.FixEncoding(item.UrunAdi);
                        item.KategoriAdi = TextHelper.FixEncoding(item.KategoriAdi);
                        item.BirimAdi = TextHelper.FixEncoding(item.BirimAdi);
                    }
                }

                // Üst paneldeki "Sadece Kritik Stok" — grid kolon filtresi değil, mantıksal filtre
                if (chkKritik.Checked)
                {
                    var kritikIds = new HashSet<int>();
                    try
                    {
                        var kritikListe = InterfaceFactory.Stok.KritikListele();
                        if (kritikListe != null)
                        {
                            foreach (var k in kritikListe)
                                kritikIds.Add(k.UrunId);
                        }
                    }
                    catch (Exception exKritik)
                    {
                        ErrorManager.LogMessage("Kritik stok filtresi: " + exKritik.Message, "URUN");
                    }

                    _allProducts = _allProducts.Where(p => kritikIds.Contains(p.UrunId)).ToList();
                }

                grdUrunler.DataSource = null;
                grdUrunler.DataSource = _allProducts;
                gvUrunler.BestFitColumns();
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage(string.Format("UcUrunListe.ApplyFilter error: {0}", ex), "URUN");
                MessageHelper.ShowError(string.Format("Filtreleme hatası: {0}", ex.Message));
                _allProducts = new List<UrunListeItemDto>();
                grdUrunler.DataSource = _allProducts;
            }
            finally
            {
                gvUrunler.EndUpdate();
            }
        }

        private void gvUrunler_CustomUnboundColumnData(object sender, CustomColumnDataEventArgs e)
        {
            if (e.Column == null || e.Column.FieldName != "Thumbnail" || !e.IsGetData)
                return;

            var row = e.Row as UrunListeItemDto;
            if (row == null || string.IsNullOrWhiteSpace(row.AnaGorselPath) || !File.Exists(row.AnaGorselPath))
            {
                e.Value = null;
                return;
            }

            try
            {
                using (var stream = new FileStream(row.AnaGorselPath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
                using (var img = Image.FromStream(stream))
                {
                    e.Value = new Bitmap(img);
                }
            }
            catch
            {
                e.Value = null;
            }
        }

        /// <summary>
        /// Liste dışarıdan yenilenmek istendiğinde çağrılır (URUN_KART'tan dönüşte).
        /// </summary>
        public void RefreshList()
        {
            ApplyFilter();
        }

        #region Event Handlers - Filter

        private void btnAra_Click(object sender, EventArgs e)
        {
            ApplyFilter();
        }

        private void btnTemizle_Click(object sender, EventArgs e)
        {
            txtArama.Text = string.Empty;
            lkpKategori.EditValue = 0;
            chkAktif.Checked = true;
            chkKritik.Checked = false;
            ApplyFilter();
        }

        #endregion

        #region Event Handlers - Actions

        private void btnYeniUrun_Click(object sender, EventArgs e)
        {
            try
            {
                // Yeni ürün modu: UrunId = null
                NavigationManager.OpenScreen("URUN_KART", ParentFrm.MdiParent, null);
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage(string.Format("UcUrunListe.btnYeniUrun_Click error: {0}", ex.Message), "URUN");
                MessageHelper.ShowError(string.Format("Yeni ürün ekranı açılamadı: {0}", ex.Message));
            }
        }

        private void btnDuzenle_Click(object sender, EventArgs e)
        {
            OpenSelectedUrunForEdit();
        }

        private void btnPasifle_Click(object sender, EventArgs e)
        {
            try
            {
                var selectedRow = gvUrunler.GetFocusedRow() as UrunListeItemDto;
                if (selectedRow == null)
                {
                    MessageHelper.ShowWarning("Lütfen pasifleştirilecek ürünü seçin.");
                    return;
                }

                var confirmResult = MessageHelper.ShowConfirmation(
                    string.Format("{0} ürününü pasifleştirmek istediğinizden emin misiniz?", selectedRow.UrunAdi),
                    "Pasifleştirme Onayı"
                );

                if (confirmResult)
                {
                    var error = InterfaceFactory.Urun.Pasifle(selectedRow.UrunId, cascadeStokAyar: false);

                    if (string.IsNullOrEmpty(error))
                    {
                        MessageHelper.ShowSuccess(string.Format("{0} başarıyla pasifleştirildi.", selectedRow.UrunAdi));
                        ApplyFilter(); // Grid'i yenile
                    }
                    else
                    {
                        MessageHelper.ShowError(string.Format("Pasifleştirme hatası: {0}", error));
                    }
                }
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage(string.Format("UcUrunListe.btnPasifle_Click error: {0}", ex.Message), "URUN");
                MessageHelper.ShowError(string.Format("Pasifleştirme hatası: {0}", ex.Message));
            }
        }

        private void btnYenile_Click(object sender, EventArgs e)
        {
            ApplyFilter();
        }

        private void btnKatalog_Click(object sender, EventArgs e)
        {
            try
            {
                var parent = this.FindForm();
                if (parent == null)
                {
                    MessageHelper.ShowError("Parent form bulunamadı.");
                    return;
                }
                
                if (parent.MdiParent == null)
                {
                    // Maybe it is not MDI child? try opening with parent itself or null
                    NavigationManager.OpenScreen("URUN_KATALOG", parent);
                }
                else
                {
                    NavigationManager.OpenScreen("URUN_KATALOG", parent.MdiParent);
                }
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage("Katalog açma hatası: " + ex.ToString(), "URUN");
                MessageHelper.ShowError("Hata: " + ex.Message);
            }
        }

        #endregion

        #region Event Handlers - Grid

        private void gvUrunler_FocusedRowChanged(object sender, DevExpress.XtraGrid.Views.Base.FocusedRowChangedEventArgs e)
        {
            var selectedRow = gvUrunler.GetFocusedRow() as UrunListeItemDto;
            btnDuzenle.Enabled = (selectedRow != null);
            btnPasifle.Enabled = (selectedRow != null);
        }

        private void gvUrunler_DoubleClick(object sender, EventArgs e)
        {
            OpenSelectedUrun();
        }

        private void gvUrunler_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
            {
                OpenSelectedUrun();
                e.Handled = true;
            }
        }

        #endregion

        #region Helper Methods

        /// <summary>
        /// Seçili ürünü detay görünümünde açar (salt okunur).
        /// Çift tık ve Enter tuşu bu metodu çağırır.
        /// </summary>
        private void OpenSelectedUrun()
        {
            try
            {
                var selectedRow = gvUrunler.GetFocusedRow() as UrunListeItemDto;
                if (selectedRow == null)
                {
                    MessageHelper.ShowWarning("Lütfen görüntülenecek ürünü seçin.");
                    return;
                }

                // Detay görünümü: URUN_DETAY (salt okunur)
                NavigationManager.OpenScreen("URUN_DETAY", ParentFrm.MdiParent, selectedRow.UrunId);
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage(string.Format("UcUrunListe.OpenSelectedUrun error: {0}", ex.Message), "URUN");
                MessageHelper.ShowError(string.Format("Ürün detayı açılamadı: {0}", ex.Message));
            }
        }

        /// <summary>
        /// Seçili ürünü düzenleme modunda açar.
        /// "Düzenle" butonu bu metodu çağırır.
        /// </summary>
        private void OpenSelectedUrunForEdit()
        {
            try
            {
                var selectedRow = gvUrunler.GetFocusedRow() as UrunListeItemDto;
                if (selectedRow == null)
                {
                    MessageHelper.ShowWarning("Lütfen düzenlenecek ürünü seçin.");
                    return;
                }

                // Düzenleme modu: URUN_KART (4 tab'lı edit form)
                NavigationManager.OpenScreen("URUN_KART", ParentFrm.MdiParent, selectedRow.UrunId);
            }
            catch (Exception ex)
            {
                ErrorManager.LogMessage(string.Format("UcUrunListe.OpenSelectedUrunForEdit error: {0}", ex.Message), "URUN");
                MessageHelper.ShowError(string.Format("Ürün kartı açılamadı: {0}", ex.Message));
            }
        }

        #endregion
    }
}
