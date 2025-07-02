import "./App.css";
import Button from "./Button";
const App = () => {
  const onClick = () => {
    alert("Button clicked");
  };
  return (
    <div className="App">
      <h1>리액트 컴포넌트 - 일반 버튼</h1>
      <Button isDisabled={false} label="Click me" onClick={onClick} />
      <Button isDisabled={true} label="Not allow" onClick={onClick} />
    </div>
  );
};

export default App;
