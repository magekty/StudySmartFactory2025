import java.util.List;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {

        ComputerBuilder builder1 = new ComputerBuilder();
        ComputerDirector director1 = new ComputerDirector(builder1);
        director1.Computer1();
        List<Computer> parts1 = builder1.getComputer();

        ComputerBuilder builder2 = new ComputerBuilder();
        ComputerDirector director2 = new ComputerDirector(builder2);
        director2.Computer2();
        List<Computer> parts2 = builder2.getComputer();
        ComponentNode root = new ComponentNode("Computer");


        ComponentNode computer1Node = new ComponentNode("조립1 PC");
        for (Computer part : parts1) {
            computer1Node.addChild(part);
        }

        ComponentNode computer2Node = new ComponentNode("조립2 PC");
        for (Computer part : parts2) {
            computer2Node.addChild(part);
        }

        root.addChild(computer1Node);
        root.addChild(computer2Node);

        Scanner sc = new Scanner(System.in);
        boolean isRunning = true;
        int pcNumber = 1;
        while(isRunning){
            System.out.println("======= 1. 생성된 PC 목록");
            System.out.println("======= 2. Custom PC 추가");
            System.out.println("======= 9. 종료");
            int choice = sc.nextInt();

            switch (choice){
                case 1:
                    root.print(0);
                    break;
                case 2:
                    String pcName = "NEW CUSTOM PC " + pcNumber++;
                    String newRAM, newCPU, newHDD, newSSD;
                    sc.nextLine();
                    System.out.printf("CPU: "); newCPU = sc.nextLine();
                    System.out.printf("RAM: "); newRAM = sc.nextLine();
                    System.out.printf("SSD: "); newSSD = sc.nextLine();
                    System.out.printf("HDD: "); newHDD = sc.nextLine();

                    ComputerBuilder customBuilder = new ComputerBuilder();
                    ComputerDirector customDirector = new ComputerDirector(customBuilder,newCPU,newRAM,newSSD,newHDD);
                    ComponentNode customPC = new ComponentNode(pcName);

                    List<Computer> customParts = customBuilder.getComputer();
                    for(Computer parts : customParts){
                        customPC.addChild(parts);
                    }
                    root.addChild(customPC);
                    break;

                case 9:
                    isRunning = false;
                    break;
            }

        }

    }
}


