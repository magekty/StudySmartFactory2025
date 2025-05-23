namespace S250521_ComboBox
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
            this.comboBox_Tools = new System.Windows.Forms.ComboBox();
            this.label_SelectedTool = new System.Windows.Forms.Label();
            this.button_Add_Click = new System.Windows.Forms.Button();
            this.button_Remove_Click = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(99, 54);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(87, 12);
            this.label1.TabIndex = 0;
            this.label1.Text = "사용할 공구는?";
            // 
            // comboBox_Tools
            // 
            this.comboBox_Tools.FormattingEnabled = true;
            this.comboBox_Tools.Items.AddRange(new object[] {
            "드릴",
            "해머",
            "용접"});
            this.comboBox_Tools.Location = new System.Drawing.Point(101, 88);
            this.comboBox_Tools.Name = "comboBox_Tools";
            this.comboBox_Tools.Size = new System.Drawing.Size(121, 20);
            this.comboBox_Tools.TabIndex = 1;
            this.comboBox_Tools.SelectedIndexChanged += new System.EventHandler(this.comboBox_Tools_SelectedIndexChanged);
            // 
            // label_SelectedTool
            // 
            this.label_SelectedTool.AutoSize = true;
            this.label_SelectedTool.Location = new System.Drawing.Point(99, 139);
            this.label_SelectedTool.Name = "label_SelectedTool";
            this.label_SelectedTool.Size = new System.Drawing.Size(73, 12);
            this.label_SelectedTool.TabIndex = 2;
            this.label_SelectedTool.Text = "선택한 공구:";
            // 
            // button_Add_Click
            // 
            this.button_Add_Click.Location = new System.Drawing.Point(244, 88);
            this.button_Add_Click.Name = "button_Add_Click";
            this.button_Add_Click.Size = new System.Drawing.Size(42, 23);
            this.button_Add_Click.TabIndex = 3;
            this.button_Add_Click.Text = "추가";
            this.button_Add_Click.UseVisualStyleBackColor = true;
            this.button_Add_Click.Click += new System.EventHandler(this.button_Add_Click_Click);
            // 
            // button_Remove_Click
            // 
            this.button_Remove_Click.Location = new System.Drawing.Point(292, 88);
            this.button_Remove_Click.Name = "button_Remove_Click";
            this.button_Remove_Click.Size = new System.Drawing.Size(42, 23);
            this.button_Remove_Click.TabIndex = 4;
            this.button_Remove_Click.Text = "제거";
            this.button_Remove_Click.UseVisualStyleBackColor = true;
            this.button_Remove_Click.Click += new System.EventHandler(this.button_Remove_Click_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.button_Remove_Click);
            this.Controls.Add(this.button_Add_Click);
            this.Controls.Add(this.label_SelectedTool);
            this.Controls.Add(this.comboBox_Tools);
            this.Controls.Add(this.label1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ComboBox comboBox_Tools;
        private System.Windows.Forms.Label label_SelectedTool;
        private System.Windows.Forms.Button button_Add_Click;
        private System.Windows.Forms.Button button_Remove_Click;
    }
}

