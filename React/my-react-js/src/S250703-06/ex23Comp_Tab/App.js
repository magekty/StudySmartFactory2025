
import Tabs from './Tabs';

const App=()=>{
    const tabs = [
        {  label: "Tab1", content: <p>Tab1의 내용</p>    },
        {  label: "Tab2", content: <p>Tab2의 내용</p>    },
        {  label: "Tab3", content: <p>Tab3의 내용</p>    },
    ];
    return(
        <div className="tabc-app">
            <Tabs tabs={tabs}/>
        </div>
    )

}

export default App;