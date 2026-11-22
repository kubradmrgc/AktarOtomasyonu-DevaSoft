using System;
using System.Drawing;
using System.Windows.Forms;
using AktarOtomasyon.Forms.Base;
using AktarOtomasyon.Forms.Common;

namespace AktarOtomasyon.Forms.Screens.Stok
{
    /// <summary>
    /// Ürünler ve Stok Yönetimi (URUN_STOK) — UC-Only shell.
    /// </summary>
    public partial class FrmUrunStok : FrmBase
    {
        public FrmUrunStok(string ekranKod) : base(ekranKod)
        {
            InitializeComponent();
            ApplyWideLayout();
        }

        private void ApplyWideLayout()
        {
            MaximumSize = Size.Empty;
            FormBorderStyle = FormBorderStyle.Sizable;
            MaximizeBox = true;
            MinimizeBox = true;
            AutoScroll = true;
            ClientSize = new Size(1100, 720);
            BackColor = ModernTheme.Colors.Background;
            Text = "Ürünler ve Stok Yönetimi";
        }

        private void FrmUrunStok_Load(object sender, EventArgs e)
        {
            ucUrunStok.LoadData();
        }

        public override void RefreshScreenData()
        {
            if (ucUrunStok != null)
                ucUrunStok.LoadData();
        }

        protected override bool OnayliKapat()
        {
            return true;
        }
    }
}
