// 차량 등급별 생산
// EconomyCarFactory: 저가형(작은 엔진, 작은 타이어)
// LuxuryCarFactory: 고급형(고급 엔진, 고급 타이어)
interface Engine{void spec();}
interface Tire{ void spec();}
class EconomyEngine implements Engine{
    @Override
    public void spec(){ System.out.println("작은 엔진"); };
}
class LuxuryEngine implements Engine{
    @Override
    public void spec(){ System.out.println("고성능 엔진"); };
}
class EconomyTire implements Tire{
    @Override
    public void spec(){ System.out.println("작은 타이어"); };
}
class LuxuryTire implements Tire{
    @Override
    public void spec(){ System.out.println("고성능 타이어"); };
}
// factory
interface CarPartsFactory{
    Engine createEngine();
    Tire createTire();
}
class EconomyCarFactory implements CarPartsFactory{
    @Override
    public Engine createEngine(){return new EconomyEngine();}
    @Override
    public Tire createTire(){return  new EconomyTire();}
}
class LuxuryCarFactory implements CarPartsFactory{
    @Override
    public Engine createEngine(){return new LuxuryEngine();}
    @Override
    public Tire createTire(){return  new LuxuryTire();}
}
// Car
class Car{
    private Engine engine;
    private Tire tire;
    public Car(CarPartsFactory factory){
        this.engine = factory.createEngine();
        this.tire = factory.createTire();
    }

    public void showSpecs(){
        System.out.println("자동차 사양 출력 시작:");
        engine.spec();
        tire.spec();
        System.out.println("자동차 사양 출력 끝:");
    }
}
public class Main {
    public static void main(String[] args) {
        CarPartsFactory ecoFactory = new EconomyCarFactory();
        Car ecoCar = new Car(ecoFactory);
        ecoCar.showSpecs();
        CarPartsFactory luxFactory = new LuxuryCarFactory();
        Car luxCar = new Car(luxFactory);
        luxCar.showSpecs();
    }
}