// energy-dashboard/backend/mini-ws-server.js
const WebSocket = require("ws");
const http = require("http"); // http 모듈 추가 (cors 처리를 위해)
const cors = require("cors"); // cors 모듈 추가

// HTTP 서버를 생성하여 CORS 처리
const server = http.createServer((req, res) => {
  cors()(req, res, () => {
    res.writeHead(200, { "Content-Type": "text/plain" });
    res.end("Mini WS server is running");
  });
});

// WebSocket 서버 인스턴스 생성 (HTTP 서버에 연결)
const wss = new WebSocket.Server({ server });

const TEST_PORT = 3003; // 기존 3002와 겹치지 않게 새로운 포트 사용
const TEST_HOST = "127.0.0.1";

console.log(`Mini WebSocket server starting on ws://${TEST_HOST}:${TEST_PORT}`);

wss.on("connection", (ws) => {
  console.log("Mini WS: A client connected.");

  const interval = setInterval(() => {
    if (ws.readyState === WebSocket.OPEN) {
      const data = {
        testMessage: "Mini WS test data!",
        testTimestamp: Date.now(),
      };
      ws.send(JSON.stringify(data));
      console.log("Mini WS: Sent test data to client.");
    } else {
      console.log("Mini WS: Client not OPEN, clearing interval.");
      clearInterval(interval);
    }
  }, 1000); // 1초마다 메시지 전송

  ws.on("message", (message) => {
    console.log(`Mini WS: Received message from client: ${message}`);
    ws.send(`Mini WS: Echo back: ${message}`);
  });

  ws.on("close", (code, reason) => {
    console.log(
      `Mini WS: Client disconnected (Code: ${code}, Reason: ${
        reason || "No reason specified"
      }).`
    );
    clearInterval(interval);
  });

  ws.on("error", (error) => {
    console.error("Mini WS: WebSocket error:", error);
    clearInterval(interval);
  });
});

server.listen(TEST_PORT, TEST_HOST, () => {
  console.log(
    `Mini WS: HTTP server for WebSocket is listening on http://${TEST_HOST}:${TEST_PORT}`
  );
  console.log(
    `Mini WS: WebSocket server is ready and listening on ws://${TEST_HOST}:${TEST_PORT}`
  );
});

wss.on("error", (error) => {
  console.error("Mini WS: Top-level WebSocket server error:", error);
});
