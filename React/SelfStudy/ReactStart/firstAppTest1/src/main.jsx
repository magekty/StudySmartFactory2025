import ReactDOM from "react-dom/client";
import { StrictMode } from "react";
// import { createRoot } from "react-dom/client";
import "./index.css";
import App from "./App";
import MyForm from "./chapter08/MyForm.jsx";
import MyList from "./chapter08/MyList.jsx";
import MyTable from "./chapter08/MyTable.jsx";
import HelloComponent from "./chapter09/HelloComponent";

const container = document.getElementById("root");
const root = ReactDOM.createRoot(container);
// root.render(<App />);
root.render(<MyForm />);
// root.render(<MyList />);
// root.render(<HelloComponent />);
// root.render(<MyTable />);

// createRoot(document.getElementById("root")).render(
//   <StrictMode>
//     <App />
//     {/* <MyForm />
//     <MyList /> */}
//     <MyTable />
//   </StrictMode>
// );
