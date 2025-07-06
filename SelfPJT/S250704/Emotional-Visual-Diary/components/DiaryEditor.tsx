import { useState, useCallback, useRef } from 'react';
import { DiaryEntry, PlacedItem } from '../types';
import ImageUploader from './ImageUploader';
import EmotionPicker from './EmotionPicker';
import IconPalette from './IconPalette';
import DraggableResizableIcon from './DraggableResizableIcon';
import { EMOTIONS } from '../constants';
import { useTheme } from '../contexts/ThemeContext';

interface DiaryEditorProps {
  entry: DiaryEntry;
  onSave: (entry: DiaryEntry) => void;
  onValidationFail: (message: string) => void;
}

export default function DiaryEditor({ entry, onSave, onValidationFail }: DiaryEditorProps) {
  const theme = useTheme();
  const [backgroundImage, setBackgroundImage] = useState<string | null>(entry.backgroundImage);
  const [mainEmotion, setMainEmotion] = useState<string>(entry.mainEmotion);
  const [placedItems, setPlacedItems] = useState<PlacedItem[]>(entry.placedItems);
  const canvasRef = useRef<HTMLDivElement>(null);

  const handleBackgroundUpload = (dataUrl: string) => {
    setBackgroundImage(dataUrl);
  };

  const addImageToCanvas = (dataUrl: string) => {
    const canvasWidth = canvasRef.current?.offsetWidth;
    if (!canvasWidth) {
      onValidationFail("캔버스 정보를 읽어올 수 없습니다. 잠시 후 다시 시도해주세요.");
      return;
    }
    const newItem: PlacedItem = {
      id: `${Date.now()}-${Math.random()}`,
      type: 'image',
      src: dataUrl,
      x: 20,
      y: 20,
      size: canvasWidth / 10,
      rotation: 0,
    };
    setPlacedItems(prev => [...prev, newItem]);
  };

  const addIconToCanvas = (iconSrc: string) => {
    const newIcon: PlacedItem = {
      id: `${Date.now()}-${Math.random()}`,
      type: 'icon',
      src: iconSrc,
      x: 50,
      y: 50,
      size: 50,
      rotation: 0,
    };
    setPlacedItems(prevItems => [...prevItems, newIcon]);
  };
  
  const updateItem = useCallback((id: string, updates: Partial<PlacedItem>) => {
    setPlacedItems(prev => 
      prev.map(item => (item.id === id ? { ...item, ...updates } : item))
    );
  }, []);

  const removeItem = (id: string) => {
    setPlacedItems(prev => prev.filter(item => item.id !== id));
  }

  const handleSaveClick = () => {
    if (!backgroundImage) {
        onValidationFail('배경 이미지를 업로드해주세요.');
        return;
    }
    if (placedItems.length === 0) {
        onValidationFail('하나 이상의 아이콘이나 꾸미기 이미지를 추가해주세요.');
        return;
    }

    onSave({
      date: entry.date,
      mainEmotion,
      backgroundImage,
      placedItems,
    });
  };

  return (
    <div className="space-y-6">
      <div className="bg-white p-6 rounded-xl shadow-md">
        <h3 className="text-xl font-semibold text-slate-800 mb-4">1. 오늘의 대표 감정을 선택해주세요.</h3>
        <EmotionPicker emotions={EMOTIONS} selectedEmotion={mainEmotion} onSelectEmotion={setMainEmotion} />
      </div>

      <div className="bg-white p-6 rounded-xl shadow-md">
        <h3 className="text-xl font-semibold text-slate-800 mb-4">2. 배경 이미지를 꾸며보세요.</h3>
        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <ImageUploader onImageUpload={handleBackgroundUpload} label="배경 이미지 업로드 (JPG, PNG, GIF)" />
            <ImageUploader onImageUpload={addImageToCanvas} label="꾸미기 이미지 추가" />
        </div>
        <div 
            id="diary-canvas"
            ref={canvasRef}
            className={`mt-4 w-full aspect-video rounded-lg border-2 border-dashed border-slate-300 bg-slate-50 relative overflow-hidden transition-colors duration-300`}
            style={{ 
                backgroundImage: `url(${backgroundImage})`,
                backgroundSize: 'cover',
                backgroundPosition: 'center',
            }}
        >
          {backgroundImage === null && (
            <div className="absolute inset-0 flex items-center justify-center">
                <p className="text-slate-400">배경 이미지를 업로드하세요</p>
            </div>
          )}
          {placedItems.map(item => (
            <DraggableResizableIcon key={item.id} item={item} onUpdate={updateItem} onRemove={removeItem} />
          ))}
        </div>
      </div>

      <div className="bg-white p-6 rounded-xl shadow-md">
        <h3 className="text-xl font-semibold text-slate-800 mb-4">3. 아이콘으로 다이어리를 채워보세요.</h3>
        <IconPalette onSelectIcon={addIconToCanvas} />
      </div>

      <button
        onClick={handleSaveClick}
        className={`w-full text-white font-bold py-3 px-4 rounded-lg shadow-md transition-all duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2 ${theme.bg} ${theme.hoverBg} ${theme.ring}`}
      >
        오늘의 다이어리 저장하기
      </button>
    </div>
  );
}