
export interface PlacedItem {
  id: string;
  type: 'icon' | 'image';
  src: string;
  x: number;
  y: number;
  size: number;
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