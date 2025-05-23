namespace S250521_ListBox
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
            this.listBox_GDP = new System.Windows.Forms.ListBox();
            this.listBox_GoodCity = new System.Windows.Forms.ListBox();
            this.listBox_HappyCountry = new System.Windows.Forms.ListBox();
            this.textBox_IndexGDP = new System.Windows.Forms.TextBox();
            this.textBox_ItemGDP = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.textBox_ItemGoodCity = new System.Windows.Forms.TextBox();
            this.textBox_IndexGoodCity = new System.Windows.Forms.TextBox();
            this.textBox_ItemHappyCountry = new System.Windows.Forms.TextBox();
            this.textBox_IndexHappyCountry = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.textBox_AddCountry = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.label4 = new System.Windows.Forms.Label();
            this.textBox_RemoveCountry = new System.Windows.Forms.TextBox();
            this.button2 = new System.Windows.Forms.Button();
            this.textBox_RemoveAtCountry = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.button3 = new System.Windows.Forms.Button();
            this.button4 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // listBox_GDP
            // 
            this.listBox_GDP.FormattingEnabled = true;
            this.listBox_GDP.ItemHeight = 12;
            this.listBox_GDP.Items.AddRange(new object[] {
            "미국",
            "러시아",
            "중국",
            "영국",
            "독일",
            "프랑스",
            "일본",
            "이스라엘",
            "사우디아라비아",
            "UAE"});
            this.listBox_GDP.Location = new System.Drawing.Point(126, 38);
            this.listBox_GDP.Name = "listBox_GDP";
            this.listBox_GDP.Size = new System.Drawing.Size(120, 112);
            this.listBox_GDP.TabIndex = 0;
            this.listBox_GDP.SelectedIndexChanged += new System.EventHandler(this.listBox_GDP_SelectedIndexChanged);
            // 
            // listBox_GoodCity
            // 
            this.listBox_GoodCity.FormattingEnabled = true;
            this.listBox_GoodCity.ItemHeight = 12;
            this.listBox_GoodCity.Location = new System.Drawing.Point(282, 38);
            this.listBox_GoodCity.Name = "listBox_GoodCity";
            this.listBox_GoodCity.Size = new System.Drawing.Size(120, 112);
            this.listBox_GoodCity.TabIndex = 1;
            // 
            // listBox_HappyCountry
            // 
            this.listBox_HappyCountry.FormattingEnabled = true;
            this.listBox_HappyCountry.ItemHeight = 12;
            this.listBox_HappyCountry.Location = new System.Drawing.Point(436, 38);
            this.listBox_HappyCountry.Name = "listBox_HappyCountry";
            this.listBox_HappyCountry.Size = new System.Drawing.Size(148, 112);
            this.listBox_HappyCountry.TabIndex = 2;
            // 
            // textBox_IndexGDP
            // 
            this.textBox_IndexGDP.Location = new System.Drawing.Point(126, 169);
            this.textBox_IndexGDP.Name = "textBox_IndexGDP";
            this.textBox_IndexGDP.Size = new System.Drawing.Size(120, 21);
            this.textBox_IndexGDP.TabIndex = 3;
            // 
            // textBox_ItemGDP
            // 
            this.textBox_ItemGDP.Location = new System.Drawing.Point(126, 209);
            this.textBox_ItemGDP.Name = "textBox_ItemGDP";
            this.textBox_ItemGDP.Size = new System.Drawing.Size(120, 21);
            this.textBox_ItemGDP.TabIndex = 4;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(10, 172);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(81, 12);
            this.label1.TabIndex = 5;
            this.label1.Text = "선택된 인덱스";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(10, 214);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(109, 12);
            this.label2.TabIndex = 6;
            this.label2.Text = "선택된 아이템 내용";
            // 
            // textBox_ItemGoodCity
            // 
            this.textBox_ItemGoodCity.Location = new System.Drawing.Point(282, 209);
            this.textBox_ItemGoodCity.Name = "textBox_ItemGoodCity";
            this.textBox_ItemGoodCity.Size = new System.Drawing.Size(120, 21);
            this.textBox_ItemGoodCity.TabIndex = 8;
            // 
            // textBox_IndexGoodCity
            // 
            this.textBox_IndexGoodCity.Location = new System.Drawing.Point(282, 169);
            this.textBox_IndexGoodCity.Name = "textBox_IndexGoodCity";
            this.textBox_IndexGoodCity.Size = new System.Drawing.Size(120, 21);
            this.textBox_IndexGoodCity.TabIndex = 7;
            // 
            // textBox_ItemHappyCountry
            // 
            this.textBox_ItemHappyCountry.Location = new System.Drawing.Point(436, 209);
            this.textBox_ItemHappyCountry.Name = "textBox_ItemHappyCountry";
            this.textBox_ItemHappyCountry.Size = new System.Drawing.Size(148, 21);
            this.textBox_ItemHappyCountry.TabIndex = 10;
            // 
            // textBox_IndexHappyCountry
            // 
            this.textBox_IndexHappyCountry.Location = new System.Drawing.Point(436, 169);
            this.textBox_IndexHappyCountry.Name = "textBox_IndexHappyCountry";
            this.textBox_IndexHappyCountry.Size = new System.Drawing.Size(148, 21);
            this.textBox_IndexHappyCountry.TabIndex = 9;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(12, 249);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(101, 12);
            this.label3.TabIndex = 11;
            this.label3.Text = "추가할 나라 이름:";
            // 
            // textBox_AddCountry
            // 
            this.textBox_AddCountry.Location = new System.Drawing.Point(126, 246);
            this.textBox_AddCountry.Name = "textBox_AddCountry";
            this.textBox_AddCountry.Size = new System.Drawing.Size(75, 21);
            this.textBox_AddCountry.TabIndex = 12;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(207, 246);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(39, 23);
            this.button1.TabIndex = 13;
            this.button1.Text = "추가";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(12, 283);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(101, 12);
            this.label4.TabIndex = 14;
            this.label4.Text = "제거할 나라 이름:";
            // 
            // textBox_RemoveCountry
            // 
            this.textBox_RemoveCountry.Location = new System.Drawing.Point(126, 280);
            this.textBox_RemoveCountry.Name = "textBox_RemoveCountry";
            this.textBox_RemoveCountry.Size = new System.Drawing.Size(75, 21);
            this.textBox_RemoveCountry.TabIndex = 15;
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(207, 278);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(39, 23);
            this.button2.TabIndex = 16;
            this.button2.Text = "제거";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // textBox_RemoveAtCountry
            // 
            this.textBox_RemoveAtCountry.Location = new System.Drawing.Point(126, 311);
            this.textBox_RemoveAtCountry.Name = "textBox_RemoveAtCountry";
            this.textBox_RemoveAtCountry.Size = new System.Drawing.Size(75, 21);
            this.textBox_RemoveAtCountry.TabIndex = 18;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(12, 314);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(113, 12);
            this.label5.TabIndex = 17;
            this.label5.Text = "제거할 나라 인덱스:";
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(207, 311);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(39, 23);
            this.button3.TabIndex = 19;
            this.button3.Text = "제거";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.button3_Click);
            // 
            // button4
            // 
            this.button4.Location = new System.Drawing.Point(126, 338);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(120, 23);
            this.button4.TabIndex = 20;
            this.button4.Text = "clear";
            this.button4.UseVisualStyleBackColor = true;
            this.button4.Click += new System.EventHandler(this.button4_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(624, 388);
            this.Controls.Add(this.button4);
            this.Controls.Add(this.button3);
            this.Controls.Add(this.textBox_RemoveAtCountry);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.textBox_RemoveCountry);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.textBox_AddCountry);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.textBox_ItemHappyCountry);
            this.Controls.Add(this.textBox_IndexHappyCountry);
            this.Controls.Add(this.textBox_ItemGoodCity);
            this.Controls.Add(this.textBox_IndexGoodCity);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.textBox_ItemGDP);
            this.Controls.Add(this.textBox_IndexGDP);
            this.Controls.Add(this.listBox_HappyCountry);
            this.Controls.Add(this.listBox_GoodCity);
            this.Controls.Add(this.listBox_GDP);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.ListBox listBox_GDP;
        private System.Windows.Forms.ListBox listBox_GoodCity;
        private System.Windows.Forms.ListBox listBox_HappyCountry;
        private System.Windows.Forms.TextBox textBox_IndexGDP;
        private System.Windows.Forms.TextBox textBox_ItemGDP;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox textBox_ItemGoodCity;
        private System.Windows.Forms.TextBox textBox_IndexGoodCity;
        private System.Windows.Forms.TextBox textBox_ItemHappyCountry;
        private System.Windows.Forms.TextBox textBox_IndexHappyCountry;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox textBox_AddCountry;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox textBox_RemoveCountry;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.TextBox textBox_RemoveAtCountry;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.Button button4;
    }
}

