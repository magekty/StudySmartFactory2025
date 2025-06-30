// JS 배열의 reduce
// let data = [1,2,3,4,5];
// let sum2 = data.reduce((total, now)=> total + now, 0);

import { useReducer } from "react";
import "./CounterUseReducer.css";

const initialState = { count: 0 };
const reducer = (state, action) => {
  switch (action.type) {
    case "increment":
      return { count: state.count + 1 };
    case "decrement":
      return { count: state.count - 1 };
    default:
      throw new Error();
  }
};

const Counter = () => {
  const [state, dispatch] = useReducer(reducer, initialState);
  // 동적인 코드
  return (
    <div>
      <p>Count: {state.count}</p>
      <button onClick={() => dispatch({ type: "increment" })}>증가</button>
      <button onClick={() => dispatch({ type: "decrement" })}>감소</button>
    </div>
  );
};

export default Counter;
