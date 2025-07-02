const WebSocket = require("ws");
const http = require("http");

const server = http.createServer((req, res) => {
  res.writeHead(200, { "Content-Type": "text/plain" });
  res.end("Backend server is running");
});

const wss = new WebSocket.Server({ server });

wss.on("connection", (ws) => {
  console.log("Client connected");

  // 1초마다 랜덤 데이터 생성하여 클라이언트에 전송
  const interval = setInterval(() => {
    const data = {
      timestamp: Date.now(),
      value: Math.random() * 100, // 임의의 숫자 데이터
      message: "Hello from backend!",
    };
    if (ws.readyState === WebSocket.OPEN) {
      ws.send(JSON.stringify(data));
      console.log("Sending data:", data);
    }
  }, 1000);

  ws.on("close", () => {
    console.log("Client disconnected");
    clearInterval(interval); // 클라이언트 연결 끊기면 인터벌 중지
  });

  ws.on("error", (error) => {
    console.error("WebSocket Error:", error);
    clearInterval(interval);
  });
});

server.listen(3001, () => {
  console.log("Backend server is running on http://localhost:3001");
  console.log("WebSocket server is also running on ws://localhost:3001");
});

console.log("WebSocket server starting...");
