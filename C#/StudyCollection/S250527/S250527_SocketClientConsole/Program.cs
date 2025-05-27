using System.Net.Sockets;
using System.Text;

namespace S250527_SocketClientConsole
{
    internal class Program
    {
        static async Task Main(string[] args)
        {
            Console.WriteLine("클라이언트 시작");
            TcpClient client = null;
            NetworkStream stream = null;
            try
            {
                client = new TcpClient();
                Console.WriteLine("서버에 연결 중");
                await client.ConnectAsync("127.0.0.1", 9000);
                Console.WriteLine("서버에 연결 됨");
                stream = client.GetStream();
                Console.WriteLine("스트림 열림");
                ReceiveMessageAsync(stream);
                Console.Write("입력: ");
                while (true)
                {
                    // 사용자 입력 처리 루프 : 내일 오전에 계속
                    string message = Console.ReadLine();
                    //if (string.IsNullOrWhiteSpace(message)) continue;
                    byte[] data = Encoding.UTF8.GetBytes(message);
                    await stream.WriteAsync(data, 0, data.Length);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"오류: {ex.Message}");
            }
            finally
            {
                stream?.Close();
                client?.Close();
                Console.WriteLine("클라이언트 종료");
            }
        }

        static async Task ReceiveMessageAsync(NetworkStream stream)
        {
            byte[] buffer = new byte[1024];
            int bytesRead = 0;
            try
            {
                while (true)
                {
                    // 내일 채울 것
                    if((bytesRead = await stream.ReadAsync(buffer, 0, buffer.Length)) == 17) Console.Write("입력: ");
                    //if(bytesRead == 17) Console.Write("입력: ");
                    if (bytesRead == 17) continue;
                    string received = Encoding.UTF8.GetString(buffer);
                    Console.WriteLine($"[서버] {received}");
                    /*Console.WriteLine($"byte:{bytesRead}");
                    Console.WriteLine($"buffer:{buffer.Length}");*/
                }
            }
            catch (IOException ex)
            {
                Console.WriteLine($"서버 연결 끊김: {ex.Message}");
            }
        }
    }
}
