export interface PlacedItem {
  id: string;
  type: 'icon' | 'image';
  src: string;
  x: number;
  y: number;
  size: number;
  rotation: number;
}

export interface DiaryEntry {
  date: string;
  mainEmotion: string;
  backgroundImage: string | null;
  placedItems: PlacedItem[];
}

export interface Emotion {
  name: string;
  value: number;
  emoji: string;
}

export interface ThemeColors {
  name: string;
  bg: string;
  text: string;
  ring: string;
  hoverBg: string;
  activeBg: string;
  border: string;
  chart: string;
  scrollbarThumb: string;
  scrollbarThumbHover: string;
  scrollbarTrack: string;
}