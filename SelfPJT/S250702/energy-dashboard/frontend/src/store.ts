import { create } from "zustand";

interface RealtimeData {
  timestamp: number;
  value: number;
  message: string;
}

interface AppState {
  latestData: RealtimeData | null;
  addLatestData: (data: RealtimeData) => void;
}

const useAppStore = create<AppState>((set) => ({
  latestData: null,
  addLatestData: (data) => set({ latestData: data }),
}));

export default useAppStore;
