using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace S250616_OOP_GUI_Memento
{
    public partial class Form1 : Form
    {
        private TextEditor editor = new TextEditor();
        private History history = new History();
        public Form1()
        {
            InitializeComponent();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            editor.Text = txtEditer.Text;
            history.Push( editor.Save() );
            MessageBox.Show("저장 완료");
        }

        private void btnUndo_Click(object sender, EventArgs e)
        {
            if (history.HasHistory)
            {
                editor.Restore( history.Pop() );
                txtEditer.Text = editor.Text;
            }
            else
            {
                MessageBox.Show("복원할게 없음");
            }
        }
    }
    class TextMemento
    {
        public string TextState { get; set; }
        public TextMemento(string text) { TextState = text; }
    }
    class TextEditor
    {
        public string Text { get; set; }
        public TextMemento Save()
        {
            return new TextMemento(Text);
        }
        public void Restore(TextMemento memento) { Text = memento.TextState; }
    }

    class History
    {
        private Stack<TextMemento> mementos = new Stack<TextMemento>();
        public void Push(TextMemento memento) { mementos.Push(memento); }
        public TextMemento Pop()
        {
            if(mementos.Count > 0) return mementos.Pop();
            return null;
        }
        public bool HasHistory => mementos.Count > 0;
    }
}
