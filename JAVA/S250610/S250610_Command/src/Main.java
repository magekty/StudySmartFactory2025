//Command

import java.util.Stack;

class ProductionManager{
    private Stack<ProductionCommand> history = new Stack<>();
    public void runCommand(ProductionCommand command){
        command.execute();
        history.push(command);
    }
    public void undoLastCommand(){
        if(!history.empty()){
            ProductionCommand command = history.pop();
            command.undo();
        }
        else{
            System.out.println("취소할 명령이 없다");
        }

    }


}

class CarProductionSystem{
    public void assembleEngine(){
        System.out.println("엔진 조립 완료");
    }
    public void paintCar(){
        System.out.println("차량 도장 완료");
    }
    public void testCar(){
        System.out.println("차량 테스트 완료");
    }

}

interface ProductionCommand{
    void execute();
    void undo();
}

class AssembleEngineCommand implements ProductionCommand{
    private CarProductionSystem system;
    @Override
    public void execute() {
        system.assembleEngine();
    }

    @Override
    public void undo() {
        System.out.println("엔진 조립 취소");
    }
    public AssembleEngineCommand(CarProductionSystem system){
        this.system = system;
    }


}

class PaintCarCommand implements ProductionCommand{
    private CarProductionSystem system;
    @Override
    public void execute() {
        system.paintCar();
    }

    @Override
    public void undo() {
        System.out.println("차량 도장 취소");
    }
    public PaintCarCommand(CarProductionSystem system){
        this.system=system;
    }


}

class TestCarCommand implements ProductionCommand{
    private CarProductionSystem system;
    @Override
    public void execute() {
        system.testCar();
    }

    @Override
    public void undo() {
        System.out.println("차량 테스트 취소");
    }
    public TestCarCommand(CarProductionSystem system){
        this.system= system;
    }


}

public class Main {
    public static void main(String[] args) {

        CarProductionSystem system = new CarProductionSystem();

        ProductionCommand assemble = new AssembleEngineCommand(system);
        ProductionCommand paint = new PaintCarCommand(system);
        ProductionCommand test = new TestCarCommand(system);

        ProductionManager manager = new ProductionManager();

        //작업 실행
        manager.runCommand(assemble);
        manager.runCommand(paint);
        manager.runCommand(test);
        //마지막 작업 취소
        System.out.println("최근 작업 취소");
        manager.undoLastCommand();
        manager.undoLastCommand();

    }


}