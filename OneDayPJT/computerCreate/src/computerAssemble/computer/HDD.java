package computerAssemble.computer;


public class HDD implements Computer{
    private String hddModel;
    public HDD(String hddModel){
        this.hddModel = hddModel;
    }
    public void showDetails(){
        System.out.println("HDD : " + hddModel);
    }
}

