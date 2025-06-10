// 책임 연쇄 (Chain Responsibility)
// A-> B -> C > D
//일련의 작업 흐름에서 각 단계가 책임을 다 하고 문제가 없으면 다음 단계 진행
class Car{
    public boolean exteriorOk = true;
    public boolean engineOk = true;
    public boolean electronicOk = true;
    public String serialNumber;

    public Car(String serialNumber){
        this.serialNumber=serialNumber;
    }


}

abstract class QualityCheck{
    protected QualityCheck next;
    public void setNext(QualityCheck next){
        this.next =next;
    };
    public void check(Car car){
        if(next!=null){
            next.check(car);
        }
    }
}

class ExteriorChecker extends QualityCheck{
    @Override
    public void check(Car car) {
        if(!car.exteriorOk){ // 실패시
            System.out.println(car.serialNumber+"차의 외관 검사 실패 됨");
        }
        else{ // 성공시
            System.out.println(car.serialNumber+"차의 외관 검사 성공 함");
            super.check(car);
        }
    }
}

class EngineChecker extends QualityCheck{
    @Override
    public void check(Car car) {
        if(!car.engineOk){
            System.out.println(car.serialNumber+"차의 엔진 검사 실패 됨");
        }
        else{
            System.out.println(car.serialNumber+"차의 엔진 검사 성공 함");
            super.check(car);
        }
    }
}

class ElectronicChecker extends QualityCheck{
    @Override
    public void check(Car car) {
        if(!car.electronicOk){
            System.out.println(car.serialNumber+"차의 전장 검사 실패 됨");
        }
        else{
            System.out.println(car.serialNumber+"차의 전장 검사 성공 함");
            super.check(car);
        }
    }
}

public class Main {
    public static void main(String[] args) {
        Car car1 = new Car("A1001");
        Car car2 = new Car("A1002");
        car2.engineOk = false;

        QualityCheck checkerChain = new ExteriorChecker();
        QualityCheck engineChecker = new EngineChecker();
        QualityCheck electronicChecker = new ElectronicChecker();

        checkerChain.setNext(engineChecker);
        engineChecker.setNext(electronicChecker);

        System.out.println("-- 1번 자동차 검사 --");
        checkerChain.check(car1);
        System.out.println("-- 2번 자동차 검사 --");
        checkerChain.check(car2);
    }


}