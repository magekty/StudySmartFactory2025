import { useState, useEffect } from "react";
const Child = () => {
  const [count, setCount] = useState(0);
  const [name, setName] = useState("");

  useEffect(() => {
    console.log("Component Mounted");
    return () => {
      console.log("Component will unmounted");
    };
  }, []);
  useEffect(
    () => console.log("Count state changed:", count),

    [count]
  );
  useEffect(
    () => console.log("Count state changed:", count, name),

    [count, name]
  );
  const inc = () => {
    setCount(count + 1);
  };
  const onNameChange = (event) => {
    setName(event.target.value);
  };
  return (
    <div>
      <button onClick={inc}>+</button>
      <input type="text" value={name} onChange={onNameChange} />
      <p>Count: {count}</p>
      <p>Name: {name}</p>
    </div>
  );
};

export default Child;
