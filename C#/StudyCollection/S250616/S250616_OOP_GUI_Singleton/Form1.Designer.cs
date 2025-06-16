namespace S250616_OOP_GUI_Singleton
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
            this.btnOpenSetting = new System.Windows.Forms.Button();
            this.btnNewWindows = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // btnOpenSetting
            // 
            this.btnOpenSetting.Location = new System.Drawing.Point(154, 91);
            this.btnOpenSetting.Name = "btnOpenSetting";
            this.btnOpenSetting.Size = new System.Drawing.Size(87, 23);
            this.btnOpenSetting.TabIndex = 0;
            this.btnOpenSetting.Text = "싱글톤 열기";
            this.btnOpenSetting.UseVisualStyleBackColor = true;
            this.btnOpenSetting.Click += new System.EventHandler(this.btnOpenSetting_Click);
            // 
            // btnNewWindows
            // 
            this.btnNewWindows.Location = new System.Drawing.Point(154, 120);
            this.btnNewWindows.Name = "btnNewWindows";
            this.btnNewWindows.Size = new System.Drawing.Size(87, 23);
            this.btnNewWindows.TabIndex = 1;
            this.btnNewWindows.Text = "여러창 열기";
            this.btnNewWindows.UseVisualStyleBackColor = true;
            this.btnNewWindows.Click += new System.EventHandler(this.btnNewWindows_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.btnNewWindows);
            this.Controls.Add(this.btnOpenSetting);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btnOpenSetting;
        private System.Windows.Forms.Button btnNewWindows;
    }
}

