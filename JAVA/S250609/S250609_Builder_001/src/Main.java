// Builder Pattern
class Car{
    private String engine;
    private String tires;
    private String body;
    public void setEngine(String engine){this.engine = engine;}
    public void setTires(String tires){this.tires = tires;}
    public void setBody(String body){this.body = body;}
    public void proccesCar(){
        System.out.println(""+ engine+", "+ tires+", "+ body + " -> 조립 완료 되었습니다.");
    }
}
interface CarBuilder {
    void buildEngine();
    void buildTires();
    void buildBody();
    Car getCar();
}
class SportsCarBuilder implements CarBuilder {
    private Car car = new Car();
    public Car getCar(){return car;}
    public void buildEngine(){car.setEngine("V8 터보 엔진");}
    public void buildTires(){car.setTires("레이싱용 타이어");}
    public void buildBody(){car.setBody("스포츠카용 경량 풀 프레임 바디");}
}
class SUVCarBuilder implements CarBuilder {
    private Car car = new Car();
    public Car getCar(){return car;}
    public void buildEngine(){car.setEngine("디젤 엔진");}
    public void buildTires(){car.setTires("오프로드 타이어");}
    public void buildBody(){car.setBody("SUV 프레임 바디");}
}
class CarDirector {
    private CarBuilder builder;
    public CarDirector(CarBuilder builder){this.builder = builder;}
    public Car construct(){
        builder.buildEngine();
        builder.buildTires();
        builder.buildBody();
        return builder.getCar();
    }
}

public class Main {
    public static void main(String[] args) {
        // 스포츠카 조립
        CarBuilder sportsCarBuilder = new SportsCarBuilder();
        CarDirector sportsCarDirector = new CarDirector(sportsCarBuilder);
        Car sportsCar = sportsCarDirector.construct();
        sportsCar.proccesCar();
        // SUV 조립
        CarBuilder SUVCarBuilder = new SUVCarBuilder();
        CarDirector SUVCarDirector = new CarDirector(SUVCarBuilder);
        Car SUVCar = SUVCarDirector.construct();
        SUVCar.proccesCar();
    }
}