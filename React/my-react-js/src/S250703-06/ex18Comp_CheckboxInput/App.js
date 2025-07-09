

import { useState } from 'react';
import CheckboxInput from './CheckboxInput';

const App = ()=>{
    const [agree, setAgree] = useState(false);
    const onChange = (event)=>setAgree(event.target.checked);
    return(
        <div className='CheckboxInput'>
            <CheckboxInput 
                label = "I agree to the terms"
                name="agree"
                checked={agree}
                onChange={onChange}/>
        </div>
    )
}
export default App;