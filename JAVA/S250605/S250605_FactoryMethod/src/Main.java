interface CarPart{
    void assemble();
}
class Engine implements CarPart{
    @Override
    public void assemble(){System.out.println("엔진 조립합니다.");}
}
class Tire implements CarPart{
    @Override
    public void assemble(){System.out.println("타이어 조립합니다.");}
}
abstract class PartFactory{
    public abstract CarPart createPart();
}
class EngineFactory extends PartFactory{
    @Override
    public CarPart createPart(){return new Engine();}
}
class TireFactory extends PartFactory{
    @Override
    public CarPart createPart(){return new Tire();}
}
public class Main {
    public static void main(String[] args) {
        PartFactory enginFactory = new EngineFactory();
        CarPart engin = enginFactory.createPart();
        engin.assemble();
        PartFactory tireFactory = new TireFactory();
        CarPart tire = tireFactory.createPart();
        tire.assemble();
    }
}