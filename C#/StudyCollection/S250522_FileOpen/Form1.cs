using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Security;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Security.Policy;

namespace S250522_FileOpen
{
    public partial class Form1 : Form
    {
        private OpenFileDialog openFileDialog1;
        private OpenFileDialog openFileDialog2;
        public Form1()
        {
            InitializeComponent();

            openFileDialog1 = new OpenFileDialog();
            openFileDialog1.FileName = "txt 파일을 선택하세요";
            openFileDialog1.Filter = "txt 파일 (*.txt)|*.txt";
            openFileDialog1.Title = "txt 파일 열기";

            openFileDialog2 = new OpenFileDialog();
            openFileDialog2.FileName = "pdf 파일을 선택하세요";
            openFileDialog2.Filter = "pdf 파일 (*.pdf)|*.pdf";
            openFileDialog2.Title = "pdf 파일 열기";
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void btnFile_Click(object sender, EventArgs e)
        {
            if(openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    var filePath = openFileDialog1.FileName;
                    //MessageBox.Show($"pdf filePath:{filePath}");
                    using (FileStream fs = File.Open(filePath, FileMode.Open))
                    {
                        Process.Start("notepad.exe", filePath);
                    }
                }catch(SecurityException ex) 
                {
                    MessageBox.Show($"Security error.\n\nError message:{ex.Message}\n\n" +
                        $"Details:\n\n{ex.StackTrace}");
                }
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (openFileDialog2.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    var filePath = openFileDialog2.FileName;
                    //var filePath = Uri.EscapeUriString(openFileDialog2.FileName);
                    //filePath = filePath.Replace(" ", "%20");
                    //MessageBox.Show($"pdf filePath:{filePath}");
                    using (FileStream fs = File.Open(filePath, FileMode.Open))
                    {
                        //Process.Start("msedge.exe", filePath);
                        Process.Start(new ProcessStartInfo
                        {
                            FileName = filePath,
                            UseShellExecute = true
                        });
                    }
                }
                catch (SecurityException ex)
                {
                    MessageBox.Show($"Security error.\n\nError message:{ex.Message}\n\n" +
                        $"Details:\n\n{ex.StackTrace}");
                }
            }
        }
    }
}
