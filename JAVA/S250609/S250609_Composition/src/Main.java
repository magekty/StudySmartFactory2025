// Composite (복합체)


import java.util.ArrayList;
import java.util.List;

interface Part { void showDetails(String indent);}
class Tire implements Part{
    private String position;
    public Tire(String position){this.position=position;}
    public void showDetails(String indent){
        System.out.println(indent+" 타이어 ("+position+")");
    }
}
class Pision implements Part{
    public  void showDetails(String indent){
        System.out.println(indent + "피스톤");
    }
}
class SparkPlug implements Part{
    public  void showDetails(String indent){
        System.out.println(indent + "점화 플러그");
    }
}
// composite Part
class CompositePart implements Part{
    private String name;
    private List<Part> children = new ArrayList<>();
    public CompositePart(String name){this.name = name;}
    public void addPart(Part part){children.add(part);}
    @Override
    public  void showDetails(String indent){
        System.out.println(indent+name);
        for(Part part:children){
            part.showDetails(indent+"    ");
        }
    }
}
public class Main {
    public static void main(String[] args) {
        //엔진 = 피스톤 + 점화 플러그
        CompositePart engine = new CompositePart("엔진");
        engine.addPart(new Pision());
        engine.addPart(new SparkPlug());
        //자동차 = 엔진 + 타이어
        CompositePart car = new CompositePart("자동차");
        car.addPart(engine);
        car.addPart(new Tire("FL"));
        car.addPart(new Tire("FR"));
        car.addPart(new Tire("RL"));
        car.addPart(new Tire("RR"));

        car.showDetails("");
    }
}
// 자동차
//      엔진
//          피스톤
//          점화플러그
//      타이어
//      타이어
//      타이어
//      타이어
//      타이어