import { useEffect, useState } from 'react'
import './Carousel.css'


const Carousel = ({items, autoPlay = true, interval})=>{
    const [currentIndex, setCurrentIndex] = useState(0)
    const prev = ()=>{
        setCurrentIndex((prev)=>(prev-1 + items.length) % items.length)
    }
    const next = ()=> { 
        setCurrentIndex((prev)=>(prev+1)% items.length)
    }
    useEffect( ()=>{
        if(!autoPlay) return;
        const timer = setInterval(next, interval);
        return ()=>clearInterval(timer);
    },[currentIndex, autoPlay, interval]

    )

    return(
        <div className='carousel'>
            <button className='carousel-btn left' onClick={prev}>&lt;</button>
            <div className='carousel-slide'>
            {items.map((item, index)=>(
                <div key={index} 
                className={`carousel-item ${index === currentIndex ? "active" : ""}`}>
                    <img src={item.image} />
                </div>  
            ))}
            </div>
            <button className='carousel-btn right' onClick={next}>&gt;</button>
        </div>

    )
}

export default Carousel;