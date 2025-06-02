using MySql.Data.MySqlClient;
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
using MySql.Data.MySqlClient;

namespace OnedayProject
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private string connStr = "server=localhost;user=root;password=1121;database=restaurant;";
        public MainWindow()
        {
            InitializeComponent();
            btnLogin.Click += BtnLogin_Click;
        }
        private void BtnLogin_Click(object sender, RoutedEventArgs e)
        {
            string username = txtUserName.Text.Trim();
            string password = txtPassword.Password;

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                MessageBox.Show("아이디와 비밀번호를 모두 입력하세요.", "입력 오류", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            try
            {
                using var conn = new MySqlConnection(connStr);
                conn.Open();

                string query = "SELECT COUNT(*) FROM users WHERE username=@username AND password=@password";
                using var cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@password", password);

                int count = Convert.ToInt32(cmd.ExecuteScalar());

                if (count > 0)
                {
                    MessageBox.Show("로그인되었습니다.", "성공", MessageBoxButton.OK, MessageBoxImage.Information);
                    // 새 창 열기
                    MainWindow2 window2 = new MainWindow2();
                    window2.Show();

                    // 현재 창 닫기 (선택 사항)
                    this.Close();

                }
                else
                {
                    MessageBox.Show("아이디 또는 비밀번호가 올바르지 않습니다.", "로그인 실패", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("DB 연결 중 오류 발생: " + ex.Message, "오류", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
    }
}