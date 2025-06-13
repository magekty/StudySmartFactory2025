import compositeComponent.*;
public class Main {
    public static void main(String[] args) {
        // 부품 생성
        Component ram1 = new RAM("DDR4 8GB");
        Component ram2 = new RAM("DDR4 8GB");
        Component gpu = new GPU("NVIDIA RTX 4060");
        Component cpu = new CPU("Intel i7 12700K");
        Component hdd = new HDD("1TB 7200RPM");
        Component ssd = new SSD("512GB NVMe");
        Component psu = new PowerSupply("750W 80+ Gold");
        Component cooling = new CoolingSystem("Liquid Cooler 240mm");

        // 서브 컴포넌트 생성
        CompositeComponent memorySlot = new CompositeComponent("Memory Slot");
        memorySlot.add(ram1);
        memorySlot.add(ram2);

        CompositeComponent storage = new CompositeComponent("Storage");
        storage.add(hdd);
        storage.add(ssd);

        CompositeComponent motherboard = new CompositeComponent("Motherboard");
        motherboard.add(cpu);
        motherboard.add(gpu);
        motherboard.add(memorySlot);
        motherboard.add(storage);

        // 전체 컴퓨터
        CompositeComponent computer = new CompositeComponent("Gaming Computer");
        computer.add(motherboard);
        computer.add(psu);
        computer.add(cooling);

        // 출력
        computer.showDetails("");
    }
}