using System.Text;
using System.Windows;
using System.Windows.Forms;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace S250523_WinformInWPF
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void Btn_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog ofd = new OpenFileDialog();
            ofd.InitialDirectory = @"c:\Users\bikang\pictures";
            ofd.Multiselect = true;
            var result = ofd.ShowDialog();
            if(result == System.Windows.Forms.DialogResult.OK)
            {
                foreach (var s in ofd.FileNames)
                { 
                    lbFiles.Items.Add(s);
                }
            }
        }

    }
}