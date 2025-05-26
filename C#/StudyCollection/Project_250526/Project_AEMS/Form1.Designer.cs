using System.Windows.Forms.DataVisualization.Charting;

namespace Project_AEMS
{
    partial class Form1
    {
        /// <summary>
        /// 필수 디자이너 변수입니다.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 사용 중인 모든 리소스를 정리합니다.
        /// </summary>
        /// <param name="disposing">관리되는 리소스를 삭제해야 하면 true이고, 그렇지 않으면 false입니다.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form 디자이너에서 생성한 코드

        /// <summary>
        /// 디자이너 지원에 필요한 메서드입니다. 
        /// 이 메서드의 내용을 코드 편집기로 수정하지 마세요.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.DataVisualization.Charting.ChartArea chartArea5 = new System.Windows.Forms.DataVisualization.Charting.ChartArea();
            this.btnLoadCsv = new System.Windows.Forms.Button();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.chart1 = new System.Windows.Forms.DataVisualization.Charting.Chart();
            this.lblStatus = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.progressBar1 = new System.Windows.Forms.ProgressBar();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.chart1)).BeginInit();
            this.SuspendLayout();
            // 
            // btnLoadCsv
            // 
            this.btnLoadCsv.Location = new System.Drawing.Point(12, 12);
            this.btnLoadCsv.Name = "btnLoadCsv";
            this.btnLoadCsv.Size = new System.Drawing.Size(120, 30);
            this.btnLoadCsv.TabIndex = 0;
            this.btnLoadCsv.Text = "CSV 불러오기";
            this.btnLoadCsv.Click += new System.EventHandler(this.btnLoadCsv_Click);
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Location = new System.Drawing.Point(12, 60);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.Size = new System.Drawing.Size(1443, 134);
            this.dataGridView1.TabIndex = 1;
            // 
            // chart1
            // 
            chartArea5.Name = "ChartArea1";
            this.chart1.ChartAreas.Add(chartArea5);
            this.chart1.Location = new System.Drawing.Point(12, 200);
            this.chart1.Name = "chart1";
            this.chart1.Size = new System.Drawing.Size(1443, 685);
            this.chart1.TabIndex = 2;
            this.chart1.Text = "chart1";
            // 
            // lblStatus
            // 
            this.lblStatus.Font = new System.Drawing.Font("맑은 고딕", 10F);
            this.lblStatus.Location = new System.Drawing.Point(151, -2);
            this.lblStatus.Name = "lblStatus";
            this.lblStatus.Size = new System.Drawing.Size(140, 30);
            this.lblStatus.TabIndex = 3;
            this.lblStatus.Text = "내부CO2: 대기 중";
            // 
            // label1
            // 
            this.label1.Font = new System.Drawing.Font("맑은 고딕", 10F);
            this.label1.Location = new System.Drawing.Point(297, -2);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(132, 30);
            this.label1.TabIndex = 4;
            this.label1.Text = "내부습도: 대기 중";
            // 
            // label2
            // 
            this.label2.Font = new System.Drawing.Font("맑은 고딕", 10F);
            this.label2.Location = new System.Drawing.Point(478, -2);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(123, 30);
            this.label2.TabIndex = 5;
            this.label2.Text = "내부온도: 대기 중";
            // 
            // label4
            // 
            this.label4.Font = new System.Drawing.Font("맑은 고딕", 10F);
            this.label4.Location = new System.Drawing.Point(659, -2);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(156, 30);
            this.label4.TabIndex = 7;
            this.label4.Text = "근권수분함량: 대기 중";
            // 
            // label5
            // 
            this.label5.Font = new System.Drawing.Font("맑은 고딕", 10F);
            this.label5.Location = new System.Drawing.Point(811, -2);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(146, 30);
            this.label5.TabIndex = 8;
            this.label5.Text = "근권토양EC: 대기 중";
            // 
            // label6
            // 
            this.label6.Font = new System.Drawing.Font("맑은 고딕", 10F);
            this.label6.Location = new System.Drawing.Point(963, -2);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(147, 30);
            this.label6.TabIndex = 9;
            this.label6.Text = "근권토양Ph: 대기 중";
            // 
            // progressBar1
            // 
            this.progressBar1.Location = new System.Drawing.Point(138, 31);
            this.progressBar1.Name = "progressBar1";
            this.progressBar1.Size = new System.Drawing.Size(1317, 23);
            this.progressBar1.TabIndex = 10;
            // 
            // Form1
            // 
            this.ClientSize = new System.Drawing.Size(1471, 894);
            this.Controls.Add(this.progressBar1);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.btnLoadCsv);
            this.Controls.Add(this.dataGridView1);
            this.Controls.Add(this.chart1);
            this.Controls.Add(this.lblStatus);
            this.Name = "Form1";
            this.Text = "CSV 모니터링 시스템";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.chart1)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.ProgressBar progressBar1;
    }
}

