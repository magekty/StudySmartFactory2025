using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace S250521_CheckedListBox
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            checkedListBox1.Items.Add("페인트1");
            checkedListBox1.Items.Add("페인트2");
            checkedListBox1.Items.Add("페인트3");
            checkedListBox1.Items.Add("페인트4");
            checkedListBox1.Items.Add("페인트5");
            checkedListBox1.Items.Add("페인트6");

        }

        private void CheckedListBoxChanged(object sender, EventArgs e)
        {
            /*StringBuilder sb = new StringBuilder();
            string cities = "";
            foreach (var city in checkedListBox1.CheckedItems)
            {
                //sb.Append($"{city.ToString()}\n");
                //label1.Text += $"{city.ToString()}\n";
                cities += city.ToString() + "\n";
            }
            //label1.Text = sb.ToString();
            label1.Text = cities;*/


        }

        private void button_ToRight_Click(object sender, EventArgs e)
        {
            foreach (var city in checkedListBox1.CheckedItems)
            {
                listBox1.Items.Add(city);
            }
        }

        private void button_ToRightAll_Click(object sender, EventArgs e)
        {
            foreach (var city in checkedListBox1.Items)
            {
                listBox1.Items.Add(city);
            }
        }

        private void button_Remove_Click(object sender, EventArgs e)
        {
            List<string> list_Remove = new List<string>();

            foreach (string city in listBox1.SelectedItems)
            {
                list_Remove.Add(city);
            }

            foreach (string city in list_Remove)
            {
                listBox1.Items.Remove(city);
            }
        }

        private void button_Clear_Click(object sender, EventArgs e)
        {
            listBox1.Items.Clear();
        }
    }
}
