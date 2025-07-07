import React from "react";
import ReactDOM from "react-dom/client";
import "./index.css";
// import App from './App';
// import App from "./S250627/ex3Todo/App";
// import App from "./S250627/ex4useEffect/App";
// import App from "./S250630/ex5LifeCycle/App";
// import App from "./S250630/ex6Reduser/App";
// import App from "./S250630/ex7PropsDrillingBasic/App";
// import App from "./S250630/ex9PropsDrillingRedux/App";
// import App from "./S250630/ex10Route1/App";
// import App from "./S250630/ex11Diary(CustomHook)/App";
// import App from "./S250702/ex12Comp_Button/App";
// import App from "./S250702/ex13Comp_IconButton/App";
// import App from "./S250702/ex14Comp_LoadingButton/App";
// import App from "./S250707/ex30Comp_Chartjs/App";
// import App from "./S250707/ex31Comp_ChartDashboard/App";
// import App from "./S250707/ex32Comp_ML_iris_분류/App";
import App from "./S250707/ex33Comp_ML_선형회귀/App";

import reportWebVitals from "./reportWebVitals";

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
