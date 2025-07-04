import React from "react";
import { OPENMOJI_ICONS } from "../constants";

interface IconPaletteProps {
  onSelectIcon: (iconSrc: string) => void;
}

const getOpenMojiUrl = (hex: string) =>
  `https://openmoji.org/data/color/svg/${hex}.svg`;

export default function IconPalette({ onSelectIcon }: IconPaletteProps) {
  return (
    <div className="h-48 overflow-y-auto bg-slate-50 border border-slate-200 rounded-lg p-2">
      <div className="grid grid-cols-6 sm:grid-cols-8 md:grid-cols-10 lg:grid-cols-8 xl:grid-cols-10 gap-2">
        {OPENMOJI_ICONS.map((hex) => (
          <button
            key={hex}
            onClick={() => onSelectIcon(getOpenMojiUrl(hex))}
            className="aspect-square flex items-center justify-center rounded-md hover:bg-slate-200 transition-colors"
            title="캔버스에 아이콘 추가"
          >
            <img src={getOpenMojiUrl(hex)} alt="emoji" className="w-8 h-8" />
          </button>
        ))}
      </div>
    </div>
  );
}
