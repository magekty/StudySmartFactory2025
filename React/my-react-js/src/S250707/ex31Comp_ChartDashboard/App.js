import DashBoard from "./DashBoard";

const App = () => {
  return (
    <div
      className="App"
      style={{ backgroundColor: "#f8f8f8", minHeight: "100vh" }}
    >
      <h2 style={{ textAlign: "center", padding: "2rem" }}>My DashBoard</h2>
      <DashBoard />
    </div>
  );
};

export default App;
