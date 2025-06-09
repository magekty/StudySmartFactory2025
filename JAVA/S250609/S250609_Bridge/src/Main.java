// Bridge
// 조합
// 차종: Sedan, Suv, Truck
// 연료: Gasolin, Diesel, Electric
// 조합: Ev-Sedan, Diesel Suv, gasolin Suv

// 연료
interface Fuel{void refuel();}
class Gasolin implements Fuel{
    public void refuel(){
        System.out.println("휘발유 재급유");
    }
}
class Diesel implements Fuel{
    public void refuel(){
        System.out.println("디젤 재급유");
    }
}
class Electric implements Fuel{
    public void refuel(){
        System.out.println("전기 충전");
    }
}
// 자동차 종류
abstract class Car{
    protected Fuel fuel;
    public Car(Fuel fuel){this.fuel=fuel;}
    public abstract void drive();
}
class Sedan extends Car{
    public Sedan(Fuel fuel){super(fuel);}
    public void drive(){
        System.out.println("Sedan 주행 중");
        fuel.refuel();
    }
}
class Suv extends Car{
    public Suv(Fuel fuel){super(fuel);}
    public void drive(){
        System.out.println("SUV 주행 중");
        fuel.refuel();
    }
}
class Truck extends Car{
    public Truck(Fuel fuel){super(fuel);}
    public void drive(){
        System.out.println("Truck 주행 중");
        fuel.refuel();
    }
}
public class Main {
    public static void main(String[] args) {
        Car evSedan = new Sedan(new Electric());
        Car evTruck = new Truck(new Electric());
        evSedan.drive();
        evTruck.drive();
    }
}