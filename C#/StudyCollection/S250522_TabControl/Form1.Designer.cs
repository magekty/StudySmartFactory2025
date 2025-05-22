namespace S250522_TabControl
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
            this.tabControl1 = new System.Windows.Forms.TabControl();
            this.tabPage_AlarmSet = new System.Windows.Forms.TabPage();
            this.tabPage_Watch = new System.Windows.Forms.TabPage();
            this.datePicker = new System.Windows.Forms.DateTimePicker();
            this.timePicker = new System.Windows.Forms.DateTimePicker();
            this.label_dateSet = new System.Windows.Forms.Label();
            this.label_timeSet = new System.Windows.Forms.Label();
            this.btnSet = new System.Windows.Forms.Button();
            this.btnReset = new System.Windows.Forms.Button();
            this.label_alarmSet = new System.Windows.Forms.Label();
            this.label_alarm = new System.Windows.Forms.Label();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.label_date = new System.Windows.Forms.Label();
            this.label_time = new System.Windows.Forms.Label();
            this.tabControl1.SuspendLayout();
            this.tabPage_AlarmSet.SuspendLayout();
            this.tabPage_Watch.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // tabControl1
            // 
            this.tabControl1.Controls.Add(this.tabPage_AlarmSet);
            this.tabControl1.Controls.Add(this.tabPage_Watch);
            this.tabControl1.Location = new System.Drawing.Point(42, 34);
            this.tabControl1.Name = "tabControl1";
            this.tabControl1.SelectedIndex = 0;
            this.tabControl1.Size = new System.Drawing.Size(384, 376);
            this.tabControl1.TabIndex = 0;
            // 
            // tabPage_AlarmSet
            // 
            this.tabPage_AlarmSet.Controls.Add(this.btnReset);
            this.tabPage_AlarmSet.Controls.Add(this.btnSet);
            this.tabPage_AlarmSet.Controls.Add(this.label_timeSet);
            this.tabPage_AlarmSet.Controls.Add(this.label_dateSet);
            this.tabPage_AlarmSet.Controls.Add(this.timePicker);
            this.tabPage_AlarmSet.Controls.Add(this.datePicker);
            this.tabPage_AlarmSet.Location = new System.Drawing.Point(4, 22);
            this.tabPage_AlarmSet.Name = "tabPage_AlarmSet";
            this.tabPage_AlarmSet.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage_AlarmSet.Size = new System.Drawing.Size(376, 350);
            this.tabPage_AlarmSet.TabIndex = 0;
            this.tabPage_AlarmSet.Text = "알람 설정";
            this.tabPage_AlarmSet.UseVisualStyleBackColor = true;
            // 
            // tabPage_Watch
            // 
            this.tabPage_Watch.Controls.Add(this.groupBox1);
            this.tabPage_Watch.Controls.Add(this.label_alarm);
            this.tabPage_Watch.Controls.Add(this.label_alarmSet);
            this.tabPage_Watch.Location = new System.Drawing.Point(4, 22);
            this.tabPage_Watch.Name = "tabPage_Watch";
            this.tabPage_Watch.Padding = new System.Windows.Forms.Padding(3);
            this.tabPage_Watch.Size = new System.Drawing.Size(376, 350);
            this.tabPage_Watch.TabIndex = 1;
            this.tabPage_Watch.Text = "디지털 시계";
            this.tabPage_Watch.UseVisualStyleBackColor = true;
            // 
            // datePicker
            // 
            this.datePicker.Location = new System.Drawing.Point(51, 87);
            this.datePicker.Name = "datePicker";
            this.datePicker.Size = new System.Drawing.Size(200, 21);
            this.datePicker.TabIndex = 0;
            // 
            // timePicker
            // 
            this.timePicker.Format = System.Windows.Forms.DateTimePickerFormat.Time;
            this.timePicker.Location = new System.Drawing.Point(51, 155);
            this.timePicker.Name = "timePicker";
            this.timePicker.Size = new System.Drawing.Size(200, 21);
            this.timePicker.TabIndex = 1;
            // 
            // label_dateSet
            // 
            this.label_dateSet.AutoSize = true;
            this.label_dateSet.Location = new System.Drawing.Point(49, 59);
            this.label_dateSet.Name = "label_dateSet";
            this.label_dateSet.Size = new System.Drawing.Size(57, 12);
            this.label_dateSet.TabIndex = 2;
            this.label_dateSet.Text = "날짜 설정";
            // 
            // label_timeSet
            // 
            this.label_timeSet.AutoSize = true;
            this.label_timeSet.Location = new System.Drawing.Point(49, 126);
            this.label_timeSet.Name = "label_timeSet";
            this.label_timeSet.Size = new System.Drawing.Size(57, 12);
            this.label_timeSet.TabIndex = 3;
            this.label_timeSet.Text = "시간 설정";
            // 
            // btnSet
            // 
            this.btnSet.Location = new System.Drawing.Point(176, 251);
            this.btnSet.Name = "btnSet";
            this.btnSet.Size = new System.Drawing.Size(75, 23);
            this.btnSet.TabIndex = 4;
            this.btnSet.Text = "설정";
            this.btnSet.UseVisualStyleBackColor = true;
            this.btnSet.Click += new System.EventHandler(this.btnSet_Click);
            // 
            // btnReset
            // 
            this.btnReset.Location = new System.Drawing.Point(257, 251);
            this.btnReset.Name = "btnReset";
            this.btnReset.Size = new System.Drawing.Size(75, 23);
            this.btnReset.TabIndex = 5;
            this.btnReset.Text = "해제";
            this.btnReset.UseVisualStyleBackColor = true;
            this.btnReset.Click += new System.EventHandler(this.btnReset_Click);
            // 
            // label_alarmSet
            // 
            this.label_alarmSet.AutoSize = true;
            this.label_alarmSet.Location = new System.Drawing.Point(27, 44);
            this.label_alarmSet.Name = "label_alarmSet";
            this.label_alarmSet.Size = new System.Drawing.Size(57, 12);
            this.label_alarmSet.TabIndex = 0;
            this.label_alarmSet.Text = "알람 설정";
            // 
            // label_alarm
            // 
            this.label_alarm.AutoSize = true;
            this.label_alarm.Location = new System.Drawing.Point(27, 87);
            this.label_alarm.Name = "label_alarm";
            this.label_alarm.Size = new System.Drawing.Size(46, 12);
            this.label_alarm.TabIndex = 1;
            this.label_alarm.Text = "Alarm :";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.label_time);
            this.groupBox1.Controls.Add(this.label_date);
            this.groupBox1.Location = new System.Drawing.Point(29, 157);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(311, 157);
            this.groupBox1.TabIndex = 2;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "현재시간";
            // 
            // label_date
            // 
            this.label_date.AutoSize = true;
            this.label_date.Location = new System.Drawing.Point(24, 44);
            this.label_date.Name = "label_date";
            this.label_date.Size = new System.Drawing.Size(30, 12);
            this.label_date.TabIndex = 0;
            this.label_date.Text = "Date";
            // 
            // label_time
            // 
            this.label_time.AutoSize = true;
            this.label_time.Font = new System.Drawing.Font("굴림", 30F, System.Drawing.FontStyle.Bold);
            this.label_time.Location = new System.Drawing.Point(27, 67);
            this.label_time.Name = "label_time";
            this.label_time.Size = new System.Drawing.Size(111, 40);
            this.label_time.TabIndex = 1;
            this.label_time.Text = "Time";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(483, 450);
            this.Controls.Add(this.tabControl1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.tabControl1.ResumeLayout(false);
            this.tabPage_AlarmSet.ResumeLayout(false);
            this.tabPage_AlarmSet.PerformLayout();
            this.tabPage_Watch.ResumeLayout(false);
            this.tabPage_Watch.PerformLayout();
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TabControl tabControl1;
        private System.Windows.Forms.TabPage tabPage_AlarmSet;
        private System.Windows.Forms.TabPage tabPage_Watch;
        private System.Windows.Forms.Button btnReset;
        private System.Windows.Forms.Button btnSet;
        private System.Windows.Forms.Label label_timeSet;
        private System.Windows.Forms.Label label_dateSet;
        private System.Windows.Forms.DateTimePicker timePicker;
        private System.Windows.Forms.DateTimePicker datePicker;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Label label_date;
        private System.Windows.Forms.Label label_alarm;
        private System.Windows.Forms.Label label_alarmSet;
        private System.Windows.Forms.Label label_time;
    }
}

