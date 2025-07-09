

import "./CardGrid.css";
import Card from "./Card";

const CardGrid = ({items})=>{
    return(
        <div className="card-grid">
            { items.map( (item, index)=>(
                <Card key={index} image={item.image} 
                title={item.title} desc={item.desc}>
                    <button>Children test</button>
                </Card>
            ))}
        </div>
    )
}

export default CardGrid;