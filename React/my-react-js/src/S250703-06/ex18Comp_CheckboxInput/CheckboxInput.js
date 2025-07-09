import "./CheckboxInput.css";

const CheckboxInput =({label, name, checked, onChange})=>{
    return(
        <label className="checkbox-wrapper">
            <input type="checkbox" name={name} 
            checked={checked} onChange={onChange}/>
            <span className="checkbox-label">{label}</span>
        </label>

    )
}
export default CheckboxInput;