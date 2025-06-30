import "./App.css";
import { useState } from "react";
// import Level1 from "./Level1";
// props drilling: 너무 깊어지면 깜빡임
//              => 전역 관라(React내장: useContext, 3rd party: redux)

const Level5 = ({ count }) => {
  console.log("5 Level");
  return (
    <div style={{ border: "1px solid black", padding: "10px" }}>
      <h2>Level 5 child</h2>
      <p>count: {count}</p>
    </div>
  );
};

const Level4 = ({ count }) => {
  console.log("4 Level");
  return (
    <div style={{ border: "1px solid black", padding: "10px" }}>
      <h2>Level 4 child</h2>
      <Level5 count={count} />
    </div>
  );
};

const Level3 = ({ count }) => {
  console.log("3 Level");
  return (
    <div style={{ border: "1px solid black", padding: "10px" }}>
      <h2>Level 3 child</h2>
      <Level4 count={count} />
    </div>
  );
};

const Level2 = ({ count }) => {
  console.log("2 Level");
  return (
    <div style={{ border: "1px solid black", padding: "10px" }}>
      <h2>Level 2 child</h2>
      <Level3 count={count} />
    </div>
  );
};

const Level1 = ({ count }) => {
  console.log("1 Level");
  return (
    <div style={{ border: "1px solid black", padding: "10px" }}>
      <h2>Level 1 child</h2>
      <Level2 count={count} />
    </div>
  );
};

const App = () => {
  const [count, setCount] = useState(0);
  const inc = () => {
    setCount(count + 1);
  };
  // 동적인 코드
  return (
    <div className="App" style={{ border: "1px solid black", padding: "10px" }}>
      <h1>Top level: App</h1>
      <button style={{ padding: "10px" }} onClick={inc}>
        +
      </button>
      <Level1 count={count} />
    </div>
  );
};

export default App;
