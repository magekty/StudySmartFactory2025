import { Emotion } from '../types';
import { useTheme } from '../contexts/ThemeContext';

interface EmotionPickerProps {
  emotions: Emotion[];
  selectedEmotion: string;
  onSelectEmotion: (emotion: string) => void;
}

export default function EmotionPicker({ emotions, selectedEmotion, onSelectEmotion }: EmotionPickerProps) {
  const theme = useTheme();

  return (
    <div className="flex flex-wrap justify-center gap-4">
      {emotions.map(emotion => {
        const isSelected = selectedEmotion === emotion.emoji;
        const selectedClasses = `${theme.activeBg} ring-2 ${theme.ring}`;
        const textClasses = isSelected ? theme.text.replace('text-','text-').replace('-500', '-700') : 'text-slate-600';

        return (
          <button
            key={emotion.name}
            onClick={() => onSelectEmotion(emotion.emoji)}
            className={`flex flex-col items-center gap-2 p-3 rounded-lg transition-all duration-200 w-20
              ${isSelected ? selectedClasses : 'hover:bg-slate-100'}`}
          >
            <span className="text-4xl">{emotion.emoji}</span>
            <span className={`font-medium text-sm ${textClasses}`}>
              {emotion.name}
            </span>
          </button>
        )
      })}
    </div>
  );
}