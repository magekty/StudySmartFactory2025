
import { useState } from "react";
import "./Accordion.css";

const Accordion = ({items})=>{
    const [activeIndex, setActiveIndex] =useState(null);
    const onClick =(index)=>{
        if(activeIndex === index){
            setActiveIndex(null) //닫기
        }else{
            setActiveIndex(index) //열기
        }
    }
    return(
        <div className="accordion">
            {items.map( (item, index) =>(
                <div key={item.title} className="accordion-item">
                    <div className="accordion-header" onClick={()=>onClick(index)}>
                        <h2>{item.title}</h2>
                        <span>{activeIndex=== index ? '-' : '+'}</span>
                    </div>
                    <div 
className={`accordion-content ${activeIndex === index ? 'open' : ''}`}>
    <p>{item.content}</p></div>
                </div>
            ))}
        </div>

    )
}
export default Accordion;