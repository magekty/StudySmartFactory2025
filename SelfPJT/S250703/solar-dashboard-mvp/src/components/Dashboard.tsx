// src/components/Dashboard.tsx

import { useState } from "react";
import { fetchKospoData } from "../api/weatherApi";

const Dashboard = () => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [result, setResult] = useState<string>("");

  const handleCheckStatus = async () => {
    setLoading(true);
    setError(null);
    setResult("");

    // 유효성이 검증된 과거 날짜를 하드코딩하여 테스트
    const testDate = new Date("2024-07-01");

    try {
      const response = await fetchKospoData(testDate);
      console.log("API Success Response:", response);
      // 성공 시, 받은 데이터의 개수를 명확히 표시
      setResult(
        `[성공] API가 정상 응답했습니다. 날짜 ${testDate.toLocaleDateString()} 데이터 ${
          response.length > 0 ? response.length + "건 수신 완료" : "데이터 없음"
        }.`
      );
    } catch (err) {
      console.error("API Failure:", err);
      // 실패 시, 에러 메시지를 명확히 표시
      setError(
        err instanceof Error ? err.message : "알 수 없는 오류가 발생했습니다."
      );
    } finally {
      setLoading(false);
    }
  };

  return (
    <div style={{ padding: "20px", fontFamily: "sans-serif" }}>
      <h1>API 상태 확인기 (API Status Checker)</h1>
      <p>아래 버튼을 눌러 KOSPO API의 현재 응답 상태를 확인합니다.</p>
      <p>
        이 테스트는 우리 코드가 아닌, API 서버 자체의 상태를 확인하기
        위함입니다.
      </p>
      <button
        onClick={handleCheckStatus}
        disabled={loading}
        style={{ fontSize: "16px", padding: "10px 20px" }}
      >
        {loading ? "상태 확인 중..." : "KOSPO API 상태 확인"}
      </button>

      {/* 결과 표시 영역 */}
      <div
        style={{
          marginTop: "20px",
          padding: "15px",
          border: "1px solid #ccc",
          borderRadius: "5px",
        }}
      >
        <h3>테스트 결과:</h3>
        {loading && <p>요청을 보내는 중...</p>}
        {error && (
          <p style={{ color: "red", fontWeight: "bold" }}>실패: {error}</p>
        )}
        {result && (
          <p style={{ color: "green", fontWeight: "bold" }}>성공: {result}</p>
        )}
        {!loading && !error && !result && <p>대기 중...</p>}
      </div>
    </div>
  );
};

export default Dashboard;
