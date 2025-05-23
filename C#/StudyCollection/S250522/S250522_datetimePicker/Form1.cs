using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace S250522_datetimePicker
{
    public partial class Form1 : Form
    {
        DateTime reservationStart, reservationEnd;
        public Form1()
        {
            InitializeComponent();
        }

        private void dateTimePicker1_ValueChanged(object sender, EventArgs e)
        {// 예약 시작일
            reservationStart = dateTimePicker1.Value;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            TimeSpan duration = reservationEnd.Subtract(reservationStart);
            label_Result.Text = String.Format($"작업이 {reservationStart.ToString()}부터 " +
                $"{reservationEnd.ToString()}까지 {duration.ToString()} 일 동안 예약 되었습니다.");
        }

        private void dateTimePicker2_ValueChanged(object sender, EventArgs e)
        {// 예약 종료일
            reservationEnd = dateTimePicker2.Value;
        }
    }
}
