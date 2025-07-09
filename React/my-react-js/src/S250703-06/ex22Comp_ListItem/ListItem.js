import "./ListItem.css"

const ListItem = ({avatar, icon, title, email, action})=>{
    return(
        <div className="list-item">
            {avatar && <div className="list-avatar">{avatar}</div>}
            {icon && <div className="list-icon">{icon}</div>}
            <div className="list-content">
                <div className="list-title">{title}</div>
                {email && <div className="list-email">{email}</div>}
            </div>
            {action && <div className="list-action">{action}</div>}
        </div>
    )
}
export default ListItem;