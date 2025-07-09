
import { useState, useEffect } from "react";
import ProgressBar from "./ProgressBar";

const App = ()=>{
    const [progress1, setProgress1] = useState(0);
    useEffect( ()=>{
        const interval = setInterval(()=>{
            setProgress1((prev)=>{
                if(prev >= 100){clearInterval(interval); return 100;}
                return prev + 10;
            })
        }, 1000)
    },[] )

    return(
        <div style={{width:'400px', margin:"auto"}}>
            <ProgressBar value={progress1} color="primary"/>
            <ProgressBar value={60} color="success"/>
            <ProgressBar value={40} color="warning"/>
            <ProgressBar value={80} color="danger"/>
        </div>
    )
}

export default App;