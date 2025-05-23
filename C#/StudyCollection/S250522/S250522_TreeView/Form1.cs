using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace S250522_TreeView
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            pictureBox1.SizeMode = PictureBoxSizeMode.Zoom;
            
            TreeNode root = new TreeNode("반도체 라인");
            TreeNode proc1_dieBonding = new TreeNode("Die 본딩");
            TreeNode proc2_wireBonding = new TreeNode("Wire 본딩");
            TreeNode proc3_packaging = new TreeNode("패키징");

            root.Nodes.Add(proc1_dieBonding);
            proc1_dieBonding.Nodes.Add("die bonder 1");
            proc1_dieBonding.Nodes.Add("die bonder 2");
            root.Nodes.Add(proc2_wireBonding);
            proc2_wireBonding.Nodes.Add("wire bonder 1");
            proc2_wireBonding.Nodes.Add("wire bonder 2");
            root.Nodes.Add(proc3_packaging);
            proc3_packaging.Nodes.Add("packaging machine 1");
            proc3_packaging.Nodes.Add("packaging machine 2");

            treeView1.Nodes.Add(root);
            treeView1.ExpandAll();
        }

        private void treeView1_AfterSelect(object sender, TreeViewEventArgs e)
        {
            if (e.Node.Text == "die bonder 1")
            {
                pictureBox1.Image = Bitmap.FromFile(@"../../Images/다이본더.jpg");
                txtMemo.Text = "잘 동작 합니다.";
            }
            else if (e.Node.Text == "die bonder 2")
            {
                pictureBox1.Image = Bitmap.FromFile(@"../../Images/다이본더.jpg");
                txtMemo.Text = "소모성 부품 교체 필요합니다. 아직 잘 동작 합니다.";
            }
            else if (e.Node.Text == "wire bonder 1")
            {
                pictureBox1.Image = Bitmap.FromFile(@"../../Images/와이어본더.jpg");
                txtMemo.Text = "오차가 늘고 있습니다.";
            }
            else if (e.Node.Text == "wire bonder 2")
            {
                pictureBox1.Image = Bitmap.FromFile(@"../../Images/와이어본더.jpg");
                txtMemo.Text = "와이어 카트리지 교체가 필요합니다.";
            }
            else if (e.Node.Text == "packaging machine 1")
            {
                pictureBox1.Image = Bitmap.FromFile(@"../../Images/패키징장비.jpg");
                txtMemo.Text = "잘 동작 합니다.";
            }
            else if (e.Node.Text == "packaging machine 2")
            {
                pictureBox1.Image = Bitmap.FromFile(@"../../Images/패키징장비.jpg");
                txtMemo.Text = "온도가 너무 높습니다.";
            }
            //MessageBox.Show(e.Node.Text);
        }
    }
}
