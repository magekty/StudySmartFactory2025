using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;

namespace MY_LOGIN_ERP
{
    /// <summary>
    /// MainWindow.xaml에 대한 상호 작용 논리
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
            // 텍스트 박스 초기 힌트 텍스트 (선택 사항)
            txtUserID.Text = "사용자 ID를 입력하세요.";
            txtUserID.Foreground = Brushes.LightGray;
            txtPassword.Password = "비밀번호를 입력하세요.";
            txtPassword.Foreground = Brushes.LightGray;
        }
        private void btnReg_Click(object sender, RoutedEventArgs e)
        {
            RegUser regUser = new RegUser();
            regUser.ShowDialog();
        }

        private void btnLogin_Click(object sender, RoutedEventArgs e)
        {
            string userID = txtUserID.Text;
            string password = txtPassword.Password;

            // 실제 로그인 로직 구현 (데이터베이스 연동 등)
            if (userID == "1" && password == "1") // 예시
            {
                MessageBox.Show("로그인 성공!");
                // 다음 화면으로 이동하는 코드
                ERPHumanResources eRPHumanResources = new ERPHumanResources();
                eRPHumanResources.Show();
                this.Close();
            }
            else
            {
                MessageBox.Show("로그인 실패. 사용자 ID 또는 비밀번호를 확인하세요.", "로그인 오류", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        private void btnCancel_Click(object sender, RoutedEventArgs e)
        {
            Application.Current.Shutdown();
        }

        // 텍스트 박스 힌트 텍스트 기능 (선택 사항)
        private void TextBox_GotFocus(object sender, RoutedEventArgs e)
        {
            TextBox textBox = (TextBox)sender;
            if (textBox.Foreground == Brushes.LightGray)
            {
                textBox.Text = string.Empty;
                textBox.Foreground = Brushes.Black;
            }
        }

        private void TextBox_LostFocus(object sender, RoutedEventArgs e)
        {
            TextBox textBox = (TextBox)sender;
            if (string.IsNullOrWhiteSpace(textBox.Text))
            {
                textBox.Text = "사용자 ID를 입력하세요.";
                textBox.Foreground = Brushes.LightGray;
            }
        }

        private void PasswordBox_GotFocus(object sender, RoutedEventArgs e)
        {
            PasswordBox passwordBox = (PasswordBox)sender;
            if (passwordBox.Foreground == Brushes.LightGray)
            {
                passwordBox.Password = string.Empty;
                passwordBox.Foreground = Brushes.Black;
            }
        }

        private void PasswordBox_LostFocus(object sender, RoutedEventArgs e)
        {
            PasswordBox passwordBox = (PasswordBox)sender;
            if (string.IsNullOrWhiteSpace(passwordBox.Password))
            {
                passwordBox.Password = "비밀번호를 입력하세요.";
                passwordBox.Foreground = Brushes.LightGray;
            }
        }

    }
}
