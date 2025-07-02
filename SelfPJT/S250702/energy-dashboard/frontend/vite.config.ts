import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  server: {
    port: 5173, // 프론트엔드 개발 서버 포트
    host: "127.0.0.1",
    // 이 단계에서는 WebSocket을 직접 연결하므로 proxy 설정은 필요 없습니다.
    // 만약 나중에 필요하다면 아래 주석을 해제하고 사용하세요.
    /*
    proxy: {
      '/ws': {
        target: 'ws://127.0.0.1:3001', // 백엔드 WebSocket 서버 주소
        ws: true, // WebSocket 프록시 활성화
        changeOrigin: true,
        // rewrite: (path) => path.replace(/^\/ws/, ''), // 경로 재작성 (필요에 따라)
      },
    },
    */
  },
});
