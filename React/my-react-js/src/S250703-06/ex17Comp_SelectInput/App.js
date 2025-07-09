
import SelectInput from "./SelectInput";
import {useState} from 'react';

const App = ()=> {
    const [fruit, setFruit] = useState('')
    const options = [
        {value: 'apple', label:"Apple"}, 
        {value: 'banana', label:"Banana"}, 
        {value: 'orange', label:"Orange"}
    ]
    const onChange = (event)=>{
        setFruit(event.target.value)}
    return(
        <SelectInput
            label="Favorite Fruit"
            name="fruit" value={fruit}
            onChange={onChange} options={options}
        />
    )
}
export default App;