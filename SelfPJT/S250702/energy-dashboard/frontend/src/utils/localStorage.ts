// frontend/src/utils/localStorage.ts
import { Device } from "../types";

const DEVICES_STORAGE_KEY = "smart_factory_devices";

// 모든 장치 불러오기
export const getDevices = (): Device[] => {
  try {
    const storedDevices = localStorage.getItem(DEVICES_STORAGE_KEY);
    // JSON.parse 전에 null 또는 undefined 체크
    const devices = storedDevices ? JSON.parse(storedDevices) : [];
    // createdAt이 없는 경우를 대비하여 기본값 설정 (마이그레이션용)
    return devices.map((device: any) => ({
      ...device,
      createdAt: device.createdAt || Date.now(), // 기존 데이터에 createdAt 없으면 현재 시간으로
    })) as Device[];
  } catch (error) {
    console.error("Failed to load devices from local storage", error);
    return [];
  }
};

// 장치 저장 (전체 배열 덮어쓰기)
export const saveDevices = (devices: Device[]): void => {
  try {
    localStorage.setItem(DEVICES_STORAGE_KEY, JSON.stringify(devices));
  } catch (error) {
    console.error("Failed to save devices to local storage", error);
  }
};

// 새 장치 추가
export const addDevice = (newDevice: Device): void => {
  const devices = getDevices();
  devices.push(newDevice);
  saveDevices(devices);
};

// 장치 업데이트
export const updateDevice = (updatedDevice: Device): boolean => {
  const devices = getDevices();
  const index = devices.findIndex((d) => d.id === updatedDevice.id);
  if (index > -1) {
    devices[index] = updatedDevice;
    saveDevices(devices);
    return true;
  }
  return false;
};

// 장치 삭제
export const deleteDevice = (id: string): boolean => {
  let devices = getDevices();
  const initialLength = devices.length;
  devices = devices.filter((d) => d.id !== id);
  saveDevices(devices);
  return devices.length < initialLength;
};
