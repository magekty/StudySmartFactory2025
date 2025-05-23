using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace S250522_ListView
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            myListView.GridLines = true;    // 그리드 선 표시 여부
            myListView.FullRowSelect = true;    // 

            myListView.Columns.Add("제품명", 150);
            myListView.Columns.Add("단가", 100, HorizontalAlignment.Right);
            myListView.Columns.Add("수량", 70, HorizontalAlignment.Right);
            myListView.Columns.Add("금액", 100, HorizontalAlignment.Right);

            ListViewItem item1 = new ListViewItem("Access", 0);
            ListViewItem item2 = new ListViewItem("Excel", 1);
            ListViewItem item3 = new ListViewItem("Power Point", 2);
            ListViewItem item4 = new ListViewItem("Word", 3);
            //ListViewItem item5 = new ListViewItem("Office", 4);

            item1.SubItems.Add("22000");
            item1.SubItems.Add("30");
            item1.SubItems.Add("660000");

            item2.SubItems.Add("33000");
            item2.SubItems.Add("50");
            item2.SubItems.Add("1650000");

            item3.SubItems.Add("11000");
            item3.SubItems.Add("50");
            item3.SubItems.Add("550000");

            item4.SubItems.Add("22000");
            item4.SubItems.Add("30");
            item4.SubItems.Add("660000");

            myListView.Items.AddRange(new ListViewItem[] {item1, item2, item3, item4 });

            ImageList sImageList = new ImageList();
            sImageList.ImageSize = new Size(24, 24);
            ImageList lImageList = new ImageList();
            lImageList.ImageSize = new Size(64, 64);

            myListView.SmallImageList = sImageList;
            myListView.LargeImageList = lImageList;

            string path = Directory.GetCurrentDirectory();

            sImageList.Images.Add(Bitmap.FromFile(@"../../Image/Access.png"));
            sImageList.Images.Add(Bitmap.FromFile(@"../../Image/Excel.png"));
            sImageList.Images.Add(Bitmap.FromFile(@"../../Image/Power.png"));
            sImageList.Images.Add(Bitmap.FromFile(@"../../Image/Word.png"));
                                                       
            lImageList.Images.Add(Bitmap.FromFile(@"../../Image/Access.png"));
            lImageList.Images.Add(Bitmap.FromFile(@"../../Image/Excel.png"));
            lImageList.Images.Add(Bitmap.FromFile(@"../../Image/Power.png"));
            lImageList.Images.Add(Bitmap.FromFile(@"../../Image/Word.png"));

        }

        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            myListView.View = View.Details;
        }

        private void radioButton2_CheckedChanged(object sender, EventArgs e)
        {
            myListView.View = View.List;
        }

        private void radioButton3_CheckedChanged(object sender, EventArgs e)
        {
            myListView.View = View.SmallIcon;
        }

        private void radioButton4_CheckedChanged(object sender, EventArgs e)
        {
            myListView.View = View.LargeIcon;
        }

        private void myListView_SelectedIndexChanged(object sender, EventArgs e)
        {
            textBox1.Text = "";
            ListView.SelectedListViewItemCollection selected = myListView.SelectedItems;

            foreach (ListViewItem item in selected)
            {
                for (int i = 0; i < myListView.SmallImageList.Images.Count; i++)
                {
                    textBox1.Text += item.SubItems[i].Text + "\t";
                }
            }
        }
    }
}
