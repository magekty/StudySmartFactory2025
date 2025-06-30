import { createStore } from "redux";
import { Provider, connect } from "react-redux";
const increment = () => {
  return { type: "INCREMENT" };
};
const Level1 = ({ value, increment }) => {
  return (
    <div style={{ border: "1px solid black", padding: "10px" }}>
      <h1>Level1</h1>
      <div>Value: {value}</div>
      <button onClick={increment}>+</button>
      <Level2 />
    </div>
  );
};
const Level2 = () => {
  return (
    <div style={{ border: "1px solid black", padding: "10px" }}>
      <h1>Level2</h1>
      <Level3 />
    </div>
  );
};
const Level3 = () => {
  return (
    <div style={{ border: "1px solid black", padding: "10px" }}>
      <h1>Level3</h1>
      <Level4 />
    </div>
  );
};
const Level4 = () => {
  return (
    <div style={{ border: "1px solid black", padding: "10px" }}>
      <h1>Level4</h1>
      <Level5Connected />
    </div>
  );
};
const Level5 = ({ value }) => {
  return (
    <div style={{ border: "1px solid black", padding: "10px" }}>
      <h1>Level5</h1>
      <p>Level5: {value}</p>
    </div>
  );
};
const mapProps = (state) => {
  return { value: state.count };
};
const mapDispatch = {
  increment,
};

const Level5Connected = connect(mapProps)(Level5);
const Level1Connected = connect(mapProps, mapDispatch)(Level1);
const initialstate = { count: 0 };

const reducer = (state = initialstate, action) => {
  switch (action.type) {
    case "INCREMENT":
      return { ...state, count: state.count + 1 };
    default:
      return state;
  }
};
const store = createStore(reducer);
const App = () => {
  // 동적인 코드
  return (
    <Provider store={store}>
      <div className="App">
        <h1>Propd drilling - redux</h1>
        <Level1Connected />
      </div>
    </Provider>
  );
};

export default App;
