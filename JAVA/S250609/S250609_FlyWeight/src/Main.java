// FlyWeight : (메모리) 낭비를 줄이자 -> 반복을 줄이자 -> 공유
//

import java.util.*
        ;

// 공유 객체
class CarModel{
    private final String color;
    private final String bodyShape;
    private final String wheelType;

    public CarModel(String color, String bodyShape, String wheelType) {
        this.color = color;
        this.bodyShape = bodyShape;
        this.wheelType = wheelType;
    }
    public void render(String serialNumber, String location){
        System.out.printf("%s[%s] - col:%s, bodyShape:%s, wheelType:%s\n",
                location, serialNumber, this.color, this.bodyShape, this.wheelType);
    }
}
class CarModelFactory{
    private static final Map<String, CarModel> modelPool = new HashMap<>();
    public static CarModel getCarModel(String color, String bodyShape, String wheelType){
        String key = color + "-" + bodyShape + "-" + wheelType;
        if(!modelPool.containsKey(key)){
            modelPool.put(key, new CarModel(color, bodyShape, wheelType));
        }
        return modelPool.get(key);
    }

}
class CarInstance{
    String serialNumber;
    String location;
    CarModel model;

    public CarInstance(String serialNumber, String location, CarModel model) {
        this.serialNumber = serialNumber;
        this.location = location;
        this.model = model;
    }
    public void display(){
        model.render(location,serialNumber);
    }
}
public class Main {
    public static void main(String[] args) {
        List<CarInstance> cars = new ArrayList<>();
        CarModel redSedan = CarModelFactory.getCarModel("red", "sedan", "alloy");
        CarModel blueSUV = CarModelFactory.getCarModel("blue", "SUV", "steel");
        cars.add(new CarInstance("SN0001","서울",redSedan));
        cars.add(new CarInstance("SN0002","부산",redSedan));
        cars.add(new CarInstance("SN0003","대전",blueSUV));
        cars.add(new CarInstance("SN0004","세종",redSedan));
        for(CarInstance car : cars){
            car.display();
        }
    }
}