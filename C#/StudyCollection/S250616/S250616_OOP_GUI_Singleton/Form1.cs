using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace S250616_OOP_GUI_Singleton
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();

        }

        private void btnOpenSetting_Click(object sender, EventArgs e)
        {
            var settingForm = SettingForm2.getInstance();
            settingForm.BringToFront();
        }

        private void btnNewWindows_Click(object sender, EventArgs e)
        {
            SettingForm2 newForm = new SettingForm2();
            newForm.Show();
        }
    }
}
