package compositeComponent;

public class CPU implements Component {
    private String spec;

    public CPU(String spec) {
        this.spec = spec;
    }

    @Override
    public void showDetails(String indent) {
        System.out.println(indent + "- CPU: " + spec);
    }
}
