import { useState } from "react";
import "./App.css";
import LoadingButton from "./LoadingButton";

const App = () => {
  const [loading, setLoading] = useState(false);
  const onClick = () => {
    setLoading(true);
    setTimeout(() => setLoading(false), 10000);
  };
  return (
    <div className="App">
      <LoadingButton label="제출" onClick={onClick} loading={loading} />
    </div>
  );
};

export default App;
