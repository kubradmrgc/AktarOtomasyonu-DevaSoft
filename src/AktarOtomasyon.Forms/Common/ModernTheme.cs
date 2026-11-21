using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Windows.Forms;
using DevExpress.XtraEditors;
using DevExpress.XtraGrid;
using DevExpress.XtraGrid.Views.Grid;

namespace AktarOtomasyon.Forms.Common
{
    /// <summary>
    /// Modern tema sistemi - Material Design ve Fluent Design prensiplerine dayalı
    /// Tüm uygulama için tutarlı modern görünüm sağlar
    /// </summary>
    public static class ModernTheme
    {
        // DevaSoft Renk Paleti
        public static class Colors
        {
            public static Color Primary = Color.FromArgb(0x1E, 0x3A, 0x2F);
            public static Color PrimaryLight = Color.FromArgb(0x51, 0x64, 0x43);
            public static Color PrimaryDark = Color.FromArgb(0x1A, 0x33, 0x29);
            public static Color PrimaryAccent = Color.FromArgb(0xB3, 0x60, 0x46);

            // Secondary Colors
            public static Color Secondary = Color.FromArgb(0x51, 0x64, 0x43);
            public static Color SecondaryLight = Color.FromArgb(0xE8, 0xEF, 0xE2);
            public static Color SecondaryDark = Color.FromArgb(0x24, 0x35, 0x18);

            // Status Colors
            public static Color Success = Color.FromArgb(0x2D, 0x6A, 0x4F);
            public static Color Warning = Color.FromArgb(0xA6, 0x63, 0x08);
            public static Color Danger = Color.FromArgb(0xB3, 0x60, 0x46);
            public static Color Info = Color.FromArgb(0x51, 0x64, 0x43);

            // Background Colors
            public static Color Background = Color.FromArgb(0xFA, 0xF7, 0xF2);
            public static Color Surface = Color.White;
            public static Color SurfaceHover = Color.FromArgb(0xF7, 0xEA, 0xE5);
            public static Color SurfacePressed = Color.FromArgb(0xE8, 0xEF, 0xE2);

            // Text Colors
            public static Color TextPrimary = Color.FromArgb(0x1C, 0x1C, 0x19);
            public static Color TextSecondary = Color.FromArgb(0x47, 0x52, 0x4C);
            public static Color TextDisabled = Color.FromArgb(0x9D, 0xB5, 0xAA);
            public static Color TextOnPrimary = Color.White;

            // Border Colors
            public static Color Border = Color.FromArgb(0xD9, 0xD4, 0xCA);
            public static Color BorderHover = Color.FromArgb(0x2A, 0x4B, 0x3D);
            public static Color BorderFocus = Primary;

            // DevaSoft tokens used by richer screens
            public static Color Olive = Color.FromArgb(0x51, 0x64, 0x43);
            public static Color OliveSoft = Color.FromArgb(0xE8, 0xEF, 0xE2);
            public static Color OnOliveSoft = Color.FromArgb(0x24, 0x35, 0x18);
            public static Color Terracotta = Color.FromArgb(0xB3, 0x60, 0x46);
            public static Color TerracottaSoft = Color.FromArgb(0xF7, 0xEA, 0xE5);
            public static Color OnTerracottaSoft = Color.FromArgb(0x5A, 0x1C, 0x07);
            public static Color Sidebar = Color.FromArgb(0x1A, 0x33, 0x29);
            public static Color SidebarActive = Color.FromArgb(0x2A, 0x4B, 0x3D);
            public static Color SidebarMuted = Color.FromArgb(0x9D, 0xB5, 0xAA);
            public static Color SuccessSoft = Color.FromArgb(0xE6, 0xF4, 0xEC);
            public static Color WarningSoft = Color.FromArgb(0xFD, 0xF3, 0xE1);

            // Shadow Colors
            public static Color ShadowLight = Color.FromArgb(0, 0, 0, 10);     // Light Shadow
            public static Color ShadowMedium = Color.FromArgb(0, 0, 0, 20);    // Medium Shadow
            public static Color ShadowDark = Color.FromArgb(0, 0, 0, 30);      // Dark Shadow
        }

        // Modern Spacing System (8px grid)
        public static class Spacing
        {
            public static int XS = 4;   // 4px
            public static int SM = 8;   // 8px
            public static int MD = 16;  // 16px
            public static int LG = 24;  // 24px
            public static int XL = 32;  // 32px
            public static int XXL = 48; // 48px
        }

        // Modern Typography
        public static class Typography
        {
            public static Font H1 = new Font("Segoe UI", 32F, FontStyle.Bold);
            public static Font H2 = new Font("Segoe UI", 24F, FontStyle.Bold);
            public static Font H3 = new Font("Segoe UI", 20F, FontStyle.Bold);
            public static Font H4 = new Font("Segoe UI", 16F, FontStyle.Bold);
            public static Font H5 = new Font("Segoe UI", 14F, FontStyle.Bold);
            public static Font H6 = new Font("Segoe UI", 12F, FontStyle.Bold);
            public static Font Body = new Font("Segoe UI", 10F);
            public static Font BodyLarge = new Font("Segoe UI", 11F);
            public static Font Caption = new Font("Segoe UI", 9F);
            public static Font Button = new Font("Segoe UI", 10F, FontStyle.Bold);
        }

        /// <summary>
        /// Modern card stilini uygular (gölge, rounded corners, hover effects)
        /// </summary>
        public static void ApplyModernCard(PanelControl panel)
        {
            if (panel == null) return;

            panel.Appearance.BackColor = Colors.Surface;
            panel.Appearance.BorderColor = Colors.Border;
            panel.Appearance.Options.UseBackColor = true;
            panel.Appearance.Options.UseBorderColor = true;

            panel.BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.Simple;
            panel.Padding = new Padding(Spacing.MD);

            // Modern hover effect
            var originalColor = Colors.Surface;
            panel.MouseEnter += (s, e) =>
            {
                panel.Appearance.BackColor = Colors.SurfaceHover;
                panel.Appearance.BorderColor = Colors.BorderHover;
            };
            panel.MouseLeave += (s, e) =>
            {
                panel.Appearance.BackColor = originalColor;
                panel.Appearance.BorderColor = Colors.Border;
            };
        }

        /// <summary>
        /// Modern buton stilini uygular
        /// </summary>
        public static void ApplyModernButton(SimpleButton button, Color backgroundColor, bool isPrimary = false)
        {
            if (button == null) return;

            button.Appearance.BackColor = backgroundColor;
            button.Appearance.ForeColor = Colors.TextOnPrimary;
            button.Appearance.Font = Typography.Button;
            button.Appearance.Options.UseBackColor = true;
            button.Appearance.Options.UseForeColor = true;
            button.Appearance.Options.UseFont = true;

            // Hover effect
            var hoverColor = LightenColor(backgroundColor, 10);
            button.AppearanceHovered.BackColor = hoverColor;
            button.AppearanceHovered.ForeColor = Colors.TextOnPrimary;
            button.AppearanceHovered.Options.UseBackColor = true;
            button.AppearanceHovered.Options.UseForeColor = true;

            // Pressed effect
            var pressedColor = DarkenColor(backgroundColor, 10);
            button.AppearancePressed.BackColor = pressedColor;
            button.AppearancePressed.ForeColor = Colors.TextOnPrimary;
            button.AppearancePressed.Options.UseBackColor = true;
            button.AppearancePressed.Options.UseForeColor = true;

            // Size
            if (isPrimary)
            {
                button.Height = 40;
                button.Width = Math.Max(button.Width, 120);
            }
            else
            {
                button.Height = 36;
            }

            button.AllowFocus = true;
        }

        /// <summary>
        /// Modern Grid stilini uygular
        /// </summary>
        public static void ApplyModernGrid(GridView gridView)
        {
            if (gridView == null) return;

            // Header styling
            gridView.Appearance.HeaderPanel.BackColor = Colors.Background;
            gridView.Appearance.HeaderPanel.ForeColor = Colors.TextPrimary;
            gridView.Appearance.HeaderPanel.Font = Typography.H6;
            gridView.Appearance.HeaderPanel.Options.UseBackColor = true;
            gridView.Appearance.HeaderPanel.Options.UseForeColor = true;
            gridView.Appearance.HeaderPanel.Options.UseFont = true;
            gridView.Appearance.HeaderPanel.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Near;
            gridView.Appearance.HeaderPanel.BorderColor = Colors.Border;
            gridView.Appearance.HeaderPanel.Options.UseBorderColor = true;

            // Row styling
            gridView.Appearance.Row.BackColor = Colors.Surface;
            gridView.Appearance.Row.ForeColor = Colors.TextPrimary;
            gridView.Appearance.Row.Font = Typography.Body;
            gridView.Appearance.Row.Options.UseBackColor = true;
            gridView.Appearance.Row.Options.UseForeColor = true;
            gridView.Appearance.Row.Options.UseFont = true;
            gridView.Appearance.Row.TextOptions.VAlignment = DevExpress.Utils.VertAlignment.Center;

            // Selected row
            gridView.Appearance.SelectedRow.BackColor = Colors.Primary;
            gridView.Appearance.SelectedRow.ForeColor = Colors.TextOnPrimary;
            gridView.Appearance.SelectedRow.Options.UseBackColor = true;
            gridView.Appearance.SelectedRow.Options.UseForeColor = true;

            // Focused row
            gridView.Appearance.FocusedRow.BackColor = Colors.PrimaryLight;
            gridView.Appearance.FocusedRow.ForeColor = Colors.TextPrimary;
            gridView.Appearance.FocusedRow.Options.UseBackColor = true;
            gridView.Appearance.FocusedRow.Options.UseForeColor = true;

            // Even row (zebra striping)
            gridView.Appearance.EvenRow.BackColor = Color.FromArgb(250, 250, 250);
            gridView.Appearance.EvenRow.Options.UseBackColor = true;

            // Border
            gridView.OptionsView.ShowVerticalLines = DevExpress.Utils.DefaultBoolean.False;
            gridView.OptionsView.ShowHorizontalLines = DevExpress.Utils.DefaultBoolean.True;
            gridView.OptionsView.ShowGroupPanel = false;
            gridView.OptionsView.ShowIndicator = false;

            // Row height
            gridView.RowHeight = 40;
            gridView.ColumnPanelRowHeight = 45;
        }

        /// <summary>
        /// Modern GroupControl stilini uygular
        /// </summary>
        public static void ApplyModernGroup(GroupControl group)
        {
            if (group == null) return;

            // Header
            group.AppearanceCaption.BackColor = Colors.Primary;
            group.AppearanceCaption.ForeColor = Colors.TextOnPrimary;
            group.AppearanceCaption.Font = Typography.H5;
            group.AppearanceCaption.Options.UseBackColor = true;
            group.AppearanceCaption.Options.UseForeColor = true;
            group.AppearanceCaption.Options.UseFont = true;

            // Content
            group.Appearance.BackColor = Colors.Surface;
            group.Appearance.Options.UseBackColor = true;

            // Border
            group.BorderStyle = DevExpress.XtraEditors.Controls.BorderStyles.Simple;

            // Padding
            group.Padding = new Padding(Spacing.MD);
        }

        /// <summary>
        /// Modern Sidebar stilini uygular
        /// </summary>
        public static void ApplyModernSidebar(DevExpress.XtraBars.Navigation.AccordionControl accordion)
        {
            if (accordion == null) return;

            accordion.BackColor = Colors.Sidebar;
            ApplyOptionalAccordionBackColor(accordion);

            // Group appearance
            accordion.Appearance.Group.Normal.BackColor = Colors.Sidebar;
            accordion.Appearance.Group.Normal.ForeColor = Color.FromArgb(0xF2, 0xF6, 0xF4);
            accordion.Appearance.Group.Normal.Font = Typography.H6;
            accordion.Appearance.Group.Normal.Options.UseBackColor = true;
            accordion.Appearance.Group.Normal.Options.UseForeColor = true;
            accordion.Appearance.Group.Normal.Options.UseFont = true;

            accordion.Appearance.Group.Hovered.BackColor = Colors.SidebarActive;
            accordion.Appearance.Group.Hovered.ForeColor = Colors.TextOnPrimary;
            accordion.Appearance.Group.Hovered.Options.UseBackColor = true;
            accordion.Appearance.Group.Hovered.Options.UseForeColor = true;

            accordion.Appearance.Group.Pressed.BackColor = Colors.SidebarActive;
            accordion.Appearance.Group.Pressed.ForeColor = Colors.TextOnPrimary;
            accordion.Appearance.Group.Pressed.Options.UseBackColor = true;
            accordion.Appearance.Group.Pressed.Options.UseForeColor = true;

            // Item appearance
            accordion.Appearance.Item.Normal.BackColor = Colors.Sidebar;
            accordion.Appearance.Item.Normal.ForeColor = Colors.SidebarMuted;
            accordion.Appearance.Item.Normal.Font = Typography.Body;
            accordion.Appearance.Item.Normal.Options.UseBackColor = true;
            accordion.Appearance.Item.Normal.Options.UseForeColor = true;
            accordion.Appearance.Item.Normal.Options.UseFont = true;

            accordion.Appearance.Item.Hovered.BackColor = Colors.SidebarActive;
            accordion.Appearance.Item.Hovered.ForeColor = Color.White;
            accordion.Appearance.Item.Hovered.Options.UseBackColor = true;
            accordion.Appearance.Item.Hovered.Options.UseForeColor = true;

            accordion.Appearance.Item.Pressed.BackColor = Colors.SidebarActive;
            accordion.Appearance.Item.Pressed.ForeColor = Colors.TextOnPrimary;
            accordion.Appearance.Item.Pressed.Options.UseBackColor = true;
            accordion.Appearance.Item.Pressed.Options.UseForeColor = true;

            ApplyOptionalAppearanceState(accordion.Appearance.Item, "Selected", Colors.SidebarActive, Colors.TextOnPrimary);
        }

        private static void ApplyOptionalAppearanceState(object appearanceOwner, string stateName, Color backColor, Color foreColor)
        {
            try
            {
                var property = appearanceOwner.GetType().GetProperty(stateName);
                if (property == null) return;

                var appearance = property.GetValue(appearanceOwner, null);
                if (appearance == null) return;

                var backColorProperty = appearance.GetType().GetProperty("BackColor");
                if (backColorProperty != null)
                    backColorProperty.SetValue(appearance, backColor, null);

                var foreColorProperty = appearance.GetType().GetProperty("ForeColor");
                if (foreColorProperty != null)
                    foreColorProperty.SetValue(appearance, foreColor, null);

                var optionsProperty = appearance.GetType().GetProperty("Options");
                var options = optionsProperty != null ? optionsProperty.GetValue(appearance, null) : null;
                if (options == null) return;

                var useBackColorProperty = options.GetType().GetProperty("UseBackColor");
                if (useBackColorProperty != null)
                    useBackColorProperty.SetValue(options, true, null);

                var useForeColorProperty = options.GetType().GetProperty("UseForeColor");
                if (useForeColorProperty != null)
                    useForeColorProperty.SetValue(options, true, null);
            }
            catch
            {
                // Optional state availability differs between DevExpress builds.
            }
        }

        private static void ApplyOptionalAccordionBackColor(DevExpress.XtraBars.Navigation.AccordionControl accordion)
        {
            try
            {
                var appearance = accordion.Appearance;
                var property = appearance.GetType().GetProperty("AccordionControl");
                if (property == null) return;

                var accordionAppearance = property.GetValue(appearance, null);
                if (accordionAppearance == null) return;

                var backColorProperty = accordionAppearance.GetType().GetProperty("BackColor");
                if (backColorProperty != null)
                    backColorProperty.SetValue(accordionAppearance, Colors.Sidebar, null);

                var optionsProperty = accordionAppearance.GetType().GetProperty("Options");
                var options = optionsProperty != null ? optionsProperty.GetValue(accordionAppearance, null) : null;
                if (options == null) return;

                var useBackColorProperty = options.GetType().GetProperty("UseBackColor");
                if (useBackColorProperty != null)
                    useBackColorProperty.SetValue(options, true, null);
            }
            catch
            {
                // DevExpress builds differ in AccordionControl appearance surface.
            }
        }

        /// <summary>
        /// Renk açıklığını artırır
        /// </summary>
        private static Color LightenColor(Color color, int percent)
        {
            int r = Math.Min(255, color.R + (255 - color.R) * percent / 100);
            int g = Math.Min(255, color.G + (255 - color.G) * percent / 100);
            int b = Math.Min(255, color.B + (255 - color.B) * percent / 100);
            return Color.FromArgb(r, g, b);
        }

        /// <summary>
        /// Renk koyuluğunu artırır
        /// </summary>
        private static Color DarkenColor(Color color, int percent)
        {
            int r = Math.Max(0, color.R - color.R * percent / 100);
            int g = Math.Max(0, color.G - color.G * percent / 100);
            int b = Math.Max(0, color.B - color.B * percent / 100);
            return Color.FromArgb(r, g, b);
        }
    }
}
