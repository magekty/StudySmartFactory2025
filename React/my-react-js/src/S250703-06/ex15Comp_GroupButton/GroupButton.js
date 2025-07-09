import "./GroupButton.css";

const GroupButton = ({buttons})=>{
    return(
        <div className="group-button-app">
            {
                buttons.map( (btn, index)=>(
                    <button key={index} 
                    className="group-button"
                    onClick={btn.onClick}>{btn.label}</button>
                )
            )}
        </div>
    )
}
export default GroupButton;