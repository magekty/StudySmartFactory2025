// abstract factory
// 서로다른 국가별 자동차 부품 생산 공장
// 한국 공장, 미국 공장
interface Engine{void design();}
interface Tire{ void produce();}
class KoreanEngine implements Engine{
    @Override
    public void design(){ System.out.println("한국식 엔진 설계"); };
}
class UsaEngine implements Engine{
    @Override
    public void design(){ System.out.println("미국식 엔진 설계"); };
}
class KoreanTire implements Tire{
    @Override
    public void produce(){ System.out.println("한국식 타이어 생산"); };
}
class UsaTire implements Tire{
    @Override
    public void produce(){ System.out.println("미국식 타이어 생산"); };
}
// factory
interface CarPartsFactory{
    Engine createEngine();
    Tire createTire();
}
class KoreanPartsFactory implements CarPartsFactory{
    @Override
    public Engine createEngine(){return new KoreanEngine();}
    @Override
    public Tire createTire(){return  new KoreanTire();}
}
class UsaPartsFactory implements CarPartsFactory{
    @Override
    public Engine createEngine(){return new UsaEngine();}
    @Override
    public Tire createTire(){return  new UsaTire();}
}
// Car
class Car{
    private Engine engine;
    private Tire tire;
    public Car(CarPartsFactory factory){
        this.engine = factory.createEngine();
        this.tire = factory.createTire();
    }
    
    public void assemble(){
        System.out.println("자동차 조립 시작");
        engine.design();
        tire.produce();
        System.out.println("자동차 조립 완료");
    }
}


public class Main {
    public static void main(String[] args) {
        CarPartsFactory koreanFactory = new KoreanPartsFactory();
        Car koreanCar = new Car(koreanFactory);
        koreanCar.assemble();

        CarPartsFactory usaFactory = new UsaPartsFactory();
        Car usaCar = new Car(usaFactory);
        usaCar.assemble();
    }
}