// import { useState } from "react";
// // import reactLogo from "./assets/react.svg";
// // import viteLogo from "/vite.svg";
// import HelloComponent from "./chapter09/HelloComponent";
// import "./App.css";
// import axios from "axios";
// import { error } from "console";
// import { AgGridReact } from "ag-grid-react";
// import "ag-grid-community/styles/ag-grid.css";
// import "ag-grid-community/styles/ag-theme-material.css";
// // import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
// // import Repositories from "./chapter10/Repositories";

// // const queryClient = new QueryClient();

// type Repository = {
//   id: number;
//   full_name: string;
//   html_url: string;
// };

// function App() {
//   //const [count, setCount] = useState(0);
//   const [keyword, setKeyword] = useState("");
//   const [repodate, setRepodate] = useState<Repository[]>([]);

//   const handleClick = () => {
//     axios
//       .get<{ items: Repository[] }>(
//         `https://api.github.com/search/repositories?q=${keyword}`
//       )
//       .then((response) => setRepodate(response.data.items))
//       .catch((err) => console.error(error));
//   };
//   return (
//     <>
//       <div className="App">
//         <input value={keyword} onChange={(e) => setKeyword(e.target.value)} />
//         <button onClick={handleClick}>Fetch</button>
//         <div className="ag-theme-material" style={{ height: 500, width: 850 }}>
//           <AgGridReact rowDate={repodate} />
//         </div>
//       </div>
//       {/* <QueryClientProvider client={queryClient}>
//         <Repositories />
//       </QueryClientProvider> */}
//       {/* <div>
//         <a href="https://vite.dev" target="_blank">
//           <img src={viteLogo} className="logo" alt="Vite logo" />
//         </a>
//         <a href="https://react.dev" target="_blank">
//           <img src={reactLogo} className="logo react" alt="React logo" />
//         </a>
//       </div>
//       <h1>Vite + React</h1>
//       <div className="card">
//         <button onClick={() => setCount((count) => count + 1)}>
//           count is {count}
//         </button>
//         <p>
//           Edit <code>src/App.jsx</code> and save to test HMR
//         </p>
//       </div>
//       <p className="read-the-docs">
//         Click on the Vite and React logos to learn more
//       </p> */}
//     </>
//   );
// }

// export default App;

import React, { useState } from "react";
import axios from "axios";
import { AgGridReact } from "ag-grid-react";
import { ModuleRegistry } from "ag-grid-community";
import { AllCommunityModule } from "ag-grid-community";
import { ColDef } from "ag-grid-community";
import { ICellRendererParams } from "ag-grid-community";
import "ag-grid-community/styles/ag-grid.css";
import "ag-grid-community/styles/ag-theme-material.css";
import "./App.css";

ModuleRegistry.registerModules([AllCommunityModule]);

type Repository = {
  id: number;
  full_name: string;
  html_url: string;
};

function App() {
  const [keyword, setKeyword] = useState("");
  const [repodata, setRepodata] = useState<Repository[]>([]);
  const columnDefs: ColDef[] = [
    { field: "id", sortable: true, filter: true },
    { field: "full_name", sortable: true, filter: true },
    { field: "html_url", sortable: true, filter: true },
    {
      headerName: "Actions",
      field: "full_name",
      cellRenderer: (params: ICellRendererParams) => (
        <button onClick={() => alert(params.value)}>Press me</button>
      ),
    },
  ];

  const handleClick = () => {
    axios
      .get(`https://api.github.com/search/repositories?q=${keyword}`)
      .then((response) => setRepodata(response.data.items))
      .catch((err) => console.error(err));
  };

  return (
    <>
      <input value={keyword} onChange={(e) => setKeyword(e.target.value)} />
      <button onClick={handleClick}>Fetch</button>
      <div className="ag-theme-material" style={{ height: 500, width: 850 }}>
        <AgGridReact
          rowData={repodata}
          columnDefs={columnDefs}
          pagination={true}
          paginationPageSize={8}
        />
      </div>
    </>
  );
}

export default App;
