//Memento
//Command와 비교해서 볼 것

import java.util.Stack;

class CarDesign{
    private String bodyType;
    private String engine;
    private String color;

    public void setDesign(String bodyType,String engine,String color){
        this.bodyType=bodyType;
        this.engine=engine;
        this.color=color;
        System.out.println("설계 반영됨: "+toString());
    }
    public String toString(){
        return "[차체: "+this.bodyType+", 엔진: "+this.engine+", 색상: "+this.color+"]";
    }
    public CarDesignMemento save(){

        return new CarDesignMemento(this.bodyType,this.engine,this.color);
    }
    public void restore(CarDesignMemento memento){
        this.bodyType=memento.getBodyType();
        this.engine=memento.getEngine();
        this.color = memento.getColor();
        System.out.println("설계 복원됨: "+toString());
    }


}
class CarDesignMemento{
    private String bodyType;
    private String engine;
    private String color;

    public CarDesignMemento(String bodyType,String engine,String color){
        this.bodyType=bodyType;
        this.engine=engine;
        this.color=color;
    }
    public String getBodyType(){
        return this.bodyType;
    }
    public String getEngine(){
        return this.engine;
    }
    public String getColor(){
        return this.color;
    }


}

class DesignHistory{
    private Stack<CarDesignMemento> history = new Stack<>();
    public void save(CarDesignMemento memento){
        history.push(memento);
    }
    public CarDesignMemento undo(){
        if(!history.empty()){
            return history.pop();
        }
        return  null;
    }
}

public class Main {
    public static void main(String[] args) {
        CarDesign design = new CarDesign();
        DesignHistory history = new DesignHistory();

        design.setDesign("세단","가솔린","검정");
        history.save(design.save());

        design.setDesign("SUV","디젤","파랑");
        history.save(design.save());

        design.setDesign("쿠페","전기","노랑");

        System.out.println("-- 복원 --");
        design.restore(history.undo());
        design.restore(history.undo());

    }


}