import "./App.css";
import Counter from "./CounterUseReducer";
// import Counter from "./CounterUseState";

const App = () => {
  // 동적인 코드
  return (
    <div className="App">
      <Counter />
    </div>
  );
};

export default App;
