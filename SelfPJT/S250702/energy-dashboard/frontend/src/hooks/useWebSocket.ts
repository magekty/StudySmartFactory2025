import { useEffect, useRef, useState, useCallback } from "react";

interface WebSocketOptions {
  url: string;
  onOpen?: () => void;
  onMessage: (data: any) => void;
  onClose?: (event: CloseEvent) => void;
  onError?: (event: Event) => void;
  reconnectInterval?: number;
  reconnectAttempts?: number;
}

const useWebSocket = ({
  url,
  onOpen,
  onMessage,
  onClose,
  onError,
  reconnectInterval = 3000,
  reconnectAttempts = 10,
}: WebSocketOptions) => {
  const ws = useRef<WebSocket | null>(null);
  const retryCount = useRef(0);
  const [isConnected, setIsConnected] = useState(false);

  const connect = useCallback(() => {
    if (
      ws.current &&
      (ws.current.readyState === WebSocket.OPEN ||
        ws.current.readyState === WebSocket.CONNECTING)
    ) {
      console.log(
        "WebSocket: Already connecting or open. Skipping new connection attempt."
      );
      return;
    }

    console.log(
      `WebSocket: Connecting to ${url}... (Attempt ${
        retryCount.current + 1
      }/${reconnectAttempts})`
    );
    ws.current = new WebSocket(url);
    setIsConnected(false);

    ws.current.onopen = () => {
      console.log("WebSocket: Connected");
      setIsConnected(true);
      retryCount.current = 0;
      onOpen?.();
    };

    ws.current.onmessage = (event) => {
      try {
        const data = JSON.parse(event.data as string);
        onMessage(data);
      } catch (e) {
        console.error("WebSocket: Failed to parse message", e);
      }
    };

    ws.current.onclose = (event) => {
      console.log("WebSocket: Disconnected", event.code, event.reason);
      setIsConnected(false);

      if (!event.wasClean && retryCount.current < reconnectAttempts) {
        retryCount.current++;
        console.log(
          `WebSocket: Reconnecting in ${reconnectInterval / 1000} seconds...`
        );
        setTimeout(connect, reconnectInterval);
      } else if (!event.wasClean) {
        console.error("WebSocket: Max reconnection attempts reached.");
      }
      onClose?.(event);
    };

    ws.current.onerror = (event) => {
      console.error("WebSocket Error:", event);
      setIsConnected(false);
      ws.current?.close();
      onError?.(event);
    };
  }, [
    url,
    onOpen,
    onMessage,
    onClose,
    onError,
    reconnectInterval,
    reconnectAttempts,
  ]);

  useEffect(() => {
    console.log("useWebSocket useEffect: Initializing connection.");
    connect();

    return () => {
      console.log("useWebSocket useEffect: Cleaning up WebSocket.");
      if (ws.current) {
        ws.current.close();
        ws.current = null;
      }
    };
  }, [connect]);

  return { isConnected, wsInstance: ws.current };
};

export default useWebSocket;
