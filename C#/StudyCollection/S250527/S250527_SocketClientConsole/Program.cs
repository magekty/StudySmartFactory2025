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
                //Console.Write("입력: ");
                while (true)
                {
                    // 사용자 입력 처리 루프 : 서버에게 보낼 메세지 처리
                    Console.Write("하고 싶은말 입력(종료하려면 exit 입력)");
                    string messageToSend = Console.ReadLine();
                    if (messageToSend == "exit")
                    {
                        Console.WriteLine("클라이언트를 종료합니다.");
                        break;
                    }
                    if (string.IsNullOrEmpty(messageToSend))
                    {
                        Console.WriteLine("메세지를 다시 입력하세요");
                        continue;
                    }
                    // 서버로 전송
                    byte[] data = Encoding.UTF8.GetBytes(messageToSend);
                    await stream.WriteAsync(data, 0, data.Length);
                    Console.WriteLine("메세지가 서버로 잘 갔어요");


                    /*// 개인 코드
                    string message = Console.ReadLine();    // 콘솔 입력값 받기
                    //if (string.IsNullOrWhiteSpace(message)) continue;
                    byte[] data = Encoding.UTF8.GetBytes(message);  // 입력값을 Byte배열로 인코딩
                    await stream.WriteAsync(data, 0, data.Length);    // stream에 비동기쓰기(쓰기값,시작,끝)*/
                }
            }
            catch (SocketException ex) 
            {
                Console.WriteLine($"소켓 오류: {ex.Message}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"일반 오류: {ex.Message}");
            }
            finally
            {
                stream?.Close();
                client?.Close();
                Console.WriteLine("클라이언트 종료");
            }
        }
        // 서버로부터 메세지를 수신하는 메소드(함수)
        static async Task ReceiveMessageAsync(NetworkStream stream)
        {
            int bufferCnt = 1024;
            byte[] buffer = new byte[bufferCnt];
            //int bytesRead = 0;
            try
            {
                while (true)
                {
                    // 내일 채울 것
                    int bytesRead = await stream.ReadAsync(buffer, 0, buffer.Length);
                    if (bytesRead == 0)
                    {
                        Console.WriteLine("서버가 연결을 닫았습니다.");
                        break;
                    }
                    string receivedMessage = Encoding.UTF8.GetString(buffer, 0, bytesRead);
                    Console.WriteLine($"수신: {receivedMessage}");
                    // 개인 코드
                    /*// 버퍼에서읽은Bytes의총량= 비동기읽기(읽고담을변수,시작,끝) 
                    if ((bytesRead = await stream.ReadAsync(buffer, 0, buffer.Length)) != bufferCnt)
                        Console.Write("입력: ");
                    if (bytesRead != bufferCnt) continue;    // 버퍼Bytes의총량이 버퍼최대 길이와 다를때
                    string received = Encoding.UTF8.GetString(buffer);  // 버퍼값을 문자열로 인코딩
                    int origRow = Console.CursorTop;    // 현재 커서 Y축(행) 위치값 반환
                    int origCol = Console.CursorLeft;    // 현재 커서 X축(열) 위치값 반환
                    Console.SetCursorPosition(0, origRow);  // 콘솔 창에서 다음 쓰기 작업을 시작할 위치를 지정
                    Console.WriteLine($"[서버] {received}");*/
                }
            }
            catch (IOException ex)
            {
                Console.WriteLine($"서버 연결 끊김: {ex.Message}");
            }
        }
    }
}
