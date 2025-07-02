// energy-dashboard/frontend/src/MiniWsTest.tsx
import React, { useEffect, useState, useRef } from "react";

const MiniWsTest: React.FC = () => {
  const [messages, setMessages] = useState<string[]>([]);
  const ws = useRef<WebSocket | null>(null);
  const reconnectAttempts = useRef(0);
  const MAX_RECONNECT_ATTEMPTS = 5;
  const RECONNECT_INTERVAL = 3000; // 3 seconds

  useEffect(() => {
    const connect = () => {
      // 새로운 포트 3003으로 직접 연결 시도
      ws.current = new WebSocket("ws://127.0.0.1:3003");

      ws.current.onopen = () => {
        setMessages((prev) => [...prev, "Mini WS: Connection Opened!"]);
        reconnectAttempts.current = 0; // 성공 시 재연결 시도 횟수 초기화
        ws.current?.send("Hello Mini WS Server from client!"); // 서버로 초기 메시지 전송
      };

      ws.current.onmessage = (event) => {
        setMessages((prev) => [...prev, `Mini WS: Received: ${event.data}`]);
      };

      ws.current.onclose = (event) => {
        setMessages((prev) => [
          ...prev,
          `Mini WS: Connection Closed (Code: ${event.code}, Reason: ${
            event.reason || "No reason"
          })`,
        ]);
        if (reconnectAttempts.current < MAX_RECONNECT_ATTEMPTS) {
          reconnectAttempts.current++;
          setMessages((prev) => [
            ...prev,
            `Mini WS: Attempting reconnect ${reconnectAttempts.current}/${MAX_RECONNECT_ATTEMPTS}...`,
          ]);
          setTimeout(connect, RECONNECT_INTERVAL);
        } else {
          setMessages((prev) => [
            ...prev,
            "Mini WS: Max reconnect attempts reached.",
          ]);
        }
      };

      ws.current.onerror = (error) => {
        setMessages((prev) => [...prev, `Mini WS: WebSocket Error: ${error}`]);
        ws.current?.close(); // 에러 발생 시 연결 종료 후 재연결 시도
      };
    };

    connect(); // 컴포넌트 마운트 시 연결 시작

    // 컴포넌트 언마운트 시 WebSocket 연결 정리
    return () => {
      if (ws.current) {
        setMessages((prev) => [
          ...prev,
          "Mini WS: Cleaning up connection on unmount.",
        ]);
        ws.current.close();
      }
    };
  }, []); // 빈 배열로 한 번만 실행되도록 설정

  return (
    <div
      style={{
        padding: "20px",
        border: "1px solid gray",
        margin: "20px",
        backgroundColor: "#f0f0f0",
      }}
    >
      <h3>Mini WebSocket Test Component</h3>
      <p>Connecting to ws://127.0.0.1:3003 directly from client.</p>
      <div
        style={{
          maxHeight: "200px",
          overflowY: "scroll",
          border: "1px solid lightgray",
          padding: "10px",
          backgroundColor: "white",
        }}
      >
        {messages.map((msg, index) => (
          <p key={index} style={{ margin: "2px 0", fontSize: "0.9em" }}>
            {msg}
          </p>
        ))}
      </div>
    </div>
  );
};

export default MiniWsTest;
