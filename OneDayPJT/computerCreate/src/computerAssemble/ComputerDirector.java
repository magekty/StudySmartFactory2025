package computerAssemble;


public class ComputerDirector {
    private ComputerBuilder builder;

    public ComputerDirector(ComputerBuilder builder) {
        this.builder = builder;
    }

    public void Computer1() {
        builder.addCPU("Intel i5");
        builder.addRAM("8GB DDR4");
        builder.addHDD("1TB HDD");
    }

    public void Computer2() {
        builder.addCPU("Intel i9");
        builder.addRAM("32GB DDR5");
        builder.addSSD("2TB SSD");
    }
}

