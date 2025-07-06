import { useState, useEffect } from 'react';
import { OPENMOJI_ICONS } from '../constants';

interface IconPaletteProps {
  onSelectIcon: (iconSrc: string) => void;
}

const getOpenMojiUrl = (hex: string) => `https://openmoji.org/data/color/svg/${hex}.svg`;

const Spinner = () => (
  <svg className="animate-spin h-8 w-8 text-slate-500" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
    <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4"></circle>
    <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
  </svg>
);

export default function IconPalette({ onSelectIcon }: IconPaletteProps) {
  const [iconsLoading, setIconsLoading] = useState(true);

  useEffect(() => {
    let loadedCount = 0;
    const totalIcons = OPENMOJI_ICONS.length;

    OPENMOJI_ICONS.forEach(hex => {
      const img = new Image();
      img.src = getOpenMojiUrl(hex);
      img.onload = () => {
        loadedCount++;
        if (loadedCount === totalIcons) {
          setIconsLoading(false);
        }
      };
      img.onerror = () => { // Handle cases where an icon might fail to load
        loadedCount++;
        if (loadedCount === totalIcons) {
          setIconsLoading(false);
        }
      };
    });
  }, []);

  return (
    <div className={`h-48 overflow-y-auto bg-slate-50 border border-slate-200 rounded-lg p-2 relative custom-scrollbar`}>
      {iconsLoading && (
        <div className="absolute inset-0 flex items-center justify-center bg-white bg-opacity-75 z-10">
          <div className="text-center">
            <Spinner />
            <p className="mt-2 text-slate-600 font-medium">아이콘 로딩 중...</p>
          </div>
        </div>
      )}
      <div className={`grid grid-cols-6 sm:grid-cols-8 md:grid-cols-10 lg:grid-cols-8 xl:grid-cols-10 gap-2 ${iconsLoading ? 'opacity-50' : ''}`}>
        {OPENMOJI_ICONS.map(hex => (
          <button
            key={hex}
            onClick={() => onSelectIcon(getOpenMojiUrl(hex))}
            className={`aspect-square flex items-center justify-center rounded-md hover:bg-slate-200 transition-colors ${iconsLoading ? 'pointer-events-none' : ''}`}
            title="캔버스에 아이콘 추가"
            disabled={iconsLoading}
          >
            <img src={getOpenMojiUrl(hex)} alt="emoji" className="w-8 h-8" />
          </button>
        ))}
      </div>
    </div>
  );
}