
import Accordion from "./Accordion";

const App = ()=>{
    const items =[
        {  title: "Title 1",content: "내용1" },
        {  title: "Title 2",content: "내용2" },
        {  title: "Title 3",content: "내용3" },
    ];
    return (
        <div className="accordion-app">
            <Accordion items={items}/>
        </div>
    )
}

export default App;