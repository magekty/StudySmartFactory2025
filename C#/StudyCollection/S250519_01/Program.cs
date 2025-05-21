using System.Runtime.InteropServices;
using Microsoft.VisualBasic;

namespace S250519_01
{
    //Class, Struct
    struct DateStruct
    {
        public int year;
        public int month;
        public int day;
    }
    class DateClass
    {
        public int year;
        public int month;
        public int day;
    }
    class DateClass2
    {
        public int year;
        public int month;
        public int day;

        public DateClass2()
        { 
            year = 3024; month = 5; day = 19;
        }
        public void Print()
        {
            Console.WriteLine($"{year}-{month}-{day}");
        }
    }
    class Car
    {
        int speed;
        public Car() { speed = 0; }
        public void SpeedUp() { speed += 10; }
        public static void BBangBBang() { Console.WriteLine("빵빵!"); }
    }
    class Rectangle
    {
        private double width;
        private double height;
        public double GetWidth() { return this.width; }
        public void SetWidth(double width) { this.width = width; }
        // 옛날 스타일 Setter
        /*public void SetWidth(double width)
        {
            if(width > 0)
            {
                this.width  = width;
            }
        }*/
        public double GetHeight() { return this.height; }
        public void SetHeight(double height) { this.height = height; }
    }
    class RectangleOld
    {
        public double width;
    }
    class RectanglePropertyVer
    {
        public double width {
            get { return width; }
            set { if (value > 0) width = value; } 
        }
    }
    class Weekdays
    {
        private string[] days = { "월", "화", "수", "목", "금", "토", "일" };
        public string this[int index]
        {
            get { return days[index]; }
            set { days[index] = value; }
        }
        public int Length => days.Length;
        // public int Length { get { return days.Length; } };
    }

    internal class Program
    {
        static void Main(string[] args)
        {
            // struct - 값타입, class - 참조타입
            /*DateStruct sDay;
            sDay.year = 2024;sDay.month = 5; sDay.day = 19;
            Console.WriteLine($"{sDay.year}-{sDay.month}-{sDay.day}");

            DateClass cDay = new DateClass();
            cDay.year = 2024; cDay.month = 5; cDay.day = 19;
            Console.WriteLine($"{cDay.year}-{cDay.month}-{cDay.day}");
            Console.WriteLine();

            DateStruct sDay2;
            sDay2 = sDay;
            Console.WriteLine($"{sDay2.year}-{sDay2.month}-{sDay2.day}");
            sDay2.year = 2025;
            // struct는 값타입 값 복사 - sDay2.year 할당으로 sDay.year 값 불변
            Console.WriteLine($"{sDay.year}-{sDay.month}-{sDay.day}");  
            Console.WriteLine($"{sDay2.year}-{sDay2.month}-{sDay2.day}");
            Console.WriteLine();

            DateClass cDay2;
            cDay2 = cDay;
            Console.WriteLine($"{cDay2.year}-{cDay2.month}-{cDay2.day}");
            cDay2.year = 2025;
            // class는 참조타입 참조를 가리킴 - cDay2.year 할당으로 cDay.year 값 변경가능
            Console.WriteLine($"{cDay.year}-{cDay.month}-{cDay.day}");
            Console.WriteLine($"{cDay2.year}-{cDay2.month}-{cDay2.day}");
            Console.WriteLine();*/

            // 위에서 사용된 class는 구조체 스타일이라 class 스타일으로 변경후 Print함수 추가후 테스트
            /*DateClass2 cDay2 = new DateClass2();
            cDay2.Print();*/

            // 인스턴스 메소드, 스태틱 메소드
            /*Car.BBangBBang();   // 스태틱 메소드는 인스턴스를 생성하지 않고 호출 가능
            //(x new 필요) Car.SpeedUp();
            Car mysonata = new Car(); mysonata.SpeedUp();   // 인스턴스 메소드는 new 인스턴스 후 호출가능
            Car yoursonata = new Car(); yoursonata.SpeedUp();*/

            // 클래스의 멤버중 속성 - Property(Get, Set) 사용법 이해
            /*Rectangle r = new Rectangle();
            // r.width = 10;    //private라 접근 할수 없음
            r.SetWidth(10.1);
            double result = r.GetWidth();
            Console.WriteLine(result);
            RectanglePropertyVer rProp = new RectanglePropertyVer();
            rProp.width = result;*/

            // 메소드 인수, 인자 - 메소드(전달값 - 인수), (정의 변수 - 인자)
            /*//default - 값->값or참조->참조, return - 반환값, void - 반환X
            //                  목적                 초기화              의미       매서드 내부 수정
            //ref키워드 - 값 수정 반환        호출전 초기화 필수      입출력 가능        가능
            //out키워드 - 새로운 값 반환      호출전 초기화 불필요    출력 전용          필수
            int a = 3; sqr(a); Console.WriteLine($"값에 의한 호출 : {a}");
            int b = 3; sqr(ref b); Console.WriteLine($"값에 의한 호출 : {b}");
            int res = sqr_return(a); Console.WriteLine($"값에 의한 호출 : {res}");
            int num1 = 7; int num2 = 2;
            int sum; int sub; int mul; int div;
            Sachick(num1, num2, out sum, out sub, out mul, out div);
            Console.WriteLine($"out에 의한 호출: 합{sum} 차{sub} 곱{mul} 몫{div}");*/

            // 가변길이 params
            /*int[] num_in = { 1, 2, 3, 4, 5 }; double num_res = Average(7, num_in);
            // (7, params int[] x) params 자료형[]에 자료형값 가변으로 추가가능
            // double num_res = Average(7, 1, 2, 3, 4, 5); 
            Console.WriteLine($"평균: {num_res}");*/

            // 선택적 인수 - 메서드(자료형 변수 = 기본값), 명명된 인수 - 메서드(변수 : 값)
            /*int num = 1; //int res = inc(num, 1);
            int res = inc(num);
            Console.WriteLine($"{num}로 부터 증가한 양은 {res}이다.");
            int res2 = sub(frontNum:2, backNum:1); // 명명된 인수방식
            Console.WriteLine($"2 - 1 = {res2}");*/

            // overriding, 메소드 generic, 클래스 제네릭, dynamic 문법 설명만 함

            // 인덱서 - 객체를 배열처럼 객체[인덱스] 방식으로 사용할 수 있게 해주는 기능
            /*// 클래스나 구조체에 대해 배열처럼 접근할 수 있도록 연산자([])를 오버로드하는 것
            // this 키워드로 정의하고 매개변수 형태로 인덱스를 받음
            Weekdays week = new Weekdays();
            Console.WriteLine(week[0]);
            week[0] = "Mon";
            for (int i = 0; i < week.Length; i++)
            {
             Console.WriteLine($"{i}번째 인덱서 내용은 {week[i]}");   
            }*/

            // Delegate, Anonymous Delegate, Func, Action, Predicate<T>, Lambda Expression
            /*// Delegate 델리게이트 - 대리자, C언어 함수포인터, 메서드를 변수로 사용가능
            // delegate 메서드(); - 선언, 사용시 -> 메서드 변수명; - 변수 초기화
            // 사용시 인수가 있을경우 - 변수명(인수), 인수가 없을경우 - 변수명
            // Anonymous Delegate 익명 델리게이트 - 변수 선언 없이 delegate (자료형 매개변수){기능}
            // Func - 반환값이 있는 델리게이트, Action 반환값이 없는 델리게이트 *델리게이트 선언 불필요
            // Predicate<T> 델리게이트 - 하나의 매개변수를 갖고 리턴값이 bool인 델리게이트
            // Lamda - 익명메소드를 간단하게 표현, 사용방식 - 인자 => 내용;*/

            // LINQ - Language INtegrated Query(통합 데이터 질의 기능) SQL문 처럼 C#에서 사용할수있는 문법

            // 문제 1-9단 각 행에 단별 결과값 출력
            // [9, 9]크기 1행당 각 단 곱셈 결과, 단이 넘어갈때마다 1씩 증가
            Console.WriteLine("For문");
            for (int i = 1; i <= 9; i++)
            {
                for (int j = 1; j <= 9; j++)
                {
                    Console.Write($"{i * j, 2} ");
                }
                Console.WriteLine();
            }
            Console.WriteLine("While문");
            int 행 = 1;
            int 열 = 1;
            while (행 <= 9)
            {
                while (열 <= 9)
                {
                    Console.Write($"{행 * 열,2} ");
                    열++;
                }
                Console.WriteLine();
                열 = 1;
                행++;
            }



        }

        // 메소드 인수 설명용
        static void sqr(int x) { x = x * x; }
        static void sqr(ref int x) { x = x * x; }
        static int sqr_return(int x) { x = x * x; return x; }
        static void Sachick(int a, int b, out int sum, out int sub, out int mul, out int div) 
        { sum = a + b; sub = a - b; mul = a * b; div = a / b; }

        // 가변 길이 설명용
        //public static double Average(params int[] x, int totalCount) {  } // params키워드는 마지막 인수로만!
        public static double Average(int totalCount, params int[] x)
        {
            int sum = 0;
            for (int i = 0; i < x.Length; i++) { sum += x[i]; }
            return sum / x.Length;
        }

        // 명명된 인수 설명용
        static int inc(int x, int incAmount = 1) { x += incAmount; return x; } // 선택적 인수방식
        static int sub(int backNum, int frontNum) { return frontNum - backNum; }

    }
}
