// src/api/weatherApi.ts

import axios from "axios";
import { format } from "date-fns";
import type { KospoApiResponse, KospoContent } from "../types/api";

// .env 파일에는 "인코딩된" 키를 사용해야 합니다.
const KOSPO_API_KEY_ENCODED = import.meta.env.VITE_KOSPO_API_KEY;

// CORS 우회 프록시 서버 주소
const CORS_PROXY = "https://cors-proxy.fringe.zone/";

// 실제 API 엔드포인트 주소
const KOSPO_ACTUAL_ENDPOINT =
  "https://apis.data.go.kr/B551893/solar-power-by-hour/list";

export const fetchKospoData = async (
  targetDate: Date
): Promise<KospoContent[]> => {
  const yyyymmdd = format(targetDate, "yyyy-MM-dd");

  const finalTargetUrl = `${KOSPO_ACTUAL_ENDPOINT}?serviceKey=${KOSPO_API_KEY_ENCODED}&page=1&size=10&startD=${yyyymmdd}&endD=${yyyymmdd}&dataType=JSON`;

  const proxyUrl = CORS_PROXY + finalTargetUrl;

  const response = await axios.get<KospoApiResponse>(proxyUrl);

  if (!response.data || !response.data.header) {
    throw new Error("[KOSPO API Error] Invalid response structure from proxy");
  }
  if (response.data.header.resultCode !== "00") {
    throw new Error(`[KOSPO API Error] ${response.data.header.resultMsg}`);
  }
  return response.data.body?.content || [];
};

// KMA API 함수는 일단 무시합니다.
