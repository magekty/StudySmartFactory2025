using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace OnedayProject
{
    /// <summary>
    /// MainWindow2.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class MainWindow2 : Window
    {
        MainWindow mainWindow;
        public MainWindow2(MainWindow mainWindow)
        {
            InitializeComponent();
            this.mainWindow = mainWindow;
        }

        private void Table1_Click(object sender, RoutedEventArgs e)
        {
            MainWindow3 window = new MainWindow3(1, mainWindow);
            window.Show();
        }

        private void Table2_Click(object sender, RoutedEventArgs e)
        {
            MainWindow3 window = new MainWindow3(2, mainWindow);
            window.Show(); 

        }

        private void Table3_Click(object sender, RoutedEventArgs e)
        {
            MainWindow3 window = new MainWindow3(3, mainWindow);
            window.Show();

        }

        private void Table4_Click(object sender, RoutedEventArgs e)
        {
            MainWindow3 window = new MainWindow3(4, mainWindow);
            window.Show();
        }

    }
}