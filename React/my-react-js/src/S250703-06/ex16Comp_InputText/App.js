import { useState } from "react";
import InputText from "./InputText";

const App = () => {
  const [name, setName] = useState("");
  const [error, setError] = useState("");
  const onChange = (event) => {
    setName(event.target.value);
    if (event.target.value.length < 3) setError("3글자 이상 입력하세요");
    else setError("");
  };
  return (
    <div>
      <p>입력 내용: {name}</p>
      <InputText
        label="Name"
        name="username"
        value={name}
        onChange={onChange}
        error={error}
        placeholder="이름을 입력하세요"
      />
    </div>
  );
};
export default App;
