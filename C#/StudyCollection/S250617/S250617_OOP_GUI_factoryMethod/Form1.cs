using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace S250617_OOP_GUI_factoryMethod
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void btnLightTheme_Click(object sender, EventArgs e)
        {
            ThemeFactory factory = new LightThemeFactory();
            BaseThemeForm form = factory.CreateThemeForm();
            form.Show();
        }

        private void btnDarkTheme_Click(object sender, EventArgs e)
        {
            ThemeFactory factory = new DarkThemeFactory();
            BaseThemeForm form = factory.CreateThemeForm();
            form.Show();
        }
    }

    abstract class BaseThemeForm : Form
    {
        protected BaseThemeForm()
        {
            this.Width = 300;
            this.Height = 200;
            this.StartPosition = FormStartPosition.CenterScreen;
            this.FormBorderStyle = FormBorderStyle.FixedDialog;
        }
    }
    class LightThemeForm : BaseThemeForm
    {
        public LightThemeForm()
        {
            this.Text = "Light Theme";
            this.BackColor = Color.White;
            Label lbl = new Label
            {
                Text = "Light Theme",
                ForeColor = Color.White,
                AutoSize = true,
                Location = new Point(50, 80)
            };
            Controls.Add(lbl);
        }
    }
    class DarkThemeForm : BaseThemeForm
    {
        public DarkThemeForm()
        {
            this.Text = "Dark Theme";
            this.BackColor = Color.Black;
            Label lbl = new Label
            {
                Text = "Dark Theme",
                ForeColor = Color.Black,
                AutoSize = true,
                Location = new Point(50, 80)
            };
            Controls.Add(lbl);
        }
    }
    abstract class ThemeFactory
    {
        public abstract BaseThemeForm CreateThemeForm();
    }
    class LightThemeFactory : ThemeFactory
    {
        public LightThemeFactory()
        {
        }

        public override BaseThemeForm CreateThemeForm()
        {
            return new LightThemeForm();
        }
    }
    class DarkThemeFactory : ThemeFactory
    {
        public DarkThemeFactory()
        {
        }

        public override BaseThemeForm CreateThemeForm()
        {
            return new DarkThemeForm();
        }
    }
}
