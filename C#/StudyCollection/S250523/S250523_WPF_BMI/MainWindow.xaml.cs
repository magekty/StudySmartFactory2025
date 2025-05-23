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

namespace S250523_WPF_BMI
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

        private void btnBMI_Click(object sender, RoutedEventArgs e)
        {
            if(txtHeight.Text == "" || txtWeight.Text == "")
            {
                lblResult.Content = "키와 체중을 입력하세요";
                return;
            }
            double h = Convert.ToDouble(txtHeight.Text) * 0.01;
            double w = Double.Parse(txtWeight.Text);
            double bmi = w / (h * h);

            lblResult.Content = string.Format("당신의 BMI는 {0:F2} 입니다", bmi);
        }
    }
}