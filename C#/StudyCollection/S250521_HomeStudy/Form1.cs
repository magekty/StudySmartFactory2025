using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Net.NetworkInformation;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;


namespace S250521_TransactionStatement
{
    public partial class Form1 : Form
    {
        private int rowIndex = 0; // 현재 행 인덱스
        private string prevStrAr, prevN4, prevN5;
        public Form1()
        {
            InitializeComponent();
            InitializeTableLayout();
            AddNewRow(); // 시작 시 첫 행 추가
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            /*// 공급가액
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
            textBox_TotalSum.Text = (int.Parse(textBox_Result1.Text) + int.Parse(textBox_Result2.Text) + int.Parse(textBox_Result3.Text)).ToString();*/

        }

        /*private void textBox_15_TextChanged(object sender, EventArgs e)
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
        }*/

        private void InitializeTableLayout()
        {
            tableLayoutPanel1.ColumnCount = 9; 
            tableLayoutPanel1.RowCount = 0;
            tableLayoutPanel1.AutoScroll = true;
            tableLayoutPanel1.RowStyles.Clear();
            tableLayoutPanel1.ColumnStyles.Clear();

            for (int i = 0; i < tableLayoutPanel1.ColumnCount; i++)
            {
                tableLayoutPanel1.ColumnStyles.Add(new ColumnStyle(SizeType.Percent, 100/ tableLayoutPanel1.ColumnCount)); // 100 / 8
            }
        }

        private void AddNewRow()
        {
            if (tableLayoutPanel1.RowCount > 10) return;
            tableLayoutPanel1.RowCount += 1;
            tableLayoutPanel1.RowStyles.Add(new RowStyle(SizeType.Absolute, 30)); 

            string[] defaultValues = { "05", $"{rowIndex + 1:00}", $"AAAAA-{rowIndex + 1:000}", "A4", "5", $"{10000:N0}", "", "", "" };

            for (int i = 0; i < tableLayoutPanel1.ColumnCount; i++)
            {
                MaskedTextBox textBox = new MaskedTextBox();
                textBox.Name = $"textBox{rowIndex}{i}";
                textBox.Dock = DockStyle.Fill;
                textBox.TextAlign = HorizontalAlignment.Right;
                if (i == 0) textBox.Mask = "00월";
                if (i == 1) textBox.Mask = "00일";
                textBox.Text = defaultValues[i];
                if(i == 6 || i == 7) textBox.ReadOnly = true;

                textBox.TextChanged += TextBox_TextChanged;
                textBox.Tag = new Point(i, rowIndex);
                tableLayoutPanel1.Controls.Add(textBox, i, rowIndex);
            }
            AutoResultCalc();
            rowIndex++;
        }

        private void BtnAddRow_Click(object sender, EventArgs e)
        {
            AddNewRow();
        }
        private void BtnDelRow_Click(object sender, EventArgs e)
        {
            if (tableLayoutPanel1.RowCount < 1) return;
            //Console.WriteLine(tableLayoutPanel1.RowCount);
            
            /*for (int i = 0; i < tableLayoutPanel1.ColumnCount; i++)
            {
                MaskedTextBox textBoxToRemove = tableLayoutPanel1.Controls.OfType<MaskedTextBox>().FirstOrDefault(t => t.Name == $"textBox{tableLayoutPanel1.RowCount}{i}");
                tableLayoutPanel1.Controls.Remove(textBoxToRemove);
                textBoxToRemove = null; // 객체 해제
            }*/
            // 지정 행의 컨트롤 수집 후 제거
            for (int i = tableLayoutPanel1.Controls.Count - 1; i >= 0; i--)
            {
                Control c = tableLayoutPanel1.Controls[i];
                if (tableLayoutPanel1.GetRow(c) == tableLayoutPanel1.RowCount-1)
                {
                    tableLayoutPanel1.Controls.Remove(c);
                    c.Dispose(); // 메모리 해제
                }
            }
            rowIndex--;
            tableLayoutPanel1.RowCount--;
            //Console.WriteLine(tableLayoutPanel1.RowCount);
            //Console.WriteLine(rowIndex);
            AutoResultCalc();
        }

        private void Btn_delIdxRow_Click(object sender, EventArgs e)
        {
            if (tableLayoutPanel1.RowCount < 1 ) return;
            int delIdx = int.Parse(textBox_delIdxRow.Text)-1;
            if (tableLayoutPanel1.RowCount <= delIdx) return;
            
            // 지정 행의 컨트롤 수집 후 제거
            for (int i = tableLayoutPanel1.Controls.Count - 1; i >= 0; i--)
            {
                Control c = tableLayoutPanel1.Controls[i];
                if (tableLayoutPanel1.GetRow(c) == delIdx)
                {
                    tableLayoutPanel1.Controls.Remove(c);
                    c.Dispose(); // 메모리 해제
                }
            }
            foreach (Control c in tableLayoutPanel1.Controls)
            {
                int row = tableLayoutPanel1.GetRow(c);
                if (row > delIdx)
                {
                    tableLayoutPanel1.SetRow(c, row - 1);
                }
            }

            // 마지막 Row 제거
            if (tableLayoutPanel1.RowCount > 0)
            {
                tableLayoutPanel1.RowStyles.RemoveAt(tableLayoutPanel1.RowCount - 1);
            }
            rowIndex--;
            tableLayoutPanel1.RowCount--;
            //Console.WriteLine(tableLayoutPanel1.RowCount);
            //Console.WriteLine(rowIndex);
            AutoResultCalc();
        }

        private void TextBox_TextChanged(object sender, EventArgs e)
        {
            MaskedTextBox changedTextBox = sender as MaskedTextBox;
            Point? cellPos = changedTextBox.Tag as Point?;

            if (cellPos.HasValue)
            {
                int col = cellPos.Value.X;
                int row = cellPos.Value.Y;
                MaskedTextBox textBox = (MaskedTextBox) tableLayoutPanel1.GetControlFromPosition(col, row);
                if (textBox == null) return;
                int currentPosition = textBox.SelectionStart; // 현재 커서 위치 저장
                int currentLength = textBox.SelectionLength; // 선택된 텍스트 길이 저장
                                                             // 숫자만 필터링
                string tmpStr = textBox.Text.Replace(",", "");
                string filtered = new string(tmpStr.Where(c => char.IsDigit(c)).ToArray());

                if (textBox.Text.Replace(",", "") != filtered)
                {
                    if (col == 4) textBox.Text = prevN4;
                    if (col == 5) textBox.Text = prevN5;

                    textBox.SelectionStart = currentPosition - 1;
                    textBox.SelectionLength = currentLength;
                    return;
                }
                AutoResultCalc();
                textBox.SelectionStart = currentPosition;
                textBox.SelectionLength = currentLength;
            }
        }

        private void textBox_AccountsReceivable_TextChanged(object sender, EventArgs e)
        {
            TextBox textBox = sender as TextBox;
            if (textBox == null) return;
            int currentPosition = textBox.SelectionStart; // 현재 커서 위치 저장
            int currentLength = textBox.SelectionLength; // 선택된 텍스트 길이 저장
            // 숫자만 필터링
            string tmpStr = textBox.Text.Replace(",", "");
            string filtered = new string(tmpStr.Where(c => char.IsDigit(c)).ToArray());
            if (textBox.Text.Replace(",", "") != filtered)
            {
                textBox.Text = prevStrAr;
                textBox.SelectionStart = currentPosition - 1;
                textBox.SelectionLength = currentLength;
                return;
            }
            AutoResultCalc();
            //Console.WriteLine(textBox_AccountsReceivable.Text);
            textBox.SelectionStart = currentPosition;
            textBox.SelectionLength = currentLength;
        }

        private void textBox_delIdxRow_TextChanged(object sender, EventArgs e)
        {
            string filtered = new string(textBox_delIdxRow.Text.Where(c => char.IsDigit(c)).ToArray());
            textBox_delIdxRow.Text = filtered;
        }

        private void AutoResultCalc()
        {
            int quantity = 0;
            int price = 0;
            int supplyPrice = 0;
            float taxAmount = 0;
            int totSupplyPrice = 0;
            float totTaxAmount = 0;
            float accountsReceivable = 0;

            for (int i = 0;i < tableLayoutPanel1.RowCount; i++)
            {
                for (int j = 4; j < 8; j++)
                {
                    if (j == 4) 
                    {
                        quantity = int.Parse(tableLayoutPanel1.GetControlFromPosition(4, i).Text.Replace(",", ""));
                        prevN4 = quantity.ToString();
                    }
                    if (j == 5) 
                    { 
                        price = int.Parse(tableLayoutPanel1.GetControlFromPosition(5, i).Text.Replace(",", ""));
                        tableLayoutPanel1.GetControlFromPosition(5, i).Text = price.ToString("#,##0");
                        prevN5 = price.ToString("#,##0");
                    }
                    if (j == 6) 
                    {
                        supplyPrice = quantity * price;
                        totSupplyPrice += supplyPrice;
                        tableLayoutPanel1.GetControlFromPosition(6, i).Text = supplyPrice.ToString("#,##0"); 
                    }
                    if (j == 7) 
                    {
                        taxAmount = supplyPrice * 0.1f;
                        totTaxAmount += taxAmount; 
                        tableLayoutPanel1.GetControlFromPosition(7, i).Text = taxAmount.ToString("#,##0");
                    }
                }
            }
            textBox_TotSupplyPrice.Text = totSupplyPrice.ToString("#,##0");
            textBox_TotTaxAmount.Text = totTaxAmount.ToString("#,##0");
            accountsReceivable = int.Parse(textBox_AccountsReceivable.Text.Replace(",", ""));
            textBox_TotalAmount.Text = (accountsReceivable + totSupplyPrice + totTaxAmount).ToString("#,##0");
            textBox_AccountsReceivable.Text = accountsReceivable.ToString("#,##0");
            prevStrAr = textBox_AccountsReceivable.Text;
            //Console.WriteLine(textBox_AccountsReceivable.Text);
        }
    }
}
