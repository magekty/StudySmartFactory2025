using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace S250521_ListBox
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            listBox_GDP.Items.Add("북한");

            listBox_GoodCity.Items.Add("부산");
            listBox_GoodCity.Items.Add("서울");
            listBox_GoodCity.Items.Add("인천");
            listBox_GoodCity.Items.Add("대전");
            listBox_GoodCity.Items.Add("광주");
            listBox_GoodCity.Items.Add("창원");
            listBox_GoodCity.Items.Add("울산");
            listBox_GoodCity.Items.Add("김해");

            List<String> list_HappyCountry = new List<String> 
            { "미국", "러시아", "중국", "영국", "독일", "프랑스", "일본", 
                "이스라엘", "사우디아라비아", "UAE" };
            listBox_HappyCountry.DataSource = list_HappyCountry;
        }


        private void listBox_GDP_SelectedIndexChanged(object sender, EventArgs e)
        {
            ListBox listGDP = sender as ListBox;
            //ListBox listGDP = new ListBox();
            textBox_IndexGDP.Text = listGDP.SelectedIndex.ToString();
            textBox_ItemGDP.Text = listGDP.SelectedItem.ToString();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            listBox_GDP.Items.Add(textBox_AddCountry.Text);
        }

        private void button2_Click(object sender, EventArgs e)
        {
            listBox_GDP.Items.Remove(textBox_RemoveCountry.Text);
        }

        private void button3_Click(object sender, EventArgs e)
        {
            int selectedIndex = Convert.ToInt32(textBox_RemoveAtCountry.Text);
            listBox_GDP.Items.RemoveAt(selectedIndex);  
        }

        private void button4_Click(object sender, EventArgs e)
        {
            listBox_GDP.Items.Clear();
        }
    }
}
