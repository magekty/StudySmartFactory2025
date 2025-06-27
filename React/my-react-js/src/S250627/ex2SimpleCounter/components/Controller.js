const Controller = ({ handleSetCountProp }) => {
  return (
    <div>
      <button onClick={() => handleSetCountProp(-1)}>-1</button>
      <button onClick={() => handleSetCountProp(-10)}>-10</button>
      <button onClick={() => handleSetCountProp(-100)}>-100</button>
      <button onClick={() => handleSetCountProp(100)}>100</button>
      <button onClick={() => handleSetCountProp(10)}>10</button>
      <button onClick={() => handleSetCountProp(1)}>1</button>
    </div>
  );
};
export default Controller;
