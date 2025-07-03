// src/types/api.ts

// 1. 한국남동발전 (KOSPO) API 관련 타입 (명세서 기반)
export interface KospoApiResponse {
  header: {
    resultCode: string;
    resultMsg: string;
  };
  body: {
    totalElements: number;
    content: KospoContent[];
  };
}

export interface KospoContent {
  dgenYmd: string; // 발전일자 (YYYY-MM-DD)
  [key: string]: number | string; // qhorGen01, qhorGen02 등 동적 키 처리
}

// 2. 기상청 (KMA) ASOS 시간자료 API 관련 타입 (기존 유지)
export interface KmaAsosData {
  tm: string;
  ta: string;
  rn: string;
  ws: string;
  wd: string;
  hm: string;
}

// 3. 차트에서 사용할 통합 데이터 타입 (기존 유지)
export interface CombinedData {
  hour: number;
  generation?: number;
  temperature?: number;
}
