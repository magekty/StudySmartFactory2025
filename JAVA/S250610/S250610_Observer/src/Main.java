import java.util.ArrayList;
import java.util.List;

// Observer: 상태 변화를 여러 구독자(등록된 대상)에게 자동으로 통지
// 스프링 부트 서버: @EvertListener
interface Observer{void onStatusChanged(String status);}

class ProductionLine{
    private List<Observer> observers = new ArrayList<>();
    private String status;
    public void register(Observer obs){observers.add(obs);}
    public void unregister(Observer obs){observers.remove(obs);}
    public void changeStatus(String status){
        this.status = status;
        System.out.println("생산 라인의 상태가 변경됨: " + status);
        notifyObservers();
    }
    public void notifyObservers() {
        for(Observer obs : observers){obs.onStatusChanged(status);}
    }
}
class QADept implements Observer{
    public void onStatusChanged(String status){
        if(status.equals("조립 완료")||status.equals("도장 완료")){
            System.out.println("[품질팀] 검사 준비: " + status);
        }
    }
}
class LogisticsDept implements Observer{
    public void onStatusChanged(String status){
        if(status.equals("출고 준비 완료")){
            System.out.println("[물류팀] 출고 준비: " + status);
        }
    }
}
class ManagerDashboard implements Observer{
    public void onStatusChanged(String status){
        System.out.println("[관리자] 상태 변화: " + status);
    }
}
public class Main {
    public static void main(String[] args) {
        ProductionLine line = new ProductionLine();
        Observer qa = new QADept();
        Observer logisitis = new LogisticsDept();
        Observer manager = new ManagerDashboard();

        line.register(qa);
        line.register(logisitis);
        line.register(manager);
        
        line.changeStatus("조립 완료");     // 품질, 매니저
        line.changeStatus("도장 완료");     // 품질, 매니저
        line.changeStatus("출고 준비 완료");  // 물류팀, 매니저
    }
}