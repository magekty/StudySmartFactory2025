public class ComputerDirector {
    private ComputerBuilder builder;

    public ComputerDirector(ComputerBuilder builder) {
        this.builder = builder;
    }

    public ComputerDirector(ComputerBuilder builder, String cpuModel,String ramModel,String ssdModel,String hddModel){
        this.builder = builder;
        CustomPC(cpuModel, ramModel, ssdModel, hddModel);
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

    public void CustomPC(String cpuModel,String ramModel,String ssdModel,String hddModel){
        builder.addCPU(cpuModel);
        builder.addRAM(ramModel);
        builder.addSSD(ssdModel);
        builder.addHDD(hddModel);
    }

}