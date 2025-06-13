package compositeComponent;

// Leaf 부품 클래스들
public class RAM implements Component {
    private String spec;

    public RAM(String spec) {
        this.spec = spec;
    }

    @Override
    public void showDetails(String indent) {
        System.out.println(indent + "- RAM: " + spec);
    }
}
