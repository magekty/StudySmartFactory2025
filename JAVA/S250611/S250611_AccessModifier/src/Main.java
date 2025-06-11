// AccessModifier 접근 제한자
import p1.C;

class A{
    public void A1(){}
}
class B extends C{
    private void B1(){
        super.C2();
        super.C3();
    }
}

public class Main {
    public static void main(String[] args) {
        A a = new A();
        B b = new B();
        b.B1();
        a.A1();
        C c = new C();
        c.C1(); c.C2(); c.C3();

    }
}