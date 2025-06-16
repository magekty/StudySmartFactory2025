namespace S250616_OOP_GUI_Observer
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
            this.btnPublish = new System.Windows.Forms.Button();
            this.btnAddSub1 = new System.Windows.Forms.Button();
            this.btnRemoveSub1 = new System.Windows.Forms.Button();
            this.lblSub1 = new System.Windows.Forms.Label();
            this.txtNews = new System.Windows.Forms.TextBox();
            this.lblSub2 = new System.Windows.Forms.Label();
            this.btnRemoveSub2 = new System.Windows.Forms.Button();
            this.btnAddSub2 = new System.Windows.Forms.Button();
            this.lblSub3 = new System.Windows.Forms.Label();
            this.btnRemoveSub3 = new System.Windows.Forms.Button();
            this.btnAddSub3 = new System.Windows.Forms.Button();
            this.lblSub4 = new System.Windows.Forms.Label();
            this.btnRemoveSub4 = new System.Windows.Forms.Button();
            this.btnAddSub4 = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // btnPublish
            // 
            this.btnPublish.Location = new System.Drawing.Point(396, 44);
            this.btnPublish.Name = "btnPublish";
            this.btnPublish.Size = new System.Drawing.Size(75, 23);
            this.btnPublish.TabIndex = 0;
            this.btnPublish.Text = "이슈 발행";
            this.btnPublish.UseVisualStyleBackColor = true;
            this.btnPublish.Click += new System.EventHandler(this.btnPublish_Click);
            // 
            // btnAddSub1
            // 
            this.btnAddSub1.Location = new System.Drawing.Point(143, 85);
            this.btnAddSub1.Name = "btnAddSub1";
            this.btnAddSub1.Size = new System.Drawing.Size(75, 23);
            this.btnAddSub1.TabIndex = 1;
            this.btnAddSub1.Text = "구독 신청";
            this.btnAddSub1.UseVisualStyleBackColor = true;
            this.btnAddSub1.Click += new System.EventHandler(this.btnAddSub1_Click);
            // 
            // btnRemoveSub1
            // 
            this.btnRemoveSub1.Location = new System.Drawing.Point(236, 85);
            this.btnRemoveSub1.Name = "btnRemoveSub1";
            this.btnRemoveSub1.Size = new System.Drawing.Size(75, 23);
            this.btnRemoveSub1.TabIndex = 2;
            this.btnRemoveSub1.Text = "구독 취소";
            this.btnRemoveSub1.UseVisualStyleBackColor = true;
            this.btnRemoveSub1.Click += new System.EventHandler(this.btnRemoveSub1_Click);
            // 
            // lblSub1
            // 
            this.lblSub1.AutoSize = true;
            this.lblSub1.Location = new System.Drawing.Point(326, 90);
            this.lblSub1.Name = "lblSub1";
            this.lblSub1.Size = new System.Drawing.Size(57, 12);
            this.lblSub1.TabIndex = 3;
            this.lblSub1.Text = "구독 안함";
            // 
            // txtNews
            // 
            this.txtNews.Location = new System.Drawing.Point(143, 44);
            this.txtNews.Name = "txtNews";
            this.txtNews.Size = new System.Drawing.Size(247, 21);
            this.txtNews.TabIndex = 4;
            // 
            // lblSub2
            // 
            this.lblSub2.AutoSize = true;
            this.lblSub2.Location = new System.Drawing.Point(326, 119);
            this.lblSub2.Name = "lblSub2";
            this.lblSub2.Size = new System.Drawing.Size(57, 12);
            this.lblSub2.TabIndex = 7;
            this.lblSub2.Text = "구독 안함";
            // 
            // btnRemoveSub2
            // 
            this.btnRemoveSub2.Location = new System.Drawing.Point(236, 114);
            this.btnRemoveSub2.Name = "btnRemoveSub2";
            this.btnRemoveSub2.Size = new System.Drawing.Size(75, 23);
            this.btnRemoveSub2.TabIndex = 6;
            this.btnRemoveSub2.Text = "구독 취소";
            this.btnRemoveSub2.UseVisualStyleBackColor = true;
            this.btnRemoveSub2.Click += new System.EventHandler(this.btnRemoveSub2_Click);
            // 
            // btnAddSub2
            // 
            this.btnAddSub2.Location = new System.Drawing.Point(143, 114);
            this.btnAddSub2.Name = "btnAddSub2";
            this.btnAddSub2.Size = new System.Drawing.Size(75, 23);
            this.btnAddSub2.TabIndex = 5;
            this.btnAddSub2.Text = "구독 신청";
            this.btnAddSub2.UseVisualStyleBackColor = true;
            this.btnAddSub2.Click += new System.EventHandler(this.btnAddSub2_Click);
            // 
            // lblSub3
            // 
            this.lblSub3.AutoSize = true;
            this.lblSub3.Location = new System.Drawing.Point(326, 148);
            this.lblSub3.Name = "lblSub3";
            this.lblSub3.Size = new System.Drawing.Size(57, 12);
            this.lblSub3.TabIndex = 10;
            this.lblSub3.Text = "구독 안함";
            // 
            // btnRemoveSub3
            // 
            this.btnRemoveSub3.Location = new System.Drawing.Point(236, 143);
            this.btnRemoveSub3.Name = "btnRemoveSub3";
            this.btnRemoveSub3.Size = new System.Drawing.Size(75, 23);
            this.btnRemoveSub3.TabIndex = 9;
            this.btnRemoveSub3.Text = "구독 취소";
            this.btnRemoveSub3.UseVisualStyleBackColor = true;
            this.btnRemoveSub3.Click += new System.EventHandler(this.btnRemoveSub3_Click);
            // 
            // btnAddSub3
            // 
            this.btnAddSub3.Location = new System.Drawing.Point(143, 143);
            this.btnAddSub3.Name = "btnAddSub3";
            this.btnAddSub3.Size = new System.Drawing.Size(75, 23);
            this.btnAddSub3.TabIndex = 8;
            this.btnAddSub3.Text = "구독 신청";
            this.btnAddSub3.UseVisualStyleBackColor = true;
            this.btnAddSub3.Click += new System.EventHandler(this.btnAddSub3_Click);
            // 
            // lblSub4
            // 
            this.lblSub4.AutoSize = true;
            this.lblSub4.Location = new System.Drawing.Point(326, 177);
            this.lblSub4.Name = "lblSub4";
            this.lblSub4.Size = new System.Drawing.Size(57, 12);
            this.lblSub4.TabIndex = 13;
            this.lblSub4.Text = "구독 안함";
            // 
            // btnRemoveSub4
            // 
            this.btnRemoveSub4.Location = new System.Drawing.Point(236, 172);
            this.btnRemoveSub4.Name = "btnRemoveSub4";
            this.btnRemoveSub4.Size = new System.Drawing.Size(75, 23);
            this.btnRemoveSub4.TabIndex = 12;
            this.btnRemoveSub4.Text = "구독 취소";
            this.btnRemoveSub4.UseVisualStyleBackColor = true;
            this.btnRemoveSub4.Click += new System.EventHandler(this.btnRemoveSub4_Click);
            // 
            // btnAddSub4
            // 
            this.btnAddSub4.Location = new System.Drawing.Point(143, 172);
            this.btnAddSub4.Name = "btnAddSub4";
            this.btnAddSub4.Size = new System.Drawing.Size(75, 23);
            this.btnAddSub4.TabIndex = 11;
            this.btnAddSub4.Text = "구독 신청";
            this.btnAddSub4.UseVisualStyleBackColor = true;
            this.btnAddSub4.Click += new System.EventHandler(this.btnAddSub4_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.lblSub4);
            this.Controls.Add(this.btnRemoveSub4);
            this.Controls.Add(this.btnAddSub4);
            this.Controls.Add(this.lblSub3);
            this.Controls.Add(this.btnRemoveSub3);
            this.Controls.Add(this.btnAddSub3);
            this.Controls.Add(this.lblSub2);
            this.Controls.Add(this.btnRemoveSub2);
            this.Controls.Add(this.btnAddSub2);
            this.Controls.Add(this.txtNews);
            this.Controls.Add(this.lblSub1);
            this.Controls.Add(this.btnRemoveSub1);
            this.Controls.Add(this.btnAddSub1);
            this.Controls.Add(this.btnPublish);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button btnPublish;
        private System.Windows.Forms.Button btnAddSub1;
        private System.Windows.Forms.Button btnRemoveSub1;
        private System.Windows.Forms.Label lblSub1;
        private System.Windows.Forms.TextBox txtNews;
        private System.Windows.Forms.Label lblSub2;
        private System.Windows.Forms.Button btnRemoveSub2;
        private System.Windows.Forms.Button btnAddSub2;
        private System.Windows.Forms.Label lblSub3;
        private System.Windows.Forms.Button btnRemoveSub3;
        private System.Windows.Forms.Button btnAddSub3;
        private System.Windows.Forms.Label lblSub4;
        private System.Windows.Forms.Button btnRemoveSub4;
        private System.Windows.Forms.Button btnAddSub4;
    }
}

