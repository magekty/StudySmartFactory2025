﻿namespace S250617_OOP_GUI_factoryMethod
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
            this.btnLightTheme = new System.Windows.Forms.Button();
            this.btnDarkTheme = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // btnLightTheme
            // 
            this.btnLightTheme.Location = new System.Drawing.Point(13, 13);
            this.btnLightTheme.Name = "btnLightTheme";
            this.btnLightTheme.Size = new System.Drawing.Size(97, 23);
            this.btnLightTheme.TabIndex = 0;
            this.btnLightTheme.Text = "Light 테마 열기";
            this.btnLightTheme.UseVisualStyleBackColor = true;
            this.btnLightTheme.Click += new System.EventHandler(this.btnLightTheme_Click);
            // 
            // btnDarkTheme
            // 
            this.btnDarkTheme.Location = new System.Drawing.Point(116, 12);
            this.btnDarkTheme.Name = "btnDarkTheme";
            this.btnDarkTheme.Size = new System.Drawing.Size(96, 23);
            this.btnDarkTheme.TabIndex = 1;
            this.btnDarkTheme.Text = "Dark 테마 열기";
            this.btnDarkTheme.UseVisualStyleBackColor = true;
            this.btnDarkTheme.Click += new System.EventHandler(this.btnDarkTheme_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.btnDarkTheme);
            this.Controls.Add(this.btnLightTheme);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btnLightTheme;
        private System.Windows.Forms.Button btnDarkTheme;
    }
}

