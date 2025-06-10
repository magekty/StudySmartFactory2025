//Iterator 반복자

class Car{
    private String serialNumber;
    public Car(String serialNumber){
        this.serialNumber=serialNumber;
    }
    public void inspect(){
        System.out.println("차량 검사: "+this.serialNumber);
    }
}
interface CarIterator{
    boolean hasNext();
    Car next();
}

class CarCollection{
    private Car[] cars;
    private int index = 0;
    public CarCollection(int size){
        cars = new Car[size];
    }
    public void addCar(Car car){
        if(index<cars.length){
            cars[index++] = car;
        }
    }
    public CarIterator iterator(){
        return new CarArrayIterator(cars);
    }
}

class CarArrayIterator implements CarIterator{
    private  Car[] cars;
    private  int position = 0;
    public CarArrayIterator(Car[] cars){
        this.cars=cars;
    }

    @Override
    public boolean hasNext() {
        return position< cars.length && cars[position]!=null;
    }

    @Override
    public Car next() {
        return cars[position++];
    }


}

public class Main {
    public static void main(String[] args) {
        CarCollection collection = new CarCollection(5);
        collection.addCar(new Car("A1001"));
        collection.addCar(new Car("A1002"));
        collection.addCar(new Car("A1003"));

        CarIterator iterator = collection.iterator();
        while(iterator.hasNext()){
            Car car = iterator.next();
            car.inspect();
        }
    }


}