using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using DotNetEnv;
using MySql.Data.MySqlClient;
using Mysqlx.Crud;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;

namespace S250530_LoginMySQLWinform
{
    public partial class Form1 : Form
    {
        private MySqlConnection conn;
        private string currentUser = null;
        string env = "";

        public Form1()
        {
            InitializeComponent();


            /*conn = new MySqlConnection(
                $"server=localhost;user=root;password=1234;database=user_db");*/

            lbl_who.Text = $"로그인 하세요";
        }
        private void envCheck(string role)
        {
            // 1. 환경을 먼저 결정 (기본은 dev)
            env = Environment.GetEnvironmentVariable("APP_ENV") ?? role;

            // 2. 환경에 따라 적절한 .env 파일 로드
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

            // 3. 로드
            Env.Load("../../" + envFile);

            // 4. 환경변수 읽기
            string server = Environment.GetEnvironmentVariable("DB_SERVER");
            string database = Environment.GetEnvironmentVariable("DB_NAME");
            string user = Environment.GetEnvironmentVariable("DB_USER");
            string password = Environment.GetEnvironmentVariable("DB_PASSWORD");

            string connStr = $"Server={server};Database={database};Uid={user};Pwd={password};";
            ///MessageBox.Show($"{connStr}");
            conn = new MySqlConnection(connStr);

        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            envCheck("staff");
            string username = txtLoginUsername.Text;
            string password = txtLoginPassword.Text;
            try
            {
                conn.Open();
                // string query = $"select * from users where username=@username and password=@password";
                string query = $"call sp_loginSelect_test(@username, @password);";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@password", password);
                MySqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    currentUser = username;
                    lbl_who.Text = $"{currentUser}님 안녕하세요.({env})권한";
                    MessageBox.Show($"로그인 성공");

                }
                else
                {
                    MessageBox.Show($"로그인 실패, ID/PW를 확인하세요");
                }
                reader.Close();
            }
            catch (Exception ex) { MessageBox.Show($"오류:{ex.Message}"); }
            finally
            {
                conn.Close();
                txtLoginUsername.Text = "";
                txtLoginPassword.Text = "";
            }

        }

        private void btnLogout_Click(object sender, EventArgs e)
        {
            if (currentUser is null) { MessageBox.Show($"로그인이 되어있지 않습니다."); return; }
            currentUser = null;
            txtLoginUsername.Text = "";
            txtLoginPassword.Text = "";
            lbl_who.Text = $"로그인 하세요.";
            MessageBox.Show($"로그아웃 잘 되었어요.");
        }

        private void btnRegister_Click(object sender, EventArgs e)
        {
            envCheck("admin");
            string regUsername = txtRegUsername.Text;
            string regPassword = txtRegPassword.Text;
            string regName = txtRegName.Text;
            string regEmail = txtRegEmail.Text;

            try
            {
                conn.Open();

                //string query = $"sp_loginInsert_test(@_username, @_password, @_name, @_email, @RESULT); ";
                MySqlCommand cmd = new MySqlCommand("sp_loginInsert_test", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@_username", regUsername);
                cmd.Parameters.AddWithValue("@_password", regPassword);
                cmd.Parameters.AddWithValue("@_name", regName);
                cmd.Parameters.AddWithValue("@_email", regEmail);
                //cmd.Parameters.AddWithValue("@RESULT", result);
                //int affectedRows = cmd.ExecuteNonQuery();

                if (cmd.ExecuteNonQuery() != 0)
                {
                    txtLoginUsername.Text = regUsername;
                    MessageBox.Show($"{regUsername}님 회원가입이 완료되었습니다.");
                }
                else
                {
                    MessageBox.Show($"회원가입이 실패했습니다.");
                }
            }
            catch (Exception ex) { MessageBox.Show($"오류:{ex.Message}"); }
            finally
            {
                conn.Close();
                txtRegUsername.Text = "";
                txtRegPassword.Text = "";
                txtRegName.Text = "";
                txtRegEmail.Text = "";
            }

        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            if (currentUser is null) { MessageBox.Show($"먼저 로그인 하세요."); return; }
            string newPassword = txtNewPassword.Text;
            string newName = txtNewName.Text;
            string newEmail = txtNewEmail.Text;

            try
            {
                conn.Open();
                string query = $"update users set password = @password, " +
                    $"name = @name, email = @email where " +
                    $"username = @username;";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", currentUser);
                cmd.Parameters.AddWithValue("@password", newPassword);
                cmd.Parameters.AddWithValue("@name", newName);
                cmd.Parameters.AddWithValue("@email", newEmail);
                //int affectedRows = cmd.ExecuteNonQuery();
                if (cmd.ExecuteNonQuery() > 0)
                {
                    txtLoginUsername.Text = currentUser;
                    MessageBox.Show($"{currentUser}님 수정 되었습니다.");
                }
                else { MessageBox.Show($"수정이 실패했습니다."); }
            }
            catch (Exception ex) { MessageBox.Show($"오류:{ex.Message}"); }
            finally
            {
                conn.Close();
                txtNewPassword.Text = "";
                txtNewName.Text = "";
                txtNewEmail.Text = "";
            }
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            if (currentUser is null) { MessageBox.Show($"먼저 로그인 하세요."); return; }
            DialogResult confirm = MessageBox.Show("정말?", "확인", MessageBoxButtons.YesNo);
            if (confirm == DialogResult.Yes) return;
            try
            {
                conn.Open();
                string query = $"delete from users where username = @username";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", currentUser);
                int affectedRows = cmd.ExecuteNonQuery();
                if (affectedRows > 0)
                {
                    txtLoginUsername.Text = "";
                    MessageBox.Show($"{currentUser}님 탈퇴가 되었습니다.");
                    currentUser = null;
                    lbl_who.Text = $"로그인 하세요.";
                }
                else
                {
                    MessageBox.Show($"탈퇴가 실패했습니다.");
                }

            }
            catch (Exception ex) { MessageBox.Show($"오류:{ex.Message}"); }
            finally
            {
                conn.Close();
            }
        }
    }
}
