package computerAssemble;

import computerAssemble.computer.Computer;
import java.util.ArrayList;
import java.util.List;

interface Component {
    void print(int depth);
}

public class ComponentNode implements Component{
    private String name;
    private List<Object> children = new ArrayList<>();

    public ComponentNode(String name) {
        this.name = name;
    }

    public void addChild(Object child) {
        children.add(child);
    }

    public void print(int depth) {
        String init = "  ".repeat(depth);
        System.out.println(init + "[" + name + "]");
        for (Object child : children) {
            if (child instanceof ComponentNode) {
                ((ComponentNode) child).print(depth + 1);
            } else if (child instanceof Computer) {
                System.out.print(init + "  ");
                ((Computer) child).showDetails();
            }
        }
    }
}

