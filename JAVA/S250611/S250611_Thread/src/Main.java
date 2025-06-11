// Threading
import java.awt.Toolkit;
import java.security.spec.ECField;

class BeepTask implements Runnable{
    public void run(){
        Toolkit toolkit = Toolkit.getDefaultToolkit();
        for (int i = 0; i < 5; i++) {
            toolkit.beep();
            //System.out.println("똥");
            try {
                Thread.sleep(500);
            }catch (Exception e){}
        }
    }

}
public class Main {
    public static void main(String[] args) {
        Runnable beepTask = new BeepTask();
        Thread thread = new Thread(beepTask);
        thread.start();
        for (int i = 0; i <5; i++) {
            System.out.println("띵");
        }
    }
}