using System.Reflection.Emit;
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

namespace S250523_WPF간단계산기
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private bool newButton;
        private double savedValue;
        private char myOperator;
        
        public MainWindow()
        {
            InitializeComponent();
        }
        private void btn_Click(object sender, RoutedEventArgs e)
        {
            Button btn = sender as Button;
            
            string number = btn.Content.ToString();
            if(txtResult.Text == "0" || newButton == true)
            {
                txtResult.Text = number;
                newButton = false;
            }else
                txtResult.Text += number;
        }

        private void btnOp_Click(object sender, RoutedEventArgs e)
        {
            Button btn = sender as Button;

            savedValue = double.Parse(txtResult.Text);
            myOperator = btn.Content.ToString()[0];
            newButton = true;
        }
        private void Dot_Click(object sender, RoutedEventArgs e)
        {
            if(!txtResult.Text.Contains("."))
                txtResult.Text += ".";
        }

        private void Equal_Click(object sender, RoutedEventArgs e)
        {
            if (myOperator == '+')
                txtResult.Text = (savedValue + double.Parse(txtResult.Text)).ToString();
            else if (myOperator == '-')
                txtResult.Text = (savedValue - double.Parse(txtResult.Text)).ToString();
            else if (myOperator == 'x')
                txtResult.Text = (savedValue * double.Parse(txtResult.Text)).ToString();
            else if (myOperator == '÷')
                txtResult.Text = (savedValue / double.Parse(txtResult.Text)).ToString();
        }


    }
}