// Visitor 방문자
import java.util.List;
import java.util.ArrayList;

interface CarPartVisitor{
    void visit(Engine engine);
    void visit(Tire tire);
    void visit(Body body);
}
class InspectionVisitor implements CarPartVisitor{
    @Override
    public void visit(Engine engine) {
        System.out.println("엔진 검사"+engine.getModel());
    }

    @Override
    public void visit(Tire tire) {
        System.out.println("타이어 검사"+tire.getPosition());
    }

    @Override
    public void visit(Body body) {
        System.out.println("차체 검사"+body.getType());
    }
}
class TaxVisitor implements CarPartVisitor{
    @Override
    public void visit(Engine engine) {
        System.out.println("엔진 세금 산출: 고배기량 엔진은 고세율 적용");
    }

    @Override
    public void visit(Tire tire) {
        System.out.println("타이어 세금 산출: 위치에 따라 기본 세율");
    }

    @Override
    public void visit(Body body) {
        System.out.println("차체 세금 산출: SUV는 세금 1.2배");
    }
}
interface CarPart{void accept(CarPartVisitor visitor);}
class Engine implements CarPart{
    public void accept(CarPartVisitor visitor){
        visitor.visit(this);
    }
    public String getModel(){return "V8 turbo";}
}
class Body implements CarPart{
    public void accept(CarPartVisitor visitor){
        visitor.visit(this);
    }
    public String getType(){return "SUV";}
}
class Tire implements CarPart{
    private String position;
    public Tire(String position){this.position=position;}
    public void accept(CarPartVisitor visitor){
        visitor.visit(this);
    }
    public String getPosition(){return position;}
}
public class Main {
    public static void main(String[] args) {
        List<CarPart> parts = new ArrayList<>();
        parts.add(new Engine());
        parts.add(new Tire("FL"));
        parts.add(new Tire("FR"));
        parts.add(new Body());

        CarPartVisitor inspector = new InspectionVisitor();
        CarPartVisitor taxOfficer = new TaxVisitor();
        System.out.println("-- 차량 검사 시작");
        for(CarPart part:parts){part.accept(inspector);}
        System.out.println("-- 세금 산출 시작");
        for(CarPart part:parts){part.accept(taxOfficer);}
    }
}