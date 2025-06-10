// State: 상태 전이(조립 중 -> 검사 중 -> 출고 대기 중 -> 출고 완료)
interface CarState{
    void handleNext(Car car);
    String getName();
}
class AssemblingState implements CarState{

    @Override
    public void handleNext(Car car) {
        System.out.println("조립 완료 -> 검사로 보내라");
        car.setState(new InspetingState());
    }

    @Override
    public String getName() {
        return "조립 중";
    }
}
class InspetingState implements CarState{

    @Override
    public void handleNext(Car car) {
        System.out.println("검사 완료 -> 출고 대기로 보내라");
        car.setState(new ReadyForDeliveryState());
    }

    @Override
    public String getName() {
        return "검사 중";
    }
}
class ReadyForDeliveryState implements CarState{

    @Override
    public void handleNext(Car car) {
        System.out.println("출고 대기 -> 출고 완료로 보내라");
        car.setState(new InspetingState());
    }

    @Override
    public String getName() {
        return "출고 대기";
    }
}
class DeliveredState implements CarState{

    @Override
    public void handleNext(Car car) {
        System.out.println("출고 완료 됨 이제 상태 변화 없음");
        // car.setState();
    }

    @Override
    public String getName() {
        return "출고 완료";
    }
}
class Car{
    private String serial;
    private CarState state;

    public Car(String serial) {
        this.serial = serial;
        this.state = new AssemblingState();
    }
    public void proceed(){
        System.out.println(serial + "번 자동차의 현재 상태: " + state.getName());
        state.handleNext(this);
    }
    public void setState(CarState carState){
        this.state = carState;
    }
}
public class Main {
    public static void main(String[] args) {
        Car car = new Car("A1001");

        car.proceed(); // 조립 -> 검사
        car.proceed(); // 검사 -> 출고 대기
        car.proceed(); // 출고 대기 -> 출고 완료
        car.proceed(); // 출고 완료 -> 변화 x
    }
}