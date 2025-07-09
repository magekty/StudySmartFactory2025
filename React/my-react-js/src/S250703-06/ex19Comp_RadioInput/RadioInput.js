import './RadioInput.css'

const RadioInput = ({label, name, value, checked, onChange})=>{
    return(
        <label className='radio-wrapper'>
            <input 
                type="radio" name={name} value={value}
                checked={checked} onChange={onChange}
            />
            <span className='radio-label'>{label}</span>
        </label>
    )
}
export default RadioInput;