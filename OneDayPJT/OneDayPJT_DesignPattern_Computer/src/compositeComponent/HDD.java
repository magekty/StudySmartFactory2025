package compositeComponent;

public class HDD implements Component {
    private String spec;

    public HDD(String spec) {
        this.spec = spec;
    }

    @Override
    public void showDetails(String indent) {
        System.out.println(indent + "- HDD: " + spec);
    }
}
