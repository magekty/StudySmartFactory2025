namespace S050514_01
{
    internal class Program
    {
        static void Main(string[] args)
        {
            //출력 및 입력
            /*Console.Write("Hello, World!ㅋㅋ");
            Console.Write("Hello, World!ㅋㅋ");
            Console.WriteLine("Hello, World!ㅋㅋ");
            Console.WriteLine("Hello, World!ㅋㅋ");

            Console.WriteLine("가위 바위 보 중 아무거나 입력하세요");
            string var = Console.ReadLine();
            Console.Write(var);
            Console.WriteLine("를 내셨네요");*/

            //문자열 문자배열
            /*string str = "test";
            Console.WriteLine(str[0]);
            Console.WriteLine(str[1]);
            Console.WriteLine(str[2]);
            Console.WriteLine(str[3]);
            //Console.WriteLine(str[4]);
            Console.WriteLine("학생표");
            Console.WriteLine("학생표\n");
            Console.WriteLine("내용");

            Console.WriteLine("이름\t학년");
            Console.WriteLine("\"서호준\"\t1");*/

            //Bool 자료형(true, false)
            /*string A = "김태영";
            string B = "서호준";
            Console.WriteLine(A == B);*/

            //입력값 연속 출력
            /*Console.Write("이름은?");
            string name =Console.ReadLine();
            Console.Write("학년은?");
            string grade = Console.ReadLine();
            Console.WriteLine("안녕하세요 {0}학년 {1}님 어서오세요", grade, name);*/

            //문자열 여러 표현
            /*int a = 10;
            float b = 20;
            //Console.WriteLine(a, b);
            //Console.WriteLine("서", "호준");
            Console.WriteLine("서"+ "호준");
            Console.WriteLine(a + b);
            Console.WriteLine(a.ToString() + " " + b.ToString());
            Console.WriteLine("a : " + a.ToString() + ", b : " + b.ToString());
            Console.WriteLine("a : {0}, b : {1}", a, b);
            Console.WriteLine($"a : {a}, b : {b}");*/

            //형식지정자
            /*Console.WriteLine("(C) Currency: {0:C}", -12345678);

            string s = string.Format("{0:C}", -12345678);
            Console.WriteLine(s);*/

            //소수 표기
            /*float fNum = 1f / 3;
            double doNum = 1d / 3;
            decimal dNum = 1m / 3;
            Console.WriteLine(fNum);
            Console.WriteLine(doNum);
            Console.WriteLine(dNum);*/

            //형변환
            /*double x = 1234.5;
            int a;
            a = (int)x;
            Console.WriteLine(a);

            int b = 1234;
            long big = b;
            Console.WriteLine(big);

            string d = "1234.5678";
            double c = Double.Parse(d);
            Console.WriteLine(c);
            string e = "1234";
            int f = int.Parse(e);
            Console.WriteLine($"\n{f}");
            string sstring = f.ToString();*/

            //연산자 종류
            //산술연산자 + - * / %
            /*int a = 1;
            Console.WriteLine(a % 3); a = a + 1;
            Console.WriteLine(a % 3); a = a + 1;
            Console.WriteLine(a % 3); a = a + 1;
            Console.WriteLine(a % 3); a = a + 1;
            Console.WriteLine(a % 3); a = a + 1;
            Console.WriteLine(a % 3); a = a + 1;
            Console.WriteLine(a % 3); a = a + 1;
            Console.WriteLine(a % 3); a = a + 1;

            Console.WriteLine($"a: {a}, {a % 3}"); a = a + 1;
            Console.WriteLine($"a: {a}, {a % 3}"); a = a + 1;
            Console.WriteLine($"a: {a}, {a % 3}"); a = a + 1;
            Console.WriteLine($"a: {a}, {a % 3}"); a = a + 1;
            Console.WriteLine($"a: {a}, {a % 3}"); a = a + 1;
            Console.WriteLine($"a: {a}, {a % 3}"); a = a + 1;
            Console.WriteLine($"a: {a}, {a % 3}"); a = a + 1;
            Console.WriteLine($"a: {a}, {a % 3}"); a = a + 1;*/

            // 논리 연산자 (그리고AND, 또는OR, 배타적XOR, 반전NOT), 관계 연산자(==, >=, <=, >, <, !=)
            /*//AND연산자, &&코드, 그리고
            Console.WriteLine(true);
            Console.WriteLine($"{false}\n");
            int hours_today = 0;
            bool understand = false;
            Console.WriteLine(hours_today >= 8 && understand);
            hours_today = 8;
            Console.WriteLine(hours_today >= 8 && understand);
            understand = true;
            Console.WriteLine(hours_today >= 8 && understand);
            Console.WriteLine();

            //OR연산자, ||코드, 또는
            hours_today = 0;
            understand = false;
            Console.WriteLine(hours_today >= 8 || understand);
            hours_today = 8;
            Console.WriteLine(hours_today >= 8 || understand);
            understand = true;
            Console.WriteLine(hours_today >= 8 || understand);
            Console.WriteLine();

            //XOR연산자, ^코드, 배타적
            hours_today = 0;
            understand = false;
            Console.WriteLine($"hours_today:{hours_today},understand:{understand}," +
                $"{hours_today >= 8 ^ understand}");
            hours_today = 8;
            Console.WriteLine($"hours_today:{hours_today},understand:{understand}," +
                $"{hours_today >= 8 ^ understand}");
            understand = true;
            Console.WriteLine($"hours_today:{hours_today},understand:{understand}," +
                $"{hours_today >= 8 ^ understand}");
            Console.WriteLine();

            //NOT연산자, !코드, 반전
            Console.WriteLine(!true);
            Console.WriteLine(!false);*/

            // 조건 연산자(조건?참:거짓, if, 삼항연산자)
            /*int point = 90;
            Console.WriteLine("{0}점은 {1}입니다.", point, (point >= 60) ? "pass" : "fail");
            point = 50;
            Console.WriteLine("{0}점은 {1}입니다.", point, (point >= 60) ? "pass" : "fail");*/

            //증가연산자(++a - 전위연산, a-- 후위연산), 감소연산자(--), 대입연산자의 압축(+=, -=, *=등)
            /*int a = 0;
            a = a + 1; Console.WriteLine(a);
            a += 1; Console.WriteLine(a);
            a = ++a; Console.WriteLine(a);
            a = a++; Console.WriteLine(a);
            Console.WriteLine();

            a *= 10; Console.WriteLine(a);
            a--; Console.WriteLine(a);
            --a; Console.WriteLine(a);
            Console.WriteLine();

            Console.WriteLine(a++);
            Console.WriteLine(++a);*/

            // string class 
            string s = "hello world";
            string money1 = "123000";
            string money2 = "81230";
            string t;
            Console.WriteLine(s.Length);
            Console.WriteLine(s[8]);
            Console.WriteLine(s.Insert(6, "C# "));
            Console.WriteLine(money1);
            Console.WriteLine(money2);
            Console.WriteLine(money1.PadLeft(20, ' '));
            Console.WriteLine(money2.PadLeft(20, ' '));
            Console.WriteLine(s.Remove(4));
            Console.WriteLine(s.Remove(6, 3));
            Console.WriteLine(s.Replace('l', 'm'));
            Console.WriteLine();
            s = "\nhello world!\n";
            Console.WriteLine(s);
            Console.WriteLine(s.Trim());
            Console.WriteLine(s.TrimStart());
            Console.WriteLine(s.TrimEnd());
            s = "010-1234-5678";
            string[] phoneNums = s.Split('-');
            Console.WriteLine(phoneNums[0]);
            Console.WriteLine(phoneNums[1]);
            Console.WriteLine(phoneNums[2]);
            string s2 = String.Join("-", phoneNums);
            Console.WriteLine(s2);


        }
    }
}
