package computerAssemble;

import computerAssemble.computer.*;
import java.util.ArrayList;
import java.util.List;


/// ///////////////////////////////////////////////
//TIP 코드를 <b>실행</b>하려면 <shortcut actionId="Run"/>을(를) 누르거나
// 에디터 여백에 있는 <icon src="AllIcons.Actions.Execute"/> 아이콘을 클릭하세요.


// 한선경, 최혜원
public class ComputerBuilder {
    private List<Computer> ComputerParts = new ArrayList<>();

    public void addCPU(String model) {
        ComputerParts.add(new CPU(model));
    }

    public void addRAM(String model) {
        ComputerParts.add(new RAM(model));
    }

    public void addHDD(String model) {
        ComputerParts.add(new HDD(model));
    }

    public void addSSD(String model) {
        ComputerParts.add(new SDD(model));
    }

    public List<Computer> getComputer() {
        return ComputerParts;
    }

}

