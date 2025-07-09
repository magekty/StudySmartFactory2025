import React, { useState } from 'react';
import './Carousel.css';

export default function Carousel({ pics }) {
  const [index, setIndex] = useState(0);

  const handleLeft = () => {
    setIndex(prev => (prev - 1 + pics.length) % pics.length);
  };

  const handleRight = () => {
    setIndex(prev => (prev + 1) % pics.length);
  };

  return (
    <div className="carousel-wrapper">
      <p>이미지 캐러셀입니다. 좌우 화살표를 눌러 보세요</p>
      <div
        className="carousel-container"
        style={{ backgroundImage: `url(${pics[index]})` }}
      >
        <div className="carousel-arrow" onClick={handleLeft}>&lang;</div>
        <div className="carousel-arrow" onClick={handleRight}>&rang;</div>
      </div>
    </div>
  );
}
