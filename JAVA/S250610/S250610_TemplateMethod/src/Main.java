// TemplateMethod
// 기본 표준 공정이 있고, 일부만 커스터마이징
// 프레임설치 -> 엔진장착 -> 타이어장착 -> 고객맞춤 -> 품질검사
// 공통 부분 템플릿
abstract class CarAssemblyLine{
    public final void assemble(){
        installFrame();
        installEngine();
        installTire();
        customize();
        inspect();
        System.out.println("자동차 조립 완료");
    }
    protected void installFrame(){System.out.print(" 프레임 설치,");}
    protected void installEngine(){System.out.print(" 엔진 설치,");}
    protected void installTire(){System.out.println(" 타이어 설치");}
    protected void inspect(){System.out.println("품질 검사");}
    protected abstract void customize();
}
// 커스텀 부분은 상속 후 오버라이드
class SedanAssembly extends CarAssemblyLine{
    @Override
    protected void customize() {System.out.println("세단: 가죽시트");}
}
class SUVAssembly extends CarAssemblyLine{
    @Override
    protected void customize() {System.out.println("SUV: 나침반");}
}
class TruckAssembly extends CarAssemblyLine{
    @Override
    protected void customize() {System.out.println("트럭: 적재함 보강");}
}
public class Main {
    public static void main(String[] args) {
        CarAssemblyLine sedanLine = new SedanAssembly();
        CarAssemblyLine suvLine = new SUVAssembly();
        CarAssemblyLine truckLine = new TruckAssembly();

        System.out.print("세단 조립 시작:");
        sedanLine.assemble();
        System.out.print("SUV 조립 시작:");
        suvLine.assemble();
        System.out.print("트럭 조립 시작:");
        truckLine.assemble();
    }
}