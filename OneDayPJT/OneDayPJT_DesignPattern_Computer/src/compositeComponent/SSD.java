package compositeComponent;

public class SSD implements Component {
    private String spec;

    public SSD(String spec) {
        this.spec = spec;
    }

    @Override
    public void showDetails(String indent) {
        System.out.println(indent + "- SSD: " + spec);
    }
}
