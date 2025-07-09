
import GroupButton from "./GroupButton";

const App = ()=>{
    const buttons = [
        {label:"Left", onClick: ()=>alert("left 클릭됨")},
        {label:"Center", onClick: ()=>alert("Center 클릭됨")},
        {label:"Right", onClick: ()=>alert("Right 클릭됨")}
    ]
    return(
        <GroupButton buttons={buttons}/>
    )
}
export default App;