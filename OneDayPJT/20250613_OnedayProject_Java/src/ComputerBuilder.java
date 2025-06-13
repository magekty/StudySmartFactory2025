import java.util.ArrayList;
import java.util.List;

public class ComputerBuilder {
    private List<Computer> ComputerParts = new ArrayList<>();

    public void addCPU(String model) {
        ComputerParts.add(new CPU(model));
    }

    public void addRAM(String model) {
        ComputerParts.add(new RAM(model));
    }

    public void addHDD(String model) {
        ComputerParts.add(new HDD(model));
    }

    public void addSSD(String model) {
        ComputerParts.add(new SDD(model));
    }

    public List<Computer> getComputer() {
        return ComputerParts;
    }

}