package compositeComponent;

public class PowerSupply implements Component {
    private String spec;

    public PowerSupply(String spec) {
        this.spec = spec;
    }

    @Override
    public void showDetails(String indent) {
        System.out.println(indent + "- Power Supply: " + spec);
    }
}
