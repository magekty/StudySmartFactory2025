using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace S250522_GDI
{
    enum DrawMode {LINE, RECTANGLE, CIRCLE, CURVED_LINE };
    public partial class Form1 : Form
    {
        private DrawMode drawMode;
        private Graphics g;
        private Pen pen = new Pen(Color.Black, 2);
        private Pen eraser;
        Point startP, endP, currP, prevP;

        private void 사각형ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            drawMode = DrawMode.RECTANGLE;
            label1.Text = "RECTANGLE Mode";
        }

        private void 원ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            drawMode = DrawMode.CIRCLE;
            label1.Text = "CIRCLE Mode";
        }

        private void 곡선ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            drawMode = DrawMode.CURVED_LINE;
            label1.Text = "CURVED_LINE Mode";
        }

        private void 색깔ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            ColorDialog colorDialog = new ColorDialog();
            if(colorDialog.ShowDialog() == DialogResult.OK) pen.Color = colorDialog.Color;
        }

        private void Form1_MouseDown(object sender, MouseEventArgs e)
        {
            startP = new Point(e.X, e.Y);
            prevP = startP;
            currP = startP;
        }

        private void Form1_MouseMove(object sender, MouseEventArgs e)
        {
            if (e.Button != MouseButtons.Left) return;
            prevP = currP;
            currP = new Point(e.X, e.Y);

            switch (drawMode)
            {
                case DrawMode.LINE:
                    g.DrawLine(eraser, startP, prevP);
                    g.DrawLine(pen, startP, currP);
                    break;
                case DrawMode.RECTANGLE:
                    g.DrawRectangle(eraser, new Rectangle(startP, new Size(prevP.X - startP.X, prevP.Y - startP.Y)));
                    g.DrawRectangle(pen, new Rectangle(startP, new Size(currP.X - startP.X, currP.Y - startP.Y)));
                    break;
                case DrawMode.CIRCLE:
                    g.DrawEllipse(eraser, new Rectangle(startP, new Size(prevP.X - startP.X, prevP.Y - startP.Y)));
                    g.DrawEllipse(pen, new Rectangle(startP, new Size(currP.X - startP.X, currP.Y - startP.Y)));
                    break;
                case DrawMode.CURVED_LINE:
                    g.DrawLine(pen, prevP, currP);
                    break;


            }
        }

        private void Form1_MouseUp(object sender, MouseEventArgs e)
        {
            endP = new Point(e.X, e.Y);
            switch (drawMode)
            {
                case DrawMode.LINE:
                    g.DrawLine(pen, startP, endP);
                    break;
                case DrawMode.RECTANGLE:
                    g.DrawRectangle(pen, new Rectangle(startP, new Size(endP.X - startP.X, endP.Y - startP.Y)));
                    break;
                case DrawMode.CIRCLE:
                    g.DrawEllipse(pen, new Rectangle(startP, new Size(endP.X - startP.X, endP.Y - startP.Y)));
                    break;
                case DrawMode.CURVED_LINE:
                    break;
            }
        }

        private void 선ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            drawMode = DrawMode.LINE;
            label1.Text = "LINE Mode";

        }

        public Form1()
        {
            InitializeComponent();

            g = CreateGraphics();

            this.BackColor = Color.White;
            this.eraser = new Pen(this.BackColor, 2);
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }
    }
}
