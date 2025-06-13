package compositeComponent;
import java.util.ArrayList;
import java.util.List;
public class CompositeComponent implements Component {
    private String name;
    private List<Component> components = new ArrayList<>();

    public CompositeComponent(String name) {
        this.name = name;
    }

    public void add(Component component) {
        components.add(component);
    }

    public void remove(Component component) {
        components.remove(component);
    }

    @Override
    public void showDetails(String indent) {
        System.out.println(indent + "+ " + name);
        for (Component c : components) {
            c.showDetails(indent + "   ");
        }
    }
}