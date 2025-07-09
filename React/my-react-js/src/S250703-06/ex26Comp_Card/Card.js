import "./Card.css"

const Card = ({image, title, desc, children}) =>{
    return(
        <div className="card">
            {image&& <div className="card-image">
                <img src={image} alt={title} /></div>}
            <div className="card-content">
                <h2 className="card-title">{title}</h2>
                {desc&& <p className="card-desc">{desc}</p>}
                {children && <div className="card-actions">{children}</div>}
            </div>
        </div>
    )
}
export default Card;