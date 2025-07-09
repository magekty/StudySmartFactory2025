import "./ProgressBar.css";

const ProgressBar = ({value, color})=>{
    const max = 100;
    const percentage = Math.min(Math.max(value, 0), max) / max * 100;
    return(
        <div className="progress-bar">
            <div className={`progress-fill progress-${color}`}
            style={{width:`${percentage}%`}}></div>
            <span className="progress-label">{percentage.toFixed(0)}%</span>
        </div>
    )
}
export default ProgressBar;