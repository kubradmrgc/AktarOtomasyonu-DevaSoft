namespace AktarOtomasyon.Forms.Screens.Ai
{
    partial class FrmAiIcerik
    {
        private System.ComponentModel.IContainer components = null;
        private UcAiIcerik ucAiIcerik;

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
            this.ucAiIcerik = new UcAiIcerik();
            this.SuspendLayout();
            this.ucAiIcerik.Dock = System.Windows.Forms.DockStyle.Fill;
            this.ucAiIcerik.Location = new System.Drawing.Point(0, 0);
            this.ucAiIcerik.Name = "ucAiIcerik";
            this.ucAiIcerik.Size = new System.Drawing.Size(1100, 720);
            this.ucAiIcerik.TabIndex = 0;
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1100, 720);
            this.Controls.Add(this.ucAiIcerik);
            this.Name = "FrmAiIcerik";
            this.Text = "AI İçerik Asistanı";
            this.Load += new System.EventHandler(this.FrmAiIcerik_Load);
            this.ResumeLayout(false);
        }
    }
}
