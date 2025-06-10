//Mediator

import java.util.HashMap;
import java.util.Map;

interface Department{
    void setMediator(ProductionMediator m);
    void send(String message);
    void receive(String message);
    String getName();
}
interface ProductionMediator{
    void sendMessage(String message,Department sender);
}

class EngineTeam implements Department{
    private ProductionMediator mediator;

    @Override
    public void setMediator(ProductionMediator m) {
        this.mediator=m;
    }

    @Override
    public void send(String message) {
        mediator.sendMessage(message,this);
    }

    @Override
    public void receive(String message) {
        System.out.println("[엔진팀] 받은 메세지 "+message);
    }

    @Override
    public String getName() {
        return "EngineTeam";
    }


}

class PaintTeam implements Department{
    private ProductionMediator mediator;

    @Override
    public void setMediator(ProductionMediator m) {
        this.mediator=m;
    }

    @Override
    public void send(String message) {
        mediator.sendMessage(message,this);
    }

    @Override
    public void receive(String message) {
        System.out.println("[페인트 팀] 받은 메세지 "+message);
    }

    @Override
    public String getName() {
        return "PaintTeam";
    }

}

class ProductionCoordinator implements ProductionMediator{
    private Map<String,Department> departments = new HashMap<>();
    public void register(Department department){
        departments.put(department.getName(),department);
        department.setMediator(this);
    }

    @Override
    public void sendMessage(String message, Department sender) {
        for(Department department:departments.values()){
            if(department != sender){
                department.receive("["+sender.getName()+"]"+message);
            }
        }
    }


}

public class Main {
    public static void main(String[] args) {
        ProductionCoordinator mediator = new ProductionCoordinator();

        Department engine = new EngineTeam();
        Department paint = new PaintTeam();
        Department logistics = new Department(){
            private ProductionMediator mediator;
            public void setMediator(ProductionMediator m){
                this.mediator = m;
            }
            public void send(String message){
                mediator.sendMessage(message,this);
            }
            public void receive(String message){
                System.out.println("[물류팀] 받은 메세지 "+message);
            }
            public String getName(){
                return "LogisticsTeam";
            }
        };
        mediator.register(engine);
        mediator.register(paint);
        mediator.register(logistics);

        engine.send("엔진 조립 완료");
        paint.send("도장 완료, 검사팀 호출 필요");

    }


}