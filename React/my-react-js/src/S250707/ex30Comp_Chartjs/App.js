import { useState } from "react";
import MyChart from "./MyChart";
const App = () => {
  const [type, setType] = useState("line"); // Line, Bar, Pie
  return (
    <div
      className="App"
      style={{ maxWidth: "600px", margin: "2rem auto", textAlign: "center" }}
    >
      <h2>chart.js in react</h2>
      <div>
        <button onClick={() => setType("line")}>Line</button>
        <button onClick={() => setType("bar")}>Bar</button>
        <button onClick={() => setType("pie")}>Pie</button>
      </div>
      <MyChart type={type} />
    </div>
  );
};

export default App;
