namespace S250521_TransactionStatement
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
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.label6 = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.label8 = new System.Windows.Forms.Label();
            this.label9 = new System.Windows.Forms.Label();
            this.label10 = new System.Windows.Forms.Label();
            this.textBox_TotSupplyPrice = new System.Windows.Forms.TextBox();
            this.textBox_TotTaxAmount = new System.Windows.Forms.TextBox();
            this.label11 = new System.Windows.Forms.Label();
            this.textBox_AccountsReceivable = new System.Windows.Forms.TextBox();
            this.label12 = new System.Windows.Forms.Label();
            this.textBox_TotalAmount = new System.Windows.Forms.TextBox();
            this.label13 = new System.Windows.Forms.Label();
            this.textBox14 = new System.Windows.Forms.TextBox();
            this.label14 = new System.Windows.Forms.Label();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.BtnAddRow_Click = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(23, 22);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(17, 12);
            this.label1.TabIndex = 0;
            this.label1.Text = "월";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(120, 22);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(17, 12);
            this.label2.TabIndex = 1;
            this.label2.Text = "일";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(200, 22);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(29, 12);
            this.label3.TabIndex = 2;
            this.label3.Text = "품목";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(296, 22);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(29, 12);
            this.label4.TabIndex = 3;
            this.label4.Text = "규격";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(386, 22);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(29, 12);
            this.label5.TabIndex = 4;
            this.label5.Text = "수량";
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(461, 22);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(29, 12);
            this.label6.TabIndex = 5;
            this.label6.Text = "단가";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(543, 22);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(53, 12);
            this.label7.TabIndex = 6;
            this.label7.Text = "공급가액";
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(661, 22);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(29, 12);
            this.label8.TabIndex = 7;
            this.label8.Text = "세액";
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(730, 22);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(29, 12);
            this.label9.TabIndex = 8;
            this.label9.Text = "비고";
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(4, 411);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(53, 12);
            this.label10.TabIndex = 18;
            this.label10.Text = "공급가액";
            // 
            // textBox_TotSupplyPrice
            // 
            this.textBox_TotSupplyPrice.Location = new System.Drawing.Point(63, 411);
            this.textBox_TotSupplyPrice.Name = "textBox_TotSupplyPrice";
            this.textBox_TotSupplyPrice.ReadOnly = true;
            this.textBox_TotSupplyPrice.Size = new System.Drawing.Size(111, 21);
            this.textBox_TotSupplyPrice.TabIndex = 19;
            this.textBox_TotSupplyPrice.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // textBox_TotTaxAmount
            // 
            this.textBox_TotTaxAmount.Location = new System.Drawing.Point(240, 411);
            this.textBox_TotTaxAmount.Name = "textBox_TotTaxAmount";
            this.textBox_TotTaxAmount.ReadOnly = true;
            this.textBox_TotTaxAmount.Size = new System.Drawing.Size(111, 21);
            this.textBox_TotTaxAmount.TabIndex = 21;
            this.textBox_TotTaxAmount.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Location = new System.Drawing.Point(200, 414);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(29, 12);
            this.label11.TabIndex = 20;
            this.label11.Text = "세액";
            // 
            // textBox_AccountsReceivable
            // 
            this.textBox_AccountsReceivable.Location = new System.Drawing.Point(414, 411);
            this.textBox_AccountsReceivable.Name = "textBox_AccountsReceivable";
            this.textBox_AccountsReceivable.Size = new System.Drawing.Size(111, 21);
            this.textBox_AccountsReceivable.TabIndex = 23;
            this.textBox_AccountsReceivable.Text = "100000";
            this.textBox_AccountsReceivable.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            this.textBox_AccountsReceivable.TextChanged += new System.EventHandler(this.textBox_AccountsReceivable_TextChanged);
            // 
            // label12
            // 
            this.label12.AutoSize = true;
            this.label12.Location = new System.Drawing.Point(374, 414);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(41, 12);
            this.label12.TabIndex = 22;
            this.label12.Text = "미수금";
            // 
            // textBox_TotalAmount
            // 
            this.textBox_TotalAmount.Location = new System.Drawing.Point(584, 411);
            this.textBox_TotalAmount.Name = "textBox_TotalAmount";
            this.textBox_TotalAmount.ReadOnly = true;
            this.textBox_TotalAmount.Size = new System.Drawing.Size(106, 21);
            this.textBox_TotalAmount.TabIndex = 25;
            this.textBox_TotalAmount.TextAlign = System.Windows.Forms.HorizontalAlignment.Right;
            // 
            // label13
            // 
            this.label13.AutoSize = true;
            this.label13.Location = new System.Drawing.Point(531, 414);
            this.label13.Name = "label13";
            this.label13.Size = new System.Drawing.Size(53, 12);
            this.label13.TabIndex = 24;
            this.label13.Text = "합계금액";
            // 
            // textBox14
            // 
            this.textBox14.Location = new System.Drawing.Point(732, 411);
            this.textBox14.Name = "textBox14";
            this.textBox14.Size = new System.Drawing.Size(59, 21);
            this.textBox14.TabIndex = 27;
            // 
            // label14
            // 
            this.label14.AutoSize = true;
            this.label14.Location = new System.Drawing.Point(692, 414);
            this.label14.Name = "label14";
            this.label14.Size = new System.Drawing.Size(41, 12);
            this.label14.TabIndex = 26;
            this.label14.Text = "인수자";
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.ColumnCount = 2;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel1.Location = new System.Drawing.Point(12, 37);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 2;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 50F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(779, 368);
            this.tableLayoutPanel1.TabIndex = 28;
            // 
            // BtnAddRow_Click
            // 
            this.BtnAddRow_Click.Location = new System.Drawing.Point(3, -4);
            this.BtnAddRow_Click.Name = "BtnAddRow_Click";
            this.BtnAddRow_Click.Size = new System.Drawing.Size(75, 23);
            this.BtnAddRow_Click.TabIndex = 0;
            this.BtnAddRow_Click.Text = "추가";
            this.BtnAddRow_Click.UseVisualStyleBackColor = true;
            this.BtnAddRow_Click.Click += new System.EventHandler(this.BtnAddRow_Click_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.BtnAddRow_Click);
            this.Controls.Add(this.tableLayoutPanel1);
            this.Controls.Add(this.textBox14);
            this.Controls.Add(this.label14);
            this.Controls.Add(this.textBox_TotalAmount);
            this.Controls.Add(this.label13);
            this.Controls.Add(this.textBox_AccountsReceivable);
            this.Controls.Add(this.label12);
            this.Controls.Add(this.textBox_TotTaxAmount);
            this.Controls.Add(this.label11);
            this.Controls.Add(this.textBox_TotSupplyPrice);
            this.Controls.Add(this.label10);
            this.Controls.Add(this.label9);
            this.Controls.Add(this.label8);
            this.Controls.Add(this.label7);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.TextBox textBox_TotSupplyPrice;
        private System.Windows.Forms.TextBox textBox_TotTaxAmount;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.TextBox textBox_AccountsReceivable;
        private System.Windows.Forms.Label label12;
        private System.Windows.Forms.TextBox textBox_TotalAmount;
        private System.Windows.Forms.Label label13;
        private System.Windows.Forms.TextBox textBox14;
        private System.Windows.Forms.Label label14;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.Button BtnAddRow_Click;
    }
}

