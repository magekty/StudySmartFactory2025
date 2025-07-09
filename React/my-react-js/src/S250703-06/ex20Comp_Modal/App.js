

import { useState } from 'react';
import Modal from './Modal';

const App = ()=>{
    const [isOpen, setIsOpen] = useState(false);
    const onClick = ()=>{   setIsOpen(true)  }
    const onClose = ()=>{   setIsOpen(false)  }
    return(
        <div className='Modal-app'>
            <button onClick={onClick}>Open Modal</button>
            <Modal isOpen={isOpen} onClose={onClose}
            title="My modal test">
                <p>이 내용은 모달 창에서 보여지는 내용 임</p>
            </Modal>
        </div>
    )
}
export default App;