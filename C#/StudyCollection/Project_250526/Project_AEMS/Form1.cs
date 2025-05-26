using System;
using System.Collections.Generic;
using System.IO;
using System.Windows.Forms;
using System.Windows.Forms.DataVisualization.Charting;

namespace Project_AEMS
{
    public partial class Form1 : Form
    {
        private Button btnLoadCsv;
        private DataGridView dataGridView1;
        private Chart chart1;
        private Label lblStatus;
        private Timer monitorTimer;
        private List<string[]> csvDataRows;
        private int currentRowIndex = 0;


        public Form1()
        {
            InitializeComponent();
            InitializeMonitorTimer();
        }


        private void InitializeMonitorTimer()
        {
            monitorTimer = new Timer();
            monitorTimer.Interval = 100;
            monitorTimer.Tick += timer1_Tick;
        }

        private void btnLoadCsv_Click(object sender, EventArgs e)
        {
            OpenFileDialog ofd = new OpenFileDialog();
            ofd.Filter = "CSV 파일 (*.csv)|*.csv";
            if (ofd.ShowDialog() == DialogResult.OK)
            {
                LoadCsvRows(ofd.FileName);
                InitializeDataGrid();
                InitializeChart();
                currentRowIndex = 0;
                monitorTimer.Start();
            }
        }

        private void LoadCsvRows(string filePath)
        {
            csvDataRows = new List<string[]>();
            using (var reader = new StreamReader(filePath))
            {
                while (!reader.EndOfStream)
                {
                    var line = reader.ReadLine();
                    var values = line.Split(',');
                    csvDataRows.Add(values);
                }
            }
        }

        private void InitializeDataGrid()
        {
            dataGridView1.Columns.Clear();
            if (csvDataRows.Count > 0)
            {
                foreach (var header in csvDataRows[0])
                {
                    dataGridView1.Columns.Add(header, header);
                }
            }
            dataGridView1.Rows.Clear();
        }

        private void InitializeChart()
        {
            chart1.Series.Clear();
            chart1.Legends.Clear(); 

            chart1.Titles.Add("농업환경데이터");
            Legend legend = new Legend($"Legend1");
            legend.Docking = Docking.Right;
            legend.Font = new System.Drawing.Font("맑은 고딕", 9);
            chart1.Legends.Add(legend);
                
            for (int i = 0; i < 7; i++)
            {
                chart1.Series.Add($"Series{i + 1}");
                chart1.Series[$"Series{i+1}"].ChartType = SeriesChartType.Line;
                chart1.Series[$"Series{i+1}"].Legend = $"Legend1";
            }
           
            chart1.Series["Series1"].LegendText = "내부CO2";
            chart1.Series["Series2"].LegendText = "내부습도";
            chart1.Series["Series3"].LegendText = "내부온도";
            chart1.Series["Series4"].LegendText = "내부일사량";
            chart1.Series["Series5"].LegendText = "근권수분함량";
            chart1.Series["Series6"].LegendText = "근권토양EC";
            chart1.Series["Series7"].LegendText = "근권토양Ph";

            for (int i = 0; i < 7; i++)
            {
                if (i > 0)
                {
                    chart1.ChartAreas.Add($"ChartArea{i+1}");
                    chart1.Series[$"Series{i + 1}"].ChartArea = $"ChartArea{i + 1}";
                }

                chart1.ChartAreas[$"ChartArea{i+1}"].AxisX.LabelStyle.Interval = 24;
            }
            
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            if (csvDataRows == null || csvDataRows.Count <= 1 || currentRowIndex >= csvDataRows.Count - 1)
            {
                lblStatus.Text = "모든 데이터를 로드했습니다.";
                lblStatus.ForeColor = System.Drawing.Color.Blue;
                monitorTimer.Stop();
                return;
            }

            for (int i = 0; i < 7; i++)
            {
                currentRowIndex++;
                var rowData = csvDataRows[currentRowIndex];
                dataGridView1.Rows.Add(rowData);
                if (double.TryParse(rowData[11], out double value))
                {
                    chart1.Series[$"Series{i+1}"].Points.AddY(value);
                    switch (i)
                    {   
                        case 0:
                            if (value < 700 || value > 1500)
                            {
                                lblStatus.Text = $"내부CO2 -  경고";
                                lblStatus.ForeColor = System.Drawing.Color.Red;
                            }
                            else
                            {
                                lblStatus.Text = "내부CO2 - 정상";
                                lblStatus.ForeColor = System.Drawing.Color.Green;
                            }
                                
                            break;
                        case 1:
                            if (value < 50 || value > 100)
                            {
                                label1.Text = $"내부습도 -  경고";
                                label1.ForeColor = System.Drawing.Color.Red;
                            }
                            else
                            {
                                label1.Text = "내부습도 - 정상";
                                label1.ForeColor = System.Drawing.Color.Green;
                            }
                                
                            break;
                        case 2:
                            if (value < 5 || value > 26)
                            {
                                label2.Text = $"내부온도 -  경고";
                                label2.ForeColor = System.Drawing.Color.Red;
                            }
                            else
                            {
                                label2.Text = "내부온도 - 정상";
                                label2.ForeColor = System.Drawing.Color.Green;
                            }
                                
                            break;
                        case 3:
                            break;
                        case 4:
                            if (value < 30 || value > 70)
                            {
                                label4.Text = $"지습 -  경고";
                                label4.ForeColor = System.Drawing.Color.Red;
                            }
                            else
                            {
                                label4.Text = "지습 - 정상";
                                label4.ForeColor = System.Drawing.Color.Green;
                            }
                                
                            break;
                        case 5:
                            if (value > 120)
                            {
                                label5.Text = $"토양EC -  경고";
                                label5.ForeColor = System.Drawing.Color.Red;
                            }
                            else
                            {
                                label5.Text = "토양EC - 정상";
                                label5.ForeColor = System.Drawing.Color.Green;
                            }
                                
                            break;
                        case 6:
                            if (value < 5.5f || value > 7.0f)
                            {
                                label6.Text = $"토양PH -  경고";
                                label6.ForeColor = System.Drawing.Color.Red;
                            }
                            else
                            {
                                label6.Text = "토양PH - 정상";
                                label6.ForeColor = System.Drawing.Color.Green;
                            }
                                
                            break;
                        default:
                            break;
                    }
                    
                }

            }


            
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }
    }
}
