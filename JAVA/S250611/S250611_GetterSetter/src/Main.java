// Getter Setter
class A{
    int a1;
    public A(int a1){this.a1=a1;}
}
class B{
    private String role;
    private int b1;
    public B(int b1, String role){this.b1 = b1;this.role = role;}
    void setB1(int b1){if(role.equals("admin"))this.b1 = b1;}
    int getB1(){if(role.equals("admin"))return this.b1;
    else return -1;}
}
public class Main {
    public static void main(String[] args) {
        A a = new A(10); System.out.println(a.a1);
        //B b = new B(20); System.out.println(a.b1);
        B b = new B(20,"visitor"); System.out.println(b.getB1());
        B b2 = new B(20,"admin"); System.out.println(b2.getB1());

    }
}