using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace S250521_RgbScrollBar
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();

            this.BackColor = Color.LightSteelBlue;
            panel1.BackColor = Color.FromArgb(0, 0, 0);
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void hScrollBar1_Scroll(object sender, ScrollEventArgs e)
        {
            textBox1.Text = hScrollBar1.Value.ToString();
        }
        private void hScrollBar2_Scroll_1(object sender, ScrollEventArgs e)
        {
            textBox2.Text = hScrollBar2.Value.ToString();
        }

        private void hScrollBar3_Scroll_1(object sender, ScrollEventArgs e)
        {
            textBox3.Text = hScrollBar3.Value.ToString();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            int chkInt;
            if (int.TryParse(textBox1.Text, out chkInt) && chkInt >= 0 && chkInt <= 255)
                hScrollBar1.Value = chkInt;
        }
        private void textBox_Simulator_Sec_KeyPress(object sender, KeyPressEventArgs e)
        {
            //숫자와 백스페이스만 입력
            if (!(char.IsDigit(e.KeyChar) || e.KeyChar == Convert.ToChar(Keys.Back)))
            {
                e.Handled = true;
            }
        }
    }
}
