namespace S250516_01
{
    internal class Program
    {
        static void Main(string[] args)
        {
            // 제어 구조
            // for 풀이법 (초기값 : 반복조건, 반복후작업)
            /*int BMI = 0;
            for (int i = 0; i < 3; i++)    // i:0, 1, 2, 3
            {   // 3번 검사하는 BMI 계산기
                Console.Write("BMI값?(3번만 판별합니다):");
                string sBMI = Console.ReadLine();
                BMI = int.Parse(sBMI);
                if (0 > BMI) { Console.WriteLine("Bye"); }
                else if (BMI < 20) { Console.WriteLine("저체중"); }
                else if (20 <= BMI && BMI < 25) { Console.WriteLine("정상"); }
                else if (25 <= BMI && BMI < 30) { Console.WriteLine("경도비만"); }
                else if (30 <= BMI && BMI < 40) { Console.WriteLine("비만"); }
                else { Console.WriteLine("고도비만"); }
            }*/

            // while, for, do while, foreach
            /*int a = 1; int sum = 0;
            while (a <= 3)  //while문으로 1 to 3 누적합 계산
                sum += a++;
            Console.WriteLine($"1 to 3 누적합은 {sum}이다.");

            sum = 0;
            for (int num = 1; num <= 3; num++)    //for문으로 1 to 3 누적합 계산
                sum += num;
            Console.WriteLine($"1 to 3 누적합은 {sum}이다.");

            int b = 0; sum = 0;
            do  //for문으로 1 to 3 누적합 계산
                sum += b++;
            while (b <= 3);
            Console.WriteLine($"1 to 3 누적합은 {sum}이다.");

            int[] array = { 10, 20, 30, 40 }; sum = 0;
            //for (int i2 = 0; i2 <= 3; i2++)
            //    sum += arrays[i2];
            foreach (int num in array)
                sum += num;
            Console.WriteLine($"10 to 40 누적합은 {sum}이다.");*/

            // 합: 일반적인 대응이 가능하다
            // if, case 0:월, 1:화, 2:수, 3:목, 4:금
            /*for (int 요일 = 0; 요일 <= 6; 요일++)
            {
                switch (요일)
                {
                    case 0: Console.WriteLine("월요병 앓는 중"); break;
                    case 1: Console.WriteLine("화요일 화가 난다"); break;
                    case 2: Console.WriteLine("수요일 수심이 가득"); break;
                    case 3: Console.WriteLine("목요일 지친다"); break;
                    case 4: Console.WriteLine("금요일 이제 주말이다"); break;
                    case 5: break;
                    case 6: Console.WriteLine("토일 주말이다"); break;
                }
            }
            Console.WriteLine();
            for (int 요일 = 0; 요일 <= 6; 요일++)
            {
                if (요일 == 0) { Console.WriteLine("월요병 앓는 중"); }
                else if (요일 == 1) { Console.WriteLine("화요일 화가 난다"); }
                else if (요일 == 2) { Console.WriteLine("수요일 수심이 가득"); }
                else if (요일 == 3) { Console.WriteLine("목요일 지친다"); }
                else if (요일 == 4) { Console.WriteLine("금요일 이제 주말이다"); }
                else if (요일 == 5 || 요일 == 6) { Console.WriteLine("토일 주말이다"); }
            }*/

            // for while을 이용한 2~9단곱셈결과
            /*// 2단 : 2(단) * 1(곱) = 2
            // 3단 : 3     * 1
            //       3     * 2
            // 단 : 2단 ~ 9단
            // 곱 : 1 ~ 9
            for (int 단 = 2; 단 <= 9; 단++)
            {
                Console.WriteLine($"---- {단}단 시작 ----");
                for (int 곱 = 1; 곱 <= 9; 곱++)
                {
                    Console.WriteLine($"{단} * {곱} = {단 * 곱}");
                }
            }

            //int 와일단 = 2;
            //int 와일곱 = 1;

            //while (와일단 <= 9)
            //{
            //    if (와일곱 == 1 || 와일곱 > 9)
            //    {
            //        Console.WriteLine($"---- {와일단}단 시작 ----");
            //        와일곱 = 1;
            //    }
            //    if (와일단 <= 9 || 와일곱 <= 9)
            //    {
            //        Console.WriteLine($"{와일단} * {와일곱} = {와일단 * 와일곱}");
            //        와일곱++;
            //    }
            //    if (와일곱 > 9)
            //        와일단++;
            //}

            int 와일단 = 2;
            int 와일곱 = 1;

            while (와일단 <= 9)
            {
                Console.WriteLine($"---- {와일단}단 시작 ----");
                while (와일곱 <= 9)
                {
                    Console.WriteLine($"{와일단} * {와일곱} = {와일단 * 와일곱}");
                    와일곱++;
                }
                와일단++;
                와일곱 = 1;
            }*/

            // continue, break
            /*int c = 0;
            while (true)
            {
                if (c == 10) break;
                c++;
                if (c % 2 == 0) continue;
                Console.Write(c);
            }
            c = 0;
            while (c < 10)
            {
                if (c % 2 != 0) Console.Write(c); 
                c++;
                
            }*/

            // 최대 최소 평균 구하기 
            /*double min = double.MaxValue;
            double max = double.MinValue;
            double sum = 0;

            for (int i = 0; i < 5; i++)
            {
                Console.Write("너의 점수는? ");
                double score = double.Parse(Console.ReadLine());

                if (score > max)
                {
                    max = score;
                }
                if (score < min)
                {
                    min = score;
                }
                sum += score;
            }
            Console.WriteLine($"max: {max} min: {min} avg: {sum / 5}");*/

            // 반복문 곱셈
            /*//int x = 2;
            //int y = 3;
            //int pow = 1;
            //for (int y_i = 0; y_i < y; y_i++)
            //{
            //    pow *= x;
            //}
            //Console.WriteLine($"{x}의 {y}제곱은 {pow}");*/

            // p148 반복문 !
            // p241 재귀함수(재귀메소드)
            /*// 팩토리얼!
            int fact = 1;
            for (int i = 2; i <= 5; i++)    // i : 2, 3, 4, 5
                fact *= i;
            Console.WriteLine($"5! = {fact} - 반복문");
            Console.WriteLine($"5! = {Fact(5)} - 함수");*/

            // 이중 for문으로 피라미드 만들기
            /*// 1번 피라미드
            // *        1,1
            // **       2,2
            // ***      3,3
            // ****     4,4
            // *****    5,5
            for (int 행=1; 행<=5; 행++)
            {
                for (int 열=1; 열 <=5; 열++)
                {
                   if(행 == 열)
                   {
                        Console.Write("*");
                        break;
                   }
                   else Console.Write("*");
                }
                Console.WriteLine();
            }
            Console.WriteLine();

            // 2번 피라미드
            // *********    9,1
            // *******     7,2
            // *****      5,3
            // ***       3,4
            // *        1,5
            for (int 행 = 1; 행 <= 5; 행++)
            {
                for (int 열 = 1; 열 <= 2 * 행 - 1; 열++)
                {
                        Console.Write("*");
                }
                Console.WriteLine();
            }
            Console.WriteLine();

            // 3번 피라미드
            // *****    5,5
            // ****     4,4
            // ***      3,3
            // **       2,2
            // *        1,1
            for (int 행=1; 행<=5; 행++)
            {
                for (int 열 = 5-행+1; 열 >= 1; 열--)
                {
                    Console.Write("*");
                }
                Console.WriteLine();
            }

            // 4번 피라미드
            // ssss*        1,1
            // sss**       2,2
            // ss***      3,3
            // s****     4,4
            // *****    5,5
            for (int 행 = 1; 행 <= 5; 행++)
            {
                for (int 열 = 5-행; 열>0; 열--) Console.Write("s");
                for (int 열 = 0; 열 < 행; 열++) Console.Write("*"); 
                Console.WriteLine();
            }*/

            // 배열 초기화
            /*int[] a = { 1, 2, 3 };
            int[] b = new int[] { 1, 2, 3 };
            int[] c = new int[3] { 1, 2, 3 };
            int[] d = new int[3];
            d[0] = 1;
            d[1] = 2;
            d[2] = 3;
            Console.WriteLine($"{a[0]} {a[1]} {a[2]}");
            Console.WriteLine($"{b[0]} {b[1]} {b[2]}");
            Console.WriteLine($"{c[0]} {c[1]} {c[2]}");
            Console.WriteLine($"{d[0]} {d[1]} {d[2]}");*/

            // 배열 복사 - Clone, Array.Copy, CopyTo, Sort, Reverse, Clear
            /*int aa = 1;
            int bb = aa;
            Console.WriteLine(aa);
            Console.WriteLine(bb);
            aa = 2;
            Console.WriteLine(aa);
            Console.WriteLine(bb);

            int[] a = { 5, 25, 75, 35, 15 };
            PrintArray(a);
            int[] b = a;
            PrintArray(b);
            a[0] = 50;
            PrintArray(a);
            PrintArray(b);

            int[] c = (int[])a.Clone(); // a.Clone()는 Object 타입 반환
            PrintArray(c);
            a[0] = 500;
            PrintArray(c);

            int[] d = new int[10];
            Array.Copy(a, 0, d, 1, 3);
            PrintArray(a);
            PrintArray(d);

            a.CopyTo(d, 3);
            PrintArray(d);

            Array.Sort(a);
            PrintArray(a);

            Array.Reverse(a);
            PrintArray(a);

            Array.Clear(a, 1, a.Length/2);
            PrintArray(a);

            Array.Clear(a);
            PrintArray(a);*/

            // 다차원 배열
            /*// 2차원 배열: 직사각형, 정사각형
            int[,] a = new int[2, 3] { { 1, 2, 3 }, { 4, 5, 6 } };
            for (int i_x = 0; i_x < 2; i_x++)
            {
                for (int i_y = 0; i_y < 3; i_y++)
                {
                    Console.Write($"{a[i_x, i_y]}");
                }
                Console.WriteLine();
            }
            Console.WriteLine();

            // 2차원 가변 배열
            // 1 2
            // 3 4 5
            int[][] b = new int[2][];       // 비워두는 건 못 정하니까
            b[0] = new int[] { 1, 2 };      // 2개 짜리
            b[1] = new int[] { 3, 4, 5 };   // 3개 짜리
            for (int i_x = 0; i_x < 2; i_x++)
            {
                for (int i_y = 0; i_y < b[i_x].Length; i_y++)
                {
                    Console.Write($"{b[i_x][i_y]}");
                }
                Console.WriteLine();
            }*/

            // Random 클래스
            Random r = new Random();
            Console.WriteLine(r.Next());
            Console.WriteLine(r.Next());
            Console.WriteLine(r.NextDouble());
            Console.WriteLine(r.NextDouble());

            int ranNum = r.Next();
            int computer = ranNum % 3;

            int[] myWin = new int[] { 0, 0, 0 };
            for (int i = 0; i < myWin.Length; i++)
            {
                Console.WriteLine("가위 0, 바위 1, 보 2? 숫자로 대답하세요");
                string sInput = Console.ReadLine();
                int nInput = int.Parse(sInput);
                // 내가 이기는 경우
                // 나 가위0-컴보2, 나바위1-컴가위0, 나보2- 컴바위1
                if ((nInput == 0 && computer == 2) || 
                    (nInput == 1 && computer == 0) || 
                    (nInput == 2 && computer == 1))
                {
                    myWin[i] = 1;
                }

                
                        Console.WriteLine($"{myWin[0]}{myWin[1]}{myWin[2]}");
            }

}
        private static void PrintArray(int[] arr)
        {
            foreach (int num in arr)
            {
                Console.Write(num); Console.Write(" ");
            }
            Console.WriteLine();
        }
        // 5! = 5 * 4!
        //          4! = 4 * 3!
        //                   3! = 3 * 2!
        //                            2! = 2 * 1
        private static double Fact(double x)
        {
            if (x == 1) return x;
            return x * Fact(x - 1);
        }

    }
}
