using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace S250521_ComboBox
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void comboBox_Tools_SelectedIndexChanged(object sender, EventArgs e)
        {
            ComboBox cb = sender as ComboBox;
            string selectedTool = cb.SelectedItem.ToString();
            label_SelectedTool.Text = $"선택된 공구: {selectedTool}";
        }

        private void button_Add_Click_Click(object sender, EventArgs e)
        {
            string toolToAdd = comboBox_Tools.Text;
            if (toolToAdd != "")
                comboBox_Tools.Items.Add(toolToAdd);
        }

        private void button_Remove_Click_Click(object sender, EventArgs e)
        {
            comboBox_Tools.Items.Remove(comboBox_Tools.SelectedItem);
        }
    }
}
