import "./SelectInput.css";

const SelectInput = ({label, name, value, onChange, options})=>{
    return(
        <div className="select-input">
            {label && <label htmlFor={name} className="input-label">{label}</label>}
            <select id={name} name={name} className="input-field" value={value} onChange={onChange}>
                <option>-- Select(Fruit) --</option>
                {
                    options.map( (option)=>(
                        <option key={option.value} value={option.value}>{option.label}</option>
                    ))
                }
                {/* <option>-- Select(Juice) --</option>
                {
                    options.map( (option)=>(
                        <option key={option.value} value={option.value}>{option.label}</option>
                    ))
                } */}
            </select>
        </div>
    )
}

export default SelectInput;