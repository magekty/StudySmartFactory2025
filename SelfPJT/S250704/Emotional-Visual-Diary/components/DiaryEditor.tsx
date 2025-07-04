
import React, { useState, useCallback, useRef } from 'react';
import { DiaryEntry, PlacedItem } from '../types';
import ImageUploader from './ImageUploader';
import EmotionPicker from './EmotionPicker';
import IconPalette from './IconPalette';
import DraggableResizableIcon from './DraggableResizableIcon';
import { EMOTIONS } from '../constants';

interface DiaryEditorProps {
  entry: DiaryEntry;
  onSave: (entry: DiaryEntry) => void;
}

export default function DiaryEditor({ entry, onSave }: DiaryEditorProps) {
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
      alert("캔버스 정보를 읽어올 수 없습니다. 잠시 후 다시 시도해주세요.");
      return;
    }
    const newItem: PlacedItem = {
      id: `${Date.now()}-${Math.random()}`,
      type: 'image',
      src: dataUrl,
      x: 20,
      y: 20,
      size: canvasWidth / 10,
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
    onSave({
      date: entry.date,
      mainEmotion,
      backgroundImage,
      placedItems,
    });
    alert('오늘의 다이어리가 저장되었습니다!');
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
            className="mt-4 w-full aspect-video rounded-lg border-2 border-dashed border-slate-300 bg-slate-50 relative overflow-hidden"
            style={{ 
                backgroundImage: `url(${backgroundImage})`,
                backgroundSize: 'cover',
                backgroundPosition: 'center'
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
        className="w-full bg-sky-500 text-white font-bold py-3 px-4 rounded-lg shadow-md hover:bg-sky-600 transition-all duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-sky-500"
      >
        오늘의 다이어리 저장하기
      </button>
    </div>
  );
}