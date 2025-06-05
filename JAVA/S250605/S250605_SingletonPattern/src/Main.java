class PlantManager{
    private static PlantManager instance;
    private PlantManager(){System.out.println("관리자 시스템 초기화");}
    public static PlantManager getInstance(){
        if(instance == null) { instance = new PlantManager();}
        return instance;
    }
    public void startDailyCheck(){System.out.println("매일 하는 공장 체크 시작!");}
    public void endFactory(){instance= null; System.out.println("공장 폐업!"); }
    int count = 0;
    public void dailyCheck(){count++; System.out.println(count+"번째 매일 체크");}
}
class Test{}
public class Main {
    public static void main(String[] args) {
        // Singleton : 자동차 제조 회사에서 공장 설비를 관리하는 중앙 설비 관리자는 단 하나만 존재 해야 한다
        // Singleton기법은 단 하나의 객체만 생성 되도록 강제
        /*
        PlantManager p1 =new PlantManager();
        PlantManager p2 =new PlantManager();
        */
        PlantManager manager = PlantManager.getInstance();
        PlantManager managerAgain = PlantManager.getInstance();
        Test t1 = new Test();Test t2 = new Test();
        System.out.println("manager 둘은 같나?"+(manager == managerAgain));
        System.out.println("Test 둘은 같나?"+(t1 == t2));
        manager.startDailyCheck();
        managerAgain.startDailyCheck();
        manager.endFactory();
        managerAgain.startDailyCheck();
        manager.dailyCheck(); managerAgain.dailyCheck();
        manager.endFactory();
        System.out.println(PlantManager.getInstance() == null);
    }
}