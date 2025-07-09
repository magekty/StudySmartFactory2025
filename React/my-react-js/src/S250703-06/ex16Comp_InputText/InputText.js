
import "./InputText.css";
{/* <InputText 
label ="Name" name="username" value={name}
onChange={onChange} error={error}
placeholder="이름을 입력하세요"/> */}
const InputText = ({label, name, value, onChange, error, placeholder})=>{
    return(
        <div className="input-text">
            {label && <label htmlFor={name} className="input-label">{label}</label>}
            <input 
            id ={name} name={name} type="text" 
            className={`input-field ${error ? 'input-error' : ''}`}
            value={value} onChange={onChange} placeholder={placeholder}
            />
            {error && <div className="input-error-message">{error}</div>}
        </div>
    )
}

export default InputText;