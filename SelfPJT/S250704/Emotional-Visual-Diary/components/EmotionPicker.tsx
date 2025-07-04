
import React from 'react';
import { Emotion } from '../types';

interface EmotionPickerProps {
  emotions: Emotion[];
  selectedEmotion: string;
  onSelectEmotion: (emotion: string) => void;
}

export default function EmotionPicker({ emotions, selectedEmotion, onSelectEmotion }: EmotionPickerProps) {
  return (
    <div className="flex flex-wrap justify-center gap-4">
      {emotions.map(emotion => (
        <button
          key={emotion.name}
          onClick={() => onSelectEmotion(emotion.emoji)}
          className={`flex flex-col items-center gap-2 p-3 rounded-lg transition-all duration-200 w-20
            ${selectedEmotion === emotion.emoji ? 'bg-sky-100 ring-2 ring-sky-500' : 'hover:bg-slate-100'}`}
        >
          <span className="text-4xl">{emotion.emoji}</span>
          <span className={`font-medium text-sm ${selectedEmotion === emotion.emoji ? 'text-sky-700' : 'text-slate-600'}`}>
            {emotion.name}
          </span>
        </button>
      ))}
    </div>
  );
}
