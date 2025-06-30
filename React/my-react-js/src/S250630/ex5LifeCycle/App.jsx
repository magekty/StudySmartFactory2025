import "./App.css";
import LifeCycleSample from "./component/LifeCycleSample";
import { useState } from "react";

const App = () => {
  const [color, setColor] = useState("#000000");
  const getRandomColor = () => {
    // console.log("#" + (Math.random() * 255 * 255 * 255 - 1).toString(16));
    return "#" + Math.floor(Math.random() * 255 * 255 * 255 - 1).toString(16);
  };
  const randomClick = () => {
    setColor(getRandomColor());
  };
  return (
    <div>
      <button onClick={randomClick}>랜덤 색상 만들자</button>
      <LifeCycleSample color={color} />
    </div>
  );
};

export default App;
