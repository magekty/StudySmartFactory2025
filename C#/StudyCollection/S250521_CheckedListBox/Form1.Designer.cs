namespace S250521_CheckedListBox
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
            this.checkedListBox1 = new System.Windows.Forms.CheckedListBox();
            this.label1 = new System.Windows.Forms.Label();
            this.button_ToRight = new System.Windows.Forms.Button();
            this.button_ToRightAll = new System.Windows.Forms.Button();
            this.button_Remove = new System.Windows.Forms.Button();
            this.listBox1 = new System.Windows.Forms.ListBox();
            this.button_Clear = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // checkedListBox1
            // 
            this.checkedListBox1.FormattingEnabled = true;
            this.checkedListBox1.Location = new System.Drawing.Point(58, 29);
            this.checkedListBox1.Name = "checkedListBox1";
            this.checkedListBox1.Size = new System.Drawing.Size(120, 228);
            this.checkedListBox1.TabIndex = 0;
            this.checkedListBox1.SelectedIndexChanged += new System.EventHandler(this.CheckedListBoxChanged);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(637, 29);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(38, 12);
            this.label1.TabIndex = 1;
            this.label1.Text = "label1";
            // 
            // button_ToRight
            // 
            this.button_ToRight.Location = new System.Drawing.Point(214, 69);
            this.button_ToRight.Name = "button_ToRight";
            this.button_ToRight.Size = new System.Drawing.Size(75, 23);
            this.button_ToRight.TabIndex = 2;
            this.button_ToRight.Text = ">";
            this.button_ToRight.UseVisualStyleBackColor = true;
            this.button_ToRight.Click += new System.EventHandler(this.button_ToRight_Click);
            // 
            // button_ToRightAll
            // 
            this.button_ToRightAll.Location = new System.Drawing.Point(214, 108);
            this.button_ToRightAll.Name = "button_ToRightAll";
            this.button_ToRightAll.Size = new System.Drawing.Size(75, 23);
            this.button_ToRightAll.TabIndex = 3;
            this.button_ToRightAll.Text = ">>";
            this.button_ToRightAll.UseVisualStyleBackColor = true;
            this.button_ToRightAll.Click += new System.EventHandler(this.button_ToRightAll_Click);
            // 
            // button_Remove
            // 
            this.button_Remove.Location = new System.Drawing.Point(214, 151);
            this.button_Remove.Name = "button_Remove";
            this.button_Remove.Size = new System.Drawing.Size(75, 23);
            this.button_Remove.TabIndex = 4;
            this.button_Remove.Text = "<";
            this.button_Remove.UseVisualStyleBackColor = true;
            this.button_Remove.Click += new System.EventHandler(this.button_Remove_Click);
            // 
            // listBox1
            // 
            this.listBox1.FormattingEnabled = true;
            this.listBox1.ItemHeight = 12;
            this.listBox1.Location = new System.Drawing.Point(324, 29);
            this.listBox1.Name = "listBox1";
            this.listBox1.Size = new System.Drawing.Size(120, 232);
            this.listBox1.TabIndex = 5;
            // 
            // button_Clear
            // 
            this.button_Clear.Location = new System.Drawing.Point(214, 193);
            this.button_Clear.Name = "button_Clear";
            this.button_Clear.Size = new System.Drawing.Size(75, 23);
            this.button_Clear.TabIndex = 6;
            this.button_Clear.Text = "모두 삭제";
            this.button_Clear.UseVisualStyleBackColor = true;
            this.button_Clear.Click += new System.EventHandler(this.button_Clear_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 286);
            this.Controls.Add(this.button_Clear);
            this.Controls.Add(this.listBox1);
            this.Controls.Add(this.button_Remove);
            this.Controls.Add(this.button_ToRightAll);
            this.Controls.Add(this.button_ToRight);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.checkedListBox1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.CheckedListBox checkedListBox1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button button_ToRight;
        private System.Windows.Forms.Button button_ToRightAll;
        private System.Windows.Forms.Button button_Remove;
        private System.Windows.Forms.ListBox listBox1;
        private System.Windows.Forms.Button button_Clear;
    }
}

