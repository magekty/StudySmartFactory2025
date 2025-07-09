import Carousel from './Carousel';
const App = ()=>{
    const imgUrl1 = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPXvGdTz59nT5bgGZFm17RUtGHoi3grrcaNA&s"
    const imgUrl2 = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBXSMW4m0loTApc7QdD9sZvFIgp-37yf4Gnw&s"
    const imgUrl3 = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ60R2DRFgeGVjV-q9limUPubw9j5q7XUCfHg&s"
    const slides = [
        {image:imgUrl1, caption:"Slide 1"},
        {image:imgUrl2, caption:"Slide 2"},
        {image:imgUrl3, caption:"Slide 3"},
    ]
    return(
        <div className='carousel-app'>
            <h2 style={{textAlign:"center"}}>캐러셀</h2>
            <Carousel items={slides} autoPlay interval={3000} />
        </div>
    )
}
export default App;