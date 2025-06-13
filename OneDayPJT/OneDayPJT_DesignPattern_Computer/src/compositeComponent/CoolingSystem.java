package compositeComponent;

public class CoolingSystem implements Component {
    private String spec;

    public CoolingSystem(String spec) {
        this.spec = spec;
    }

    @Override
    public void showDetails(String indent) {
        System.out.println(indent + "- Cooling System: " + spec);
    }
}
