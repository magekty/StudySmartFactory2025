// Adapter
// 엔진 제어 시스템(자체 제작), Target
// 엔진 컨트롤러(해외 공급), Adaptee
// 양 쪽의 인터페이스가 달라서 사용이 어렵다, Adapter
interface EngineController{
    void startEngine();
    void stopEngine();
}
class ForeignEngineSystem{
    public void activate(){System.out.println("외부 엔진 시스템 시작");}
    public void shutdown(){System.out.println("외부 엔진 시스템 종료");}
}
// startEngine() <-> activate()
// stopEngine() <-> shutdown()
class ForeignEngineAdapter implements EngineController{
    private ForeignEngineSystem foreignEngineSystem;

    public ForeignEngineAdapter(ForeignEngineSystem foreignEngineSystem) {
        this.foreignEngineSystem = foreignEngineSystem;
    }

    public void startEngine(){
        foreignEngineSystem.activate();
    }
    public void stopEngine(){
        foreignEngineSystem.shutdown();
    }
}
public class Main {
    public static void main(String[] args) {
        ForeignEngineSystem fSys = new ForeignEngineSystem();
        EngineController fea = new ForeignEngineAdapter(fSys);
        fea.startEngine();
        fea.stopEngine();
    }
}