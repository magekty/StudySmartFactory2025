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
                    string message = Console.ReadLine();    // 콘솔 입력값 받기
                    //if (string.IsNullOrWhiteSpace(message)) continue;
                    byte[] data = Encoding.UTF8.GetBytes(message);  // 입력값을 Byte배열로 인코딩
                    await stream.WriteAsync(data, 0, data.Length);    // stream에 비동기쓰기(쓰기값,시작,끝)
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
            int bufferLength = 1024;
            byte[] buffer = new byte[bufferLength];
            int bytesRead = 0;
            try
            {
                while (true)
                {
                    // 내일 채울 것
                    // 버퍼에서읽은Bytes의총량= 비동기읽기(읽고담을변수,시작,끝) 
                    if ((bytesRead = await stream.ReadAsync(buffer, 0, buffer.Length)) != bufferLength) 
                        Console.Write("입력: ");
                    if (bytesRead != bufferLength) continue;    // 버퍼Bytes의총량이 버퍼최대 길이와 다를때
                    string received = Encoding.UTF8.GetString(buffer);  // 버퍼값을 문자열로 인코딩
                    int origRow = Console.CursorTop;    // 현재 커서 Y축(행) 위치값 반환
                    int origCol = Console.CursorLeft;    // 현재 커서 X축(열) 위치값 반환
                    Console.SetCursorPosition(0, origRow);  // 콘솔 창에서 다음 쓰기 작업을 시작할 위치를 지정
                    Console.WriteLine($"[서버] {received}");
                }
            }
            catch (IOException ex)
            {
                Console.WriteLine($"서버 연결 끊김: {ex.Message}");
            }
        }
    }
}
