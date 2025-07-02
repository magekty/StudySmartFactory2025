import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App.tsx";
import "./index.css"; // 필요하다면 유지

// ChakraProvider 및 BrowserRouter는 이 단계에서는 제거합니다.
// 이후에 다시 추가할 것입니다.
import { ChakraProvider } from "@chakra-ui/react";
import theme from "./theme.ts"; // Chakra UI 테마 파일

ReactDOM.createRoot(document.getElementById("root")!).render(
  <React.StrictMode>
    <ChakraProvider theme={theme}>
      {" "}
      {/* Chakra UI 테마를 사용하기 위해 ChakraProvider는 유지 */}
      <App />
    </ChakraProvider>
  </React.StrictMode>
);
