// Decorator
// 기능을 추가한다. 원래 클래스는 그대로
interface Car{String getDescription(); int getPrice();}
class BasicCar implements Car{
    @Override
    public String getDescription(){return "기본 자동차";}
    @Override
    public int getPrice(){return 2000;}
}
abstract class CarOptionDecorator implements Car{
    protected Car car;
    public CarOptionDecorator(Car car){this.car = car;}
    public abstract String getDescription();
    public abstract int getPrice();
}
class SunRoof extends CarOptionDecorator{
    public SunRoof(Car car){super(car);}
    public String getDescription(){
        return car.getDescription() + " 썬루프";
    }
    public int getPrice(){return car.getPrice() + 500;}
}
class BlackBox extends CarOptionDecorator{
    public BlackBox(Car car){super(car);}
    public String getDescription(){
        return car.getDescription() + " 블랙박스";
    }
    public int getPrice(){return car.getPrice() + 50;}
}
class HeatedSeat extends CarOptionDecorator{
    public HeatedSeat(Car car){super(car);}
    public String getDescription(){
        return car.getDescription() + " 영따 시트";
    }
    public int getPrice(){return car.getPrice() + 100;}
}
public class Main {
    public static void main(String[] args) {
        Car car = new BasicCar();       // car: BasicCar
        car = new SunRoof(car);         // car: BasicCar + SunRoof
        car = new BlackBox(car);        // car: BasicCar + SunRoof + BlackBox
        car = new HeatedSeat(car);      // car: BasicCar + SunRoof + BlackBox + HeatedSeat
        System.out.println("차량 설명 : "+ car.getDescription());
        System.out.println("차량 가격 : "+ car.getPrice());
    }
}