using System.Diagnostics;
using System.Drawing;
using System.Text;
using static System.Runtime.InteropServices.JavaScript.JSType;


namespace S050515_1
{
    internal class Program
    {
        enum Size { Short, Tall, Grande, Venti };
        static void Main(string[] args)
        {
            // 문자열,문자열 배열 가공 Substring, IndexOf, LastIndexOf, Pars
            /*string s = "010-1234-5678";
            char[] destination = new char[10];
            s.CopyTo(8, destination, 0, 4);
            Console.WriteLine(destination); // destination -567

            string s_sub = s.Substring(8);
            Console.WriteLine(s_sub);   // s_sub -5678
            s_sub = s.Substring(8, 2);
            Console.WriteLine(s_sub);   // s_sub -5
            int i_start = s.IndexOf("0");
            Console.WriteLine(i_start); // i_start 0
            int i_last = s.LastIndexOf("0");
            Console.WriteLine(i_last);  // i_last 2
            string first_num = s.Substring(i_start, i_last - i_start + 1);
            Console.WriteLine(first_num);   // first_num 0-
            Console.WriteLine(s.Contains("7")); // s.Contains("7") true

            Console.WriteLine("더하고 싶은 숫자들을 입력해요:");
            string num_in = Console.ReadLine();
            Console.WriteLine(num_in);  // 입력 값과 동일 출력
            string[] s_nums = num_in.Split();
            Console.WriteLine(s_nums[0]);   // 입력 값의 1번째 문자
            Console.WriteLine(s_nums[1]);   // 입력 값의 2번째 문자
            Console.WriteLine(s_nums[2]);   // 입력 값의 3번째 문자
            int sum = 0;
            sum = int.Parse(s_nums[0]) + int.Parse(s_nums[1]) + int.Parse(s_nums[2]);
            Console.WriteLine(sum); // 입력값 1 2 3 일경우 6*/

            // String.Format, DateTime.Now, TimeSpan
            /*string max = String.Format("{0:X} {0:E} {0:N}", Int64.MaxValue);
            Console.WriteLine(max);

            Decimal exchangeRate = 1129.20m;
            Console.WriteLine("현재 원달러 환율은 {0}이다", exchangeRate);
            Console.WriteLine("현재 원달러 환율은 {0:C1}이다", exchangeRate);

            Console.WriteLine("오늘 날짜는 {0:d}, 시간은 {0:t}입니다", DateTime.Now);

            TimeSpan duration = new TimeSpan(1, 12, 23, 62);    //1d 12h 23m 62s
            Console.WriteLine("시간 {0:c}", duration);*/

            //StringBuilder클래스 clear, append, insert, remove, replace
            /*//string name = "서호준";
            //name[0] = "김"; // 불변 immutable
            //string name2 = "김호준";

            StringBuilder sb = new StringBuilder("This is a stringbuilder test");
            Console.WriteLine("{0}는 {1}개 글자입니다", sb.ToString(), sb.Length);
            sb.Clear();
            Console.WriteLine("{0}는 {1}개 글자입니다", sb.ToString(), sb.Length);
            sb.Append("ㅋ");
            Console.WriteLine(sb.ToString());
            sb.Append("ㅋ");
            Console.WriteLine(sb.ToString());
            sb.Insert(1, "ㅎ", 2); // ㅋㅎㅎㅋ 1번 위치 ㅎ 2번
            Console.WriteLine(sb.ToString());
            sb.Remove(1, 2);    // 1번 위치 2번 지우기
            Console.WriteLine(sb.ToString());   // ㅋㅋ
            sb.Append("ㄷㄷ");
            Console.WriteLine(sb.ToString());   // ㅋㅋㄷㄷ
            sb.Replace("ㅋㄷ", "ㅎㅎ");
            Console.Write(sb.ToString());   // ㅋㅎㅎㅋ*/

            //Stopwatch 
            /*Stopwatch time = new Stopwatch();
            time.Start();
            for (long i = 0; i < 10000; i++)
            { }
            time.Stop();
            Console.WriteLine(time.ElapsedMilliseconds + "ms");
            time.Reset();

            string test = string.Empty;
            time.Start();
            for (long i = 0; i < 100000; i++)
            {
                test += i;
            }
            Console.WriteLine(time.ElapsedMilliseconds + "ms");
            //Console.WriteLine(test);
            time.Reset();

            StringBuilder testsb = new StringBuilder();
            time.Start();
            for (long j = 0; j < 10000; j++)
            {
                testsb.Append(j);
            }
            time.Stop();
            Console.WriteLine(time.ElapsedMilliseconds + "ms");
            //Console.WriteLine(testsb);
            time.Reset();*/

            //enum
            /*// enum Size { Short, Tall, Grande, Venti };
            for (int i = 0; i < 4; i++)
            {
                if (i == 0)
                {
                    Console.WriteLine("숏 사이즈");
                }
                else if (i == 1)
                {
                    Console.WriteLine("톨 사이즈");
                }
                else if (i == 2)
                {
                    Console.WriteLine("그랑데 사이즈");
                }
                else if (i == 3)
                {
                    Console.WriteLine("벤티 사이즈");
                }
            }
            Console.WriteLine(); // 줄바꿈
            for (int i = 0; i < 4; i++)
            {   // if (i == "Short"){ Console.WriteLine("숏 사이즈"); } // 오래 걸린다.
                if (i == (int)Size.Short)
                {
                    Console.WriteLine("숏 사이즈");
                }
                else if (i == (int)Size.Grande)
                {
                    Console.WriteLine("톨 사이즈");
                }
                else if (i == (int)Size.Tall)
                {
                    Console.WriteLine("그랑데 사이즈");
                }
                else if (i == (int)Size.Venti)
                {
                    Console.WriteLine("벤티 사이즈");
                }
            }*/

            //Class, const, readonly
            /*Console.WriteLine(ConstEx.number);
            ReadOnlyEx inst1 = new ReadOnlyEx();
            Console.WriteLine(inst1.number);
            ReadOnlyEx inst2 = new ReadOnlyEx(100);
            Console.WriteLine(inst2.number);*/

            //제어 구조
            /*// 1. 조건문(분기: 여러 경우로 생각을 확장하기)
            // BMI < 20 : 저체중, 20 <= BMI < 25 : 정상,
            // 25 <= BMI < 30 : 경도비만, 30 <= BMI < 40 : 비만,
            // 40 <= BMI : 고도비만

            Console.Write("BMI를 입력하세요. \t");
            string inputV = Console.ReadLine();
            int BMI = 0;
            if (int.TryParse(inputV, out BMI))
            {
                if (BMI < 20) { Console.WriteLine("저체중"); }
                else if (20 <= BMI && BMI < 25) { Console.WriteLine("정상"); }
                else if (25 <= BMI && BMI < 30) { Console.WriteLine("경도비만"); }
                else if (30 <= BMI && BMI < 40) { Console.WriteLine("비만"); }
                else { Console.WriteLine("고도비만"); }
            }
            else { Console.WriteLine("정수가 아닙니다."); }*/

            // 2. 반복문(정해진 로직을 반복 수행)
            // while, do while, for, foreach
            int BMI = 0;
            while (BMI >= 0) 
            {
                Console.Write("BMI값?(종료하려면 음수입력):");
                string sBMI = Console.ReadLine();
                BMI = int.Parse(sBMI);
                if (0 > BMI) { Console.WriteLine("Bye"); }
                else if (BMI < 20) { Console.WriteLine("저체중"); }
                else if (20 <= BMI && BMI < 25) { Console.WriteLine("정상"); }
                else if (25 <= BMI && BMI < 30) { Console.WriteLine("경도비만"); }
                else if (30 <= BMI && BMI < 40) { Console.WriteLine("비만"); }
                else { Console.WriteLine("고도비만"); }
            }

        }
    }

    class ConstEx
    {
        // public : class외부에서 보임, const: 상수, 값 타입에만 적용, 변수 선언 동시에 초기화 필수, Stack
        public const int number = 3;
    }

    class ReadOnlyEx
    {
        // readonly: 참조타입, 모든자료형에 사용 가능, 생성과 동시 초기화 불필요, Heap
        public readonly int number = 10;
        public ReadOnlyEx() { number = 20; } //생성자 - 함수와 클래스가 이름이 같다, return type이 없다
        public ReadOnlyEx(int n) { number = n; }
    }
}
