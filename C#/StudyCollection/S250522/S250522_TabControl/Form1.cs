using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace S250522_TabControl
{
    public partial class Form1 : Form
    {
        private Timer myTimer = new Timer();
        private DateTime dDay, tTime;
        private bool isSetAlarm;
        public Form1()
        {
            InitializeComponent();
            label_alarm.ForeColor = Color.Gray;
            label_alarmSet.ForeColor = Color.Gray;
            timePicker.Format = DateTimePickerFormat.Custom;
            timePicker.CustomFormat = "tt hh:mm";
            myTimer.Interval = 1000;
            myTimer.Tick += MyTime_Tick;
            myTimer.Start();
            tabControl1.SelectedTab = tabPage_Watch;
        }

        private void MyTime_Tick(object sender, EventArgs e)
        {
            DateTime currentTime = DateTime.Now;
            label_date.Text = currentTime.ToShortDateString();
            label_time.Text = currentTime.ToLongTimeString();
        }

        private void btnSet_Click(object sender, EventArgs e)
        {
            dDay = DateTime.Parse(datePicker.Text);
            tTime = DateTime.Parse(timePicker.Text);
            isSetAlarm = true;
            label_alarm.ForeColor = Color.Red;
            label_alarmSet.ForeColor = Color.Blue;
            label_alarm.Text = $"Alarm: {dDay.ToShortDateString()} {tTime.ToLongTimeString()}";
            tabControl1.SelectedTab = tabPage_Watch;
        }

        private void btnReset_Click(object sender, EventArgs e)
        {
            isSetAlarm = false;
            label_alarm.ForeColor = Color.Gray;
            label_alarmSet.ForeColor = Color.Gray;
            label_alarm.Text = $"Alarm:";
            tabControl1 .SelectedTab = tabPage_Watch;
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }
    }
}
