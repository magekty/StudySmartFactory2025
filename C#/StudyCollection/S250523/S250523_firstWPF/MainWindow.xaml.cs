using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace S250523_firstWPF
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

        private void label1_MouseDown(object sender, MouseButtonEventArgs e)
        {
            if (label1.Foreground != Brushes.White)
            {
                label1.Foreground = Brushes.White;
                this.Background = Brushes.Blue;
            }
            else
            {
                label1.Foreground = SystemColors.WindowTextBrush;
                this.Background = SystemColors.WindowBrush;
            }
        }
    }
}