import "./App.css";
import IconButton from "./IconButton";
import { FaPlus } from "react-icons/fa";

const App = () => {
  const onClick = () => {
    alert("IconButton Clicked");
  };
  return (
    <div className="IconButton-app">
      <IconButton
        icon={<FaPlus />}
        label="Add Item"
        onClick={onClick}
        isDiabled={false}
      />
      <IconButton
        icon={<FaPlus />}
        label="Add Item"
        onClick={onClick}
        isDiabled={true}
      />
    </div>
  );
};

export default App;
