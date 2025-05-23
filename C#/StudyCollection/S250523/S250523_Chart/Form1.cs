using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;

namespace S250523_Chart
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
            this.Text = "Using Chart Control";
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            Random r = new Random();
            chart1.Titles.Add("중간고사 성적");
            /*for (int i = 0; i < 10; i++)
            {
                chart1.Series["Series1"].Points.Add(r.Next(100));
            }
            chart1.Series["Series1"].LegendText = "수학";
            chart1.Series["Series1"].ChartType = SeriesChartType.Line;*/

            chart1.Series.Add("Series2");
            chart1.Series["Series1"].LegendText = "수학";
            chart1.Series["Series2"].LegendText = "영어";


            chart1.ChartAreas.Add("ChartArea2");
            chart1.Series["Series2"].ChartArea = "ChartArea2";

            for (int i = 0; i < 10; i++)
            {
                chart1.Series["Series1"].Points.AddXY(i, r.Next(100));
                chart1.Series["Series2"].Points.AddXY(i, r.Next(100));
            }

        }

        private void button1_Click(object sender, EventArgs e)
        {
            chart1.ChartAreas.RemoveAt(chart1.ChartAreas.IndexOf("ChartArea2"));
            chart1.Series["Series2"].ChartArea = "ChartArea1";
        }

        private void button2_Click(object sender, EventArgs e)
        {
            chart1.ChartAreas.Add("ChartArea2");
            chart1.Series["Series2"].ChartArea = "ChartArea2";
        }
    }
}
