package computerAssemble.computer;

public class RAM implements Computer{
    private String ramModel;
    public RAM (String ramModel){
        this.ramModel = ramModel;
    }
    public void showDetails(){
        System.out.println("RAM : " + ramModel);
    }
}