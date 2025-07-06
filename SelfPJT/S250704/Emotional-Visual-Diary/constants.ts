import { Emotion, ThemeColors } from './types';

export const LOCAL_STORAGE_KEY = 'visualDiaryEntries';

export const EMOTIONS: Emotion[] = [
  { name: '행복', value: 5, emoji: '😊' },
  { name: '기쁨', value: 4, emoji: '😄' },
  { name: '보통', value: 3, emoji: '😐' },
  { name: '슬픔', value: 2, emoji: '😢' },
  { name: '화남', value: 1, emoji: '😠' },
];

export const THEME_COLORS: Record<string, ThemeColors> = {
    '😊': { // 행복 - Sky
        name: '행복',
        bg: 'bg-sky-500',
        text: 'text-sky-500',
        ring: 'ring-sky-500',
        hoverBg: 'hover:bg-sky-600',
        activeBg: 'bg-sky-100',
        border: 'border-sky-500',
        chart: '#0ea5e9', // sky-500
        scrollbarThumb: '#38bdf8', // sky-400
        scrollbarThumbHover: '#0ea5e9', // sky-500
        scrollbarTrack: '#e0f2fe', // sky-100
    },
    '😄': { // 기쁨 - Lime
        name: '기쁨',
        bg: 'bg-lime-500',
        text: 'text-lime-600',
        ring: 'ring-lime-500',
        hoverBg: 'hover:bg-lime-600',
        activeBg: 'bg-lime-100',
        border: 'border-lime-500',
        chart: '#84cc16', // lime-500
        scrollbarThumb: '#a3e635', // lime-400
        scrollbarThumbHover: '#84cc16', // lime-500
        scrollbarTrack: '#ecfccb', // lime-100
    },
    '😐': { // 보통 - Slate
        name: '보통',
        bg: 'bg-slate-500',
        text: 'text-slate-500',
        ring: 'ring-slate-500',
        hoverBg: 'hover:bg-slate-600',
        activeBg: 'bg-slate-200',
        border: 'border-slate-500',
        chart: '#64748b', // slate-500
        scrollbarThumb: '#94a3b8', // slate-400
        scrollbarThumbHover: '#64748b', // slate-500
        scrollbarTrack: '#e2e8f0', // slate-200
    },
    '😢': { // 슬픔 - Blue
        name: '슬픔',
        bg: 'bg-blue-500',
        text: 'text-blue-500',
        ring: 'ring-blue-500',
        hoverBg: 'hover:bg-blue-600',
        activeBg: 'bg-blue-100',
        border: 'border-blue-500',
        chart: '#3b82f6', // blue-500
        scrollbarThumb: '#60a5fa', // blue-400
        scrollbarThumbHover: '#3b82f6', // blue-500
        scrollbarTrack: '#dbeafe', // blue-100
    },
    '😠': { // 화남 - Rose
        name: '화남',
        bg: 'bg-rose-500',
        text: 'text-rose-500',
        ring: 'ring-rose-500',
        hoverBg: 'hover:bg-rose-600',
        activeBg: 'bg-rose-100',
        border: 'border-rose-500',
        chart: '#f43f5e', // rose-500
        scrollbarThumb: '#fb7185', // rose-400
        scrollbarThumbHover: '#f43f5e', // rose-500
        scrollbarTrack: '#ffe4e6', // rose-100
    },
};


export const OPENMOJI_ICONS: string[] = [
    '1F600', '1F603', '1F604', '1F601', '1F606', '1F605', '1F923', '1F602',
    '1F642', '1F643', '1F609', '1F60A', '1F607', '1F970', '1F60D', '1F929',
    '1F618', '1F617', '263A', '1F61A', '1F619', '1F60B', '1F61B', '1F61C',
    '1F92A', '1F61D', '1F911', '1F917', '1F92D', '1F92B', '1F914', '1F910',
    '1F928', '1F636', '1F610', '1F611', '1F633', '1F623', '1F625', '1F62E',
    '1F91C', '1F924', '1F62D', '1F622', '1F629', '1F62B', '1F628', '1F631',
    '1F494', '2764', '1F493', '1F495', '1F496', '1F497', '1F498', '1F499',
    '1F49A', '1F49B', '1F49C', '1F49D', '1F49E', '1F49F', '1F5A4', '1F90E',
    '1F44D', '1F44E', '1F44C', '270C', '1F91E', '1F91F', '1F918', '1F919',
    '1F44A', '1F44B', '1F64C', '1F44F', '1F932', '1F64F', '1F525', '1F389', 
    '1F31F', '1F4A5', '1F4A9', '1F4A4', '1F4A6'
];