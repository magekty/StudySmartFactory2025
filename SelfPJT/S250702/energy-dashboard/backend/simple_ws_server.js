const WebSocket = require("ws");
const wss = new WebSocket.Server({ port: 3002 });

wss.on("connection", (ws) => {
  console.log("Simple Client connected");
  ws.send("Welcome from simple server!");

  ws.on("message", (message) => {
    console.log(`Received: ${message}`);
    ws.send(`Echo: ${message}`);
  });

  ws.on("close", () => {
    console.log("Simple Client disconnected");
  });

  ws.on("error", (error) => {
    console.error("Simple WebSocket error:", error);
  });
});

console.log("Simple WebSocket server listening on ws://localhost:3002");
