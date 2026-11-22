using System;
using System.Drawing;
using System.Windows.Forms;
using AktarOtomasyon.Forms.Base;
using AktarOtomasyon.Forms.Common;

namespace AktarOtomasyon.Forms.Screens.Ai
{
    /// <summary>
    /// AI İçerik Asistanı (AI_ICERIK) — UC-Only shell.
    /// </summary>
    public partial class FrmAiIcerik : FrmBase
    {
        public FrmAiIcerik(string ekranKod) : base(ekranKod)
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
            Text = "AI İçerik Asistanı";
        }

        private void FrmAiIcerik_Load(object sender, EventArgs e)
        {
            ucAiIcerik.LoadData();
        }

        public override void RefreshScreenData()
        {
            if (ucAiIcerik != null)
                ucAiIcerik.LoadData();
        }

        protected override bool OnayliKapat()
        {
            return true;
        }
    }
}
