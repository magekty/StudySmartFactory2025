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
using DotNetEnv;    // 김태영 추가 프로젝트->NutGet패키지관리->찾아보기(DotNetEnv)설치 Environment 접근시필요

namespace OnedayProject
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        //private string connStr = "server=localhost;user=root;password=1121;database=restaurant;";   // 김태영 다음줄 수정
        public string connStr { get; set; } = "";    // 김태영 추가
        private string env = "";    // 김태영 추가
        public MainWindow()
        {
            InitializeComponent();
            btnLogin.Click += BtnLogin_Click;
        }
        private void envCheck(string role)  // 김태영 추가
        {
            env = Environment.GetEnvironmentVariable("APP_ENV") ?? role;

            string envFile = "";
            switch (env)
            {
                case "staff":
                    envFile = ".env.staff"; break;
                case "admin":
                    envFile = ".env.admin"; break;
                default:
                    MessageBox.Show("잘못된접근!");
                    break;
            }

            Env.Load("../../../" + envFile);

            string? server = Environment.GetEnvironmentVariable("DB_SERVER");
            string? database = Environment.GetEnvironmentVariable("DB_NAME");
            string? user = Environment.GetEnvironmentVariable("DB_USER");
            string? password = Environment.GetEnvironmentVariable("DB_PASSWORD");

            connStr = $"Server={server};Database={database};Uid={user};Pwd={password};";

        }
        private void BtnLogin_Click(object sender, RoutedEventArgs e)
        {
            string username = txtUserName.Text.Trim();
            string password = txtPassword.Password;
            string role = "";

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                MessageBox.Show("아이디와 비밀번호를 모두 입력하세요.", "입력 오류", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }
            if (username == "root") role = "admin"; //김태영 추가
            else role = "staff"; // 김태영 추가
            envCheck(role); // 김태영 추가
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
                        //MessageBox.Show("로그인되었습니다.", "성공", MessageBoxButton.OK, MessageBoxImage.Information);   // 김태영 다음줄 수정
                        MessageBox.Show($"{role}으로 로그인되었습니다.", "성공", MessageBoxButton.OK, MessageBoxImage.Information);
                    // 새 창 열기
                    MainWindow2 window2 = new MainWindow2(this);
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