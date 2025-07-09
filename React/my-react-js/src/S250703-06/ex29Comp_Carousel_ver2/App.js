import React from 'react';
import Carousel from './Carousel';

function App() {
  const imgUrl1 = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPXvGdTz59nT5bgGZFm17RUtGHoi3grrcaNA&s"
  const imgUrl2 = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBXSMW4m0loTApc7QdD9sZvFIgp-37yf4Gnw&s"
  const imgUrl3 = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ60R2DRFgeGVjV-q9limUPubw9j5q7XUCfHg&s"
    
  const pics = [
    imgUrl1, imgUrl2,imgUrl3
  ];

  return (
    <div>
      <Carousel pics={pics} />
    </div>
  );
}

export default App;
