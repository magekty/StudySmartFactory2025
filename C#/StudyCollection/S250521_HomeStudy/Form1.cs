using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace S250521_TransactionStatement
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            // 공급가액
            textBox_17.Text = (int.Parse(textBox_15.Text) * int.Parse(textBox_16.Text)).ToString();
            textBox_27.Text = (int.Parse(textBox_25.Text) * int.Parse(textBox_26.Text)).ToString();
            textBox_37.Text = (int.Parse(textBox_35.Text) * int.Parse(textBox_36.Text)).ToString();

            // 세액
            textBox_18.Text = (int.Parse(textBox_17.Text) * 0.1).ToString();
            textBox_28.Text = (int.Parse(textBox_27.Text) * 0.1).ToString();
            textBox_38.Text = (int.Parse(textBox_37.Text) * 0.1).ToString();

            // 공급 가액 합계
            textBox_Result1.Text = (int.Parse(textBox_17.Text) + int.Parse(textBox_27.Text) + int.Parse(textBox_37.Text)).ToString();
            // 세액 합계
            textBox_Result2.Text = (int.Parse(textBox_18.Text) + int.Parse(textBox_28.Text) + int.Parse(textBox_38.Text)).ToString();
            // 합계 금액
            textBox_TotalSum.Text = (int.Parse(textBox_Result1.Text) + int.Parse(textBox_Result2.Text) + int.Parse(textBox_Result3.Text)).ToString();
        }

        private void textBox_15_TextChanged(object sender, EventArgs e)
        {
            // 공급가액
            textBox_17.Text = (int.Parse(textBox_15.Text) * int.Parse(textBox_16.Text)).ToString();
            textBox_27.Text = (int.Parse(textBox_25.Text) * int.Parse(textBox_26.Text)).ToString();
            textBox_37.Text = (int.Parse(textBox_35.Text) * int.Parse(textBox_36.Text)).ToString();

            // 세액
            textBox_18.Text = (int.Parse(textBox_17.Text) * 0.1).ToString();
            textBox_28.Text = (int.Parse(textBox_27.Text) * 0.1).ToString();
            textBox_38.Text = (int.Parse(textBox_37.Text) * 0.1).ToString();

            // 공급 가액 합계
            textBox_Result1.Text = (int.Parse(textBox_17.Text) + int.Parse(textBox_27.Text) + int.Parse(textBox_37.Text)).ToString();
            // 세액 합계
            textBox_Result2.Text = (int.Parse(textBox_18.Text) + int.Parse(textBox_28.Text) + int.Parse(textBox_38.Text)).ToString();
            // 합계 금액
            textBox_TotalSum.Text = (int.Parse(textBox_Result1.Text) + int.Parse(textBox_Result2.Text) + int.Parse(textBox_Result3.Text)).ToString();
        }
    }
}
