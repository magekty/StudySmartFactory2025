using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace S250521_MaskedTextBox
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string str;

            str = $"입사일: " + maskedTextBox1.Text + "\n";
            str += $"우편번호: " + maskedTextBox2.Text + "\n";
            str += $"주소: " + textBox1.Text + "\n";
            str += $"휴대폰번호: " + maskedTextBox4.Text + "\n";
            str += $"주민등록번호: " + maskedTextBox5.Text + "\n";
            str += $"이메일: " + textBox2.Text + "\n";

            MessageBox.Show(str, "개인정보");

        }
    }
}
