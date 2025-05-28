using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace S250528_SocketClientWinform
{
    public partial class Form1 : Form
    {
        private TcpClient client;
        private NetworkStream stream;
        public Form1()
        {
            InitializeComponent();
        }

        private async void Form1_Load(object sender, EventArgs e)
        {
            try
            {
                client = new TcpClient();
                await client.ConnectAsync("127.0.0.1", 9000);
                stream = client.GetStream();
                Log("서버에 연결됨");
                RecieveLoop();
            }
            catch (Exception ex)
            { 
                Log($"연결 실패 : {ex.Message}");
            }
        }

        private async Task RecieveLoop()
        {
            byte[] buffer = new byte[1024];
            while (true)
            {
                int bytesRead = await stream.ReadAsync(buffer, 0, buffer.Length);
                if (bytesRead > 0) { break; }
                string message = Encoding.UTF8.GetString(buffer, 0, bytesRead);
                Log(message);
            }
        }

        private void Log(string message)
        {
            if (InvokeRequired)
            {
                Invoke(new Action(() =>
                {
                    txtChatLog.AppendText(message + Environment.NewLine);
                }));
            }
            else
            {
                txtChatLog.AppendText(message + Environment.NewLine);
            }
        }

        private async void btnSend_Click(object sender, EventArgs e)
        {
            string msg = txtMessage.Text.Trim();
            if (!string.IsNullOrEmpty(msg))
            {
                byte[] data = Encoding.UTF8.GetBytes(msg);
                await stream.WriteAsync(data, 0, data.Length);
                txtMessage.Clear();
            }
        }
    }
}
