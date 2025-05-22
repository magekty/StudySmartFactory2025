using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace S250522_Menu
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void 끝내기ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void 폰트ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FontDialog fDlg = new FontDialog();
            fDlg.ShowColor = true;
            fDlg.ShowEffects = true;
            fDlg.Font = label1.Font;
            fDlg.Color = label1.ForeColor;
            if(fDlg.ShowDialog() == DialogResult.OK)
            {
                label1.Font = fDlg.Font;
                label1.ForeColor = fDlg.Color;
            }
        }

        private void 배경색ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ColorDialog cDlg = new ColorDialog();
            if(cDlg.ShowDialog() == DialogResult.OK)
            {
                this.BackColor = cDlg.Color;
            }
        }
    }
}
