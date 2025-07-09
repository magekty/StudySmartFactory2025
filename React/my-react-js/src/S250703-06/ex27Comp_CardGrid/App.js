
import CardGrid from './CardGrid';

const App = ()=>{
    const imgUrl1 = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSg_yGdageXyKz0Po7w5i6eojf3bHEOw9IEDQ&s";
    const imgUrl2 = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQppoA0k5PKdMBgygvlDGFgdpc3IqSfLAouvw&s";
    const imgUrl3 = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXzNQgD2H_6AgzYsSPvGUqNhIHnndBaP7u_Q&s";
    const imgUrl4 = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS72Ams9iPo4Tq9HnIwewzKQbIOHKg4vYo8Fg&s";
    const imgUrl5 = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiJhvJfHwK32pAC4BbyGO6JfV1Z-r0OssTLA&s";

    const cards = [
        { image:imgUrl1, title:"제목1", desc:"내용1" },
        { image:imgUrl2, title:"제목2", desc:"내용2" },
        { image:imgUrl3, title:"제목3", desc:"내용3" },
        { image:imgUrl4, title:"제목4", desc:"내용4" },
        { image:imgUrl5, title:"제목5", desc:"내용5" },
    ]
    return( <CardGrid items={cards}/>  )
}
export default App;