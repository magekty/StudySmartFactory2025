import computerAssemble.*;
import computerAssemble.computer.*;

import java.util.List;


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

        ComponentNode computer = new ComponentNode("Computer"); // 노드 이름

        ComponentNode computer1Node = new ComponentNode("조립1 PC");
        for (Computer part : parts1) {
            computer1Node.addChild(part);
        }

        ComponentNode computer2Node = new ComponentNode("조립2 PC");
        for (Computer part : parts2) {
            computer2Node.addChild(part);
        }

        computer.addChild(computer1Node);
        computer.addChild(computer2Node);
        computer.print(0);

        // 컴포넌트 트리 구성
        ComponentNode root = new ComponentNode("Gaming PC");

        ComponentNode motherboard = new ComponentNode("Motherboard");
        motherboard.addChild(new CPU("Intel i9-13900K"));
        motherboard.addChild(new RAM("32GB DDR5"));

        ComponentNode storage = new ComponentNode("Storage");
        storage.addChild(new HDD("Seagate 2TB"));
        storage.addChild(new SDD("Samsung 1TB"));

        ComponentNode peripherals = new ComponentNode("Peripherals");
        peripherals.addChild(new ComponentNode("Monitor"));
        peripherals.addChild(new ComponentNode("Keyboard"));
        peripherals.addChild(new ComponentNode("Mouse"));

        root.addChild(motherboard);
        root.addChild(storage);
        root.addChild(peripherals);

        // 출력
        root.print(0);


    }
}

