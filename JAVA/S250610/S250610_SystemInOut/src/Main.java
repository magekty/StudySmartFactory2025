import java.util.Scanner;

//   C# Console.writeline()
//      Console.readline()
public class Main {
    public static void main(String[] args) {
        System.out.println("아무 글자나 입력 하세요");
        Scanner sc = new Scanner(System.in);
        String userInput = sc.nextLine();
        System.out.println("너는 "+ userInput + "이라고 입력했구나");

        System.out.println("정수를 입력 하세요");
        int userInput_int = sc.nextInt();
        System.out.println("너가 입력한 숫자에 10 더했어 : "+ (userInput_int + 10));

        System.out.println("정수를 입력 하세요");
        double userInput_double = sc.nextDouble();
        System.out.println("너가 입력한 숫자에 10.12 더했어 : "+ (userInput_double + 10.12));


    }
}