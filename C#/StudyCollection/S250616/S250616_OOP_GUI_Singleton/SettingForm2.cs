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
    public partial class SettingForm2 : Form
    {
        private static SettingForm2 instance;
        public SettingForm2()
        {
            InitializeComponent();
        }
        public static SettingForm2 getInstance()
        {
            if (instance == null || instance.IsDisposed)
            {
                var instance = new SettingForm2();  
            }
        }
    }
}
