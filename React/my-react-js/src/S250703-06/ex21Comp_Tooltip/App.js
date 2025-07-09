
import Tooltip from "./Tooltip";

const App = ()=>{
    return(
        <div className="Tootip-app"
            style={{textAlign:"center", margin:"100px"}}>
            <Tooltip text="일반적인 툴 팁">
                <button>내 위에 마우스 대봐</button>
            </Tooltip>
            <br/><br/>
            <Tooltip text="오른쪽에 뜨는 툴 팁" position="right">
                <span>내 위에 마우스 대봐</span>
            </Tooltip>
        </div>
    )
}

export default App;