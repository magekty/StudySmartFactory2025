
import RadioInput from './RadioInput';
import { useState } from 'react';
const App = ()=> {
    const [gender, setGender] = useState('');
    return(
        <div className='RadioInput'>
            <RadioInput 
            label ="Male" name="gender" value="male"
            checked={gender==='male'}
            onChange={(event)=>{setGender(event.target.value)}}
            />
            <RadioInput 
            label ="Female" name="gender" value="female"
            checked={gender==='male'}
            onChange={(event)=>{setGender(event.target.value)}}
            />
        </div>
    )
}

export default App;