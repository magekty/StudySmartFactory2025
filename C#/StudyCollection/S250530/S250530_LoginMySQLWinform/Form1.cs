using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;
using Mysqlx.Crud;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;

namespace S250530_LoginMySQLWinform
{
    public partial class Form1 : Form
    {
        private MySqlConnection conn;
        private string currentUser = null;

        public Form1()
        {
            InitializeComponent();
            conn = new MySqlConnection(
                $"server=localhost;user=root;password=1121;database=user_db");
            lbl_who.Text = $"로그인 하세요";
        }

        private void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtLoginUsername.Text;
            string password = txtLoginPassword.Text;
            try
            {
                conn.Open();
                string query = $"select * from users where " +
                    $"username=@username and password=@password";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@password", password);
                MySqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    currentUser = username;
                    lbl_who.Text = $"{currentUser}님 안녕하세요";
                    MessageBox.Show($"로그인 성공");
                    
                }
                else
                {
                    MessageBox.Show($"로그인 실패, ID/PW를 확인하세요");
                }
                reader.Close();
            }
            catch (Exception ex){ MessageBox.Show($"오류:{ex.Message}"); }
            finally{ 
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
            string regUsername = txtRegUsername.Text;
            string regPassword = txtRegPassword.Text;
            string regName = txtRegName.Text;
            string regEmail = txtRegEmail.Text;

            try
            {
                conn.Open();
                string query = $"insert into users (username, password," +
                    $" name, email) values(@username," +
                    $" @password, @name, @email); ";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", regUsername);
                cmd.Parameters.AddWithValue("@password", regPassword);
                cmd.Parameters.AddWithValue("@name", regName);
                cmd.Parameters.AddWithValue("@email", regEmail);
                //int affectedRows = cmd.ExecuteNonQuery();
                if (cmd.ExecuteNonQuery() > 0)
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
                else{ MessageBox.Show($"수정이 실패했습니다."); }
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
            catch (Exception ex){ MessageBox.Show($"오류:{ex.Message}"); }
            finally
            {
                conn.Close();
            }
        }
    }
}
