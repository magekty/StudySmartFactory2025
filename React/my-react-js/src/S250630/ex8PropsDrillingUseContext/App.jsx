import { useState, createContext, useContext } from "react";
import "./App.css";
const CountContext = createContext();
const useCount = () => useContext(CountContext);
const CountProvider = ({ children }) => {
  const [count, setCount] = useState(0);
  const increment = () => {
    setCount((prevCount) => prevCount + 1);
  };
  return (
    <CountContext.Provider value={{ count, increment }}>
      {children}
    </CountContext.Provider>
  );
};
const Level1 = () => {
  const { increment } = useCount();
  return (
    <div style={{ border: "1px solid black", padding: "20px" }}>
      <h2>Level1</h2>
      <button onClick={increment}> + </button>
      <Level2 />
    </div>
  );
};
const Level2 = () => {
  return (
    <div style={{ border: "1px solid black", padding: "20px" }}>
      <h2>Level2</h2>
      <Level3 />
    </div>
  );
};
const Level3 = () => {
  return (
    <div style={{ border: "1px solid black", padding: "20px" }}>
      <h2>Level3</h2>
      <Level4 />
    </div>
  );
};

const Level4 = () => {
  return (
    <div style={{ border: "1px solid black", padding: "20px" }}>
      <h2>Level4</h2>
      <Level5 />
    </div>
  );
};

const Level5 = () => {
  const { count } = useCount();
  return (
    <div style={{ border: "1px solid black", padding: "20px" }}>
      <h2>Level5</h2>
      <p>Count: {count}</p>
    </div>
  );
};

const App = () => {
  // 동적인 코드
  return (
    <CountProvider>
      <div className="App">
        <h1>Top level: Context API</h1>
        <Level1 />
      </div>
    </CountProvider>
  );
};

export default App;
