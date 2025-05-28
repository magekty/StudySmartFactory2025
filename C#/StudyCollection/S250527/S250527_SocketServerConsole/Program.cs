using System.Collections.Concurrent;
using System.Net;
using System.Net.Sockets;
using System.Reflection.Metadata;
using System.Text;
using System.Threading.Tasks.Dataflow;

namespace S250527_SocketServerConsole
{
    internal class Program
    {
        // connectedClients 새ConcurrentBag<TcpClient> 생성
        static ConcurrentBag<TcpClient> connectedClients = new ConcurrentBag<TcpClient>();
        // async : 비동기 10초, 100초 => 10 + 110 = 120
        // sync : 동기 100초, 10초 => 100 + 110 = 210
        static async Task Main(string[] args)
        {
            Console.WriteLine("서버 시작!");
            // 인터넷 주소: IP주소(컴퓨터 주소) + port주소(앱 주소) 
            TcpListener server = new TcpListener(IPAddress.Any, 9000);  // (로컬주소, 9000포트)
            try
            {
                server.Start(); // 서버 시작
                Console.WriteLine("서버가 실행 됨(포트9000)");
                while (true)    // 서버 시작후 무한루프 대기 상태
                {
                    Console.WriteLine("클라이언트를 기다리고 있습니다.");
                    TcpClient client = await server.AcceptTcpClientAsync(); // 비동기 연결 수행
                    connectedClients.Add(client);   // connectedClients에 client추가
                    Console.WriteLine($"클라이언트에 연결 되었어요 {client.Client.RemoteEndPoint}");
                    HandleClientAsync(client);  // 변수client를 포함한 HandleClientAsync실행
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"서버 오류 발생: {ex.Message}");   // 예외상황 오류메세지 출력
            }
            finally
            {
                server.Stop();  // 예외상황 발생시 server 정지
            }

        }

        static async Task HandleClientAsync(TcpClient client)
        {
            Console.WriteLine("HandleClientAsync 시작");
            NetworkStream stream = null;    // NetworkStream의 stream변수 생성 후 null비워둠
            try
            {
                stream = client.GetStream();    // Stream = 흐름, client의 흐름을 가져와 stream담음
                Console.WriteLine("Stream Ok!");
                byte[] buffer = new byte[1024]; // 버퍼 크기
                int bytesRead;
                while ((bytesRead = await stream.ReadAsync(buffer, 0, buffer.Length)) > 0)
                {
                    string receivedMessage = Encoding.UTF8.GetString(buffer);   // UTF8로 인코딩한문자열
                    Console.WriteLine($"수신내용: {receivedMessage} from {client.Client.RemoteEndPoint}");
                    // Option : broadcast
                    string fullMessage = $"{client.Client.RemoteEndPoint}: {receivedMessage}";
                    await BroadcastMessageAsync(fullMessage);
                    // 나는 빼고 방송해
                    // await BroadcastMessageAsync(fullMessage, excludedClient: client)
                }
                Console.WriteLine($"클라이언트 ({client.Client.RemoteEndPoint}) 연결 종료 됨");

            }
            catch (Exception ex)
            {

                Console.WriteLine($"클라이언트 처리 중 오류: {ex.Message}");   // 예외상황 오류메세지 출력
            }
            finally
            {
                stream?.Close();    // ?조건 연산자는 null이면 함수 호출 그렇지않으면 null값 반환
                client?.Close();
                /*if(client.Client?.RemoteEndPoint == null) Console.WriteLine($"클라이언트 null 반환");
                else Console.WriteLine($"클라이언트 {client.Client.RemoteEndPoint}"); */
            }

        }
        static async Task BroadcastMessageAsync(string message, TcpClient excludedClient = null)
        {
            // www.urlencoder.org/ko
            byte[] messageBytes = Encoding.UTF8.GetBytes(message);
            foreach (TcpClient client in connectedClients.Where(c=>c.Connected && c != excludedClient))
            {
                try
                {
                    NetworkStream stream = client.GetStream();
                    await stream.WriteAsync(messageBytes, 0, messageBytes.Length);
                }
                catch (Exception)
                {
                    throw;
                }
                finally 
                {
                    
                }
            }

        }
    }
}
