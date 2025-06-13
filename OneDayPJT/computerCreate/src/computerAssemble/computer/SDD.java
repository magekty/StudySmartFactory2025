package computerAssemble.computer;


public class SDD implements Computer{
    private String sddModel;
    public SDD(String sddModel){
        this.sddModel = sddModel;
    }
    public void showDetails(){
        System.out.println("SDD : " + sddModel);
    }
}

