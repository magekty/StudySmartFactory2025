
import './CardGridInfinite.css'
import Card from './Card'
import { useState, useEffect, useRef } from 'react';

const CardGridInfinite = ()=>{

    const [items, setItems] = useState([]);
    const [page, setPage] = useState(1);
    const loader = useRef(null);

    useEffect(()=>{
        const observer = new IntersectionObserver(
            entries =>{
                if(entries[0].isIntersecting){setPage(prev=>prev+1)}
            }, {threshold:1}
        )
        if(loader.current) observer.observe(loader.current);
        return ()=>{if(loader.current) observer.unobserve(loader.current);}
    }, [])
    
    useEffect( ()=>{
        fetchMore();
    }, [page])

    const fetchMore = () => {
        const newItems = Array.from({length:6}).map( (item, index)=>({
            image: "나중에 이미지 경로 넣기",
            title: `Card ${page*6 + index}`,
            desc: `내용 ${page*6 + index}`
        }));
        setItems(prev=>[...prev, ...newItems])
    }
    

    return(
        <div className='card-grid-infinite-app'>
            <div className='card-grid'>
                {items.map((item, index)=>(
                    <Card key={index} image={item.image}
                    title={item.title} desc={item.desc}
                    >
                        <button>children test</button>
                    </Card>
                ))}
            </div>
            <div ref={loader} style={{backgroundColor:"orange", textAlign:"center"}}>
                <p>loading more(더 보기)</p>
            </div>
        </div>
    )
}
export default CardGridInfinite;