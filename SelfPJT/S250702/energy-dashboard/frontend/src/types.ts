// frontend/src/types.ts
export interface EnergyData {
  timestamp: number;
  energyConsumption: number;
  currentTemperature: number;
  humidity: number;
}

export interface Device {
  id: string; // 고유 ID
  name: string; // 장치 이름
  type: string; // 장치 타입 (예: Sensor, Actuator)
  location: string; // 설치 위치
  status: "active" | "inactive"; // 상태
  createdAt: number; // 생성 시간 (타임스탬프)
}
