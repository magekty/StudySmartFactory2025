// Proxy (대리)
interface Engine{void start();}
class RealEngine implements Engine{
    public RealEngine() {
        costWork();
    }
    private void costWork(){
        System.out.println("real engine은 시동 거는데 시간이 필요해요 ");
        try {
            Thread.sleep(5000);
        }catch (InterruptedException e){}
    }

    @Override
    public void start() {
        System.out.println("real engine working");
    }
}
class ProxyEngine implements Engine{
    private RealEngine realEngine;
    private boolean mode;
    public ProxyEngine(boolean mode) {
        this.mode = mode;
    }

    @Override
    public void start() {
        if(this.mode){
            System.out.println("[프록시 적용 중] real engine대신에 proxy(motor) 돌릴게요");
        }else{
            if(realEngine == null){ realEngine = new RealEngine();}
            realEngine.start();
        }
    }
}
public class Main {
    public static void main(String[] args) {
        Engine proxyEngine = new ProxyEngine(true);
        Engine realEngine = new ProxyEngine(false);
        System.out.println("테스트 엔진 시작");
        proxyEngine.start();
        System.out.println("리얼 엔진 시작");
        realEngine.start();
    }
}