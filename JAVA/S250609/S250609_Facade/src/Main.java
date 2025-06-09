// Facade: 건물에서 정면(건물의 정체성을 보여주는 장식), 복잡한 내부를 숨기고 간단한 인터페이스만 제공
class EngineAssembler{
    public void assemble(){System.out.println("엔진 조립 했다");}
}
class BodyAssembler{
    public void assemble(){System.out.println("바디 조립 했다");}
}
class PaintShop{
    public void paint(){System.out.println("도장 했다");}
}
class QualityInspector{
    public void inspect(){System.out.println("품질 검사 했다");}
}
class CarProductionFacade{
    private EngineAssembler engineAssembler;
    private BodyAssembler bodyAssembler;
    private PaintShop paintShop;
    private QualityInspector qualityInspector;

    public CarProductionFacade() {
        this.engineAssembler = new EngineAssembler();
        this.bodyAssembler = new BodyAssembler();
        this.paintShop = new PaintShop();
        this.qualityInspector = new QualityInspector();
    }

    public void produceCar(){
        System.out.println("자동차를 만들기 시작");
        engineAssembler.assemble();
        bodyAssembler.assemble();
        paintShop.paint();
        qualityInspector.inspect();
        System.out.println("자동차를 만들기 끝");
    }
}
public class Main {
    public static void main(String[] args) {
        CarProductionFacade facade = new CarProductionFacade();
        facade.produceCar();
    }
}