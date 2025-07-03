// vite.config.ts

import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig({
  plugins: [react()],
  server: {
    proxy: {
      "/api/kospo": {
        target: "https://apis.data.go.kr/B551893/solar-power-by-hour",
        changeOrigin: true, // target 서버의 host 헤더를 사용하도록 설정
        rewrite: (path) => path.replace(/^\/api\/kospo/, "/list"),
        // 헤더를 직접 조작하여 Referer를 제거하거나 변경
        configure: (proxy, options) => {
          proxy.on("proxyReq", (proxyReq, req, res) => {
            // Referer 헤더를 제거하여 localhost 출처를 숨김
            proxyReq.removeHeader("Referer");
            // 또는 API 서버가 요구하는 특정 Referer로 설정할 수도 있음
            // proxyReq.setHeader('Referer', 'https://www.data.go.kr');
          });
        },
      },
      "/api/kma-asos": {
        target: "http://apis.data.go.kr/1360000/AsosHourlyInfoService",
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api\/kma-asos/, "/getWthrDataList"),
        configure: (proxy, options) => {
          proxy.on("proxyReq", (proxyReq, req, res) => {
            proxyReq.removeHeader("Referer");
          });
        },
      },
    },
  },
});
