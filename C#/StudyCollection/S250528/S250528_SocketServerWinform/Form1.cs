using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Net.Sockets;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Net;
using System.IO;

namespace S250528_SocketServerWinform
{
    public partial class Form1 : Form
    {
        private TcpListener server;
        private ConcurrentDictionary<string, TcpClient> clients = new ConcurrentDictionary<string, TcpClient>();

        public Form1()
        {
            InitializeComponent();
        }

        private async void btnStart_Click(object sender, EventArgs e)
        {
            server = new TcpListener(IPAddress.Any, 9000);
            server.Start();
            Log("서버가 시작됨(포트 9000)");
            while (true)
            {
                TcpClient client = await server.AcceptTcpClientAsync();
                string endpoint = client.Client.RemoteEndPoint.ToString();
                if (clients.TryAdd(endpoint, client))
                {
                    AddClientToList(endpoint);
                    Log($"{endpoint}가 연결됨");
                    HandleClientAsync(client, endpoint);
                }
            }

        }
        private void AddClientToList(string endpoint)
        {
            // Thread 관련
            if (InvokeRequired)
            {
                Invoke(new Action(() =>
                {
                    lstClients.Items.Add(endpoint);
                }));
            }
            else
            {
                lstClients.Items.Add(endpoint);
            }
        }

        private async Task HandleClientAsync(TcpClient client, string endpoint)
        {
            NetworkStream stream = client.GetStream();
            byte[] buffer = new byte[1024];
            int bytesRead;
            try
            {
                while ((bytesRead = await stream.ReadAsync(buffer, 0, buffer.Length)) > 0)
                {
                    string receivedMessage = Encoding.UTF8.GetString(buffer, 0, bytesRead);
                    Log($"{endpoint} : {receivedMessage}");
                    //option : broadcast
                    string fullMessage = $"{endpoint}: {receivedMessage}";
                    //다 방송해
                    //await BroadcastMessageAsync(fullMessage);
                    //나는 빼고 방송해
                    await BroadcastMessageAsync(fullMessage, excludedClient: client);
                }
            }
            catch (Exception ex)
            {
                Log($"{endpoint}가 오류남: {ex.Message}");
            }
            finally
            {
                RemoveClient(endpoint); // stream?.Close();
                client?.Close();
                Log($"연결 종료");
            }
        }
        private void RemoveClient(string endpoint)
        {
            if (InvokeRequired)
            {
                Invoke(new Action(() =>
                {
                    lstClients.Items.Remove(endpoint);
                }));
            }
            else
            {
                lstClients.Items.Remove(endpoint);
            }
        }

        private async Task BroadcastMessageAsync(string message, TcpClient excludedClient = null)
        {
            byte[] messageBytes = Encoding.UTF8.GetBytes(message);
            foreach (KeyValuePair<string, TcpClient> pair in clients)
            {
                if (pair.Value != excludedClient && pair.Value.Connected)
                {
                    try
                    {
                        NetworkStream stream = pair.Value.GetStream();
                        await stream.WriteAsync(messageBytes, 0, messageBytes.Length);
                    }
                    catch (Exception)
                    {

                    }
                }
            }

        }
        private void Log(string message)
        {
            if (InvokeRequired)
            {
                Invoke(new Action(() =>
                {
                    txtLog.AppendText(message + Environment.NewLine);
                }));
            }
            else
            {
                txtLog.AppendText(message + Environment.NewLine);
            }
        }
    }
}
