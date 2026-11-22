namespace AktarOtomasyon.Forms.Screens.Stok
{
    partial class FrmUrunStok
    {
        private System.ComponentModel.IContainer components = null;
        private UcUrunStok ucUrunStok;

        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        private void InitializeComponent()
        {
            this.ucUrunStok = new UcUrunStok();
            this.SuspendLayout();
            //
            // ucUrunStok
            //
            this.ucUrunStok.Dock = System.Windows.Forms.DockStyle.Fill;
            this.ucUrunStok.Location = new System.Drawing.Point(0, 0);
            this.ucUrunStok.Name = "ucUrunStok";
            this.ucUrunStok.Size = new System.Drawing.Size(1100, 720);
            this.ucUrunStok.TabIndex = 0;
            //
            // FrmUrunStok
            //
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1100, 720);
            this.Controls.Add(this.ucUrunStok);
            this.Name = "FrmUrunStok";
            this.Text = "Ürünler ve Stok Yönetimi";
            this.Load += new System.EventHandler(this.FrmUrunStok_Load);
            this.ResumeLayout(false);
        }
    }
}
