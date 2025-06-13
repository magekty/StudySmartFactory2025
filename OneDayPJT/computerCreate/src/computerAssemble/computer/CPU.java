package computerAssemble.computer;

public class CPU implements Computer {
    private String cpuModel;

    public CPU(String cpuModel) {
        this.cpuModel = cpuModel;
    }

    public void showDetails() {
        System.out.println("CPU : " + cpuModel);
    }
}
