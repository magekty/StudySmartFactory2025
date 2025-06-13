package compositeComponent;

public class GPU implements Component {
    private String spec;

    public GPU(String spec) {
        this.spec = spec;
    }

    @Override
    public void showDetails(String indent) {
        System.out.println(indent + "- GPU: " + spec);
    }
}
