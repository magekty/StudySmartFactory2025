import { useState } from "react";
import "./CounterUseState.css";

const Counter = () => {
  const [count, setCount] = useState(0);
  const inc = () => {
    setCount(count + 1);
  };
  const dec = () => {
    setCount(count - 1);
  };
  // 동적인 코드
  return (
    <div>
      <p>{count}</p>
      <button onClick={inc}>증가</button>
      <button onClick={dec}>감소</button>
    </div>
  );
};

export default Counter;
