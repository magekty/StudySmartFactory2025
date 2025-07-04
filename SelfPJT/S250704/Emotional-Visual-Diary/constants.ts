
import { Emotion } from './types';

export const LOCAL_STORAGE_KEY = 'visualDiaryEntries';

export const EMOTIONS: Emotion[] = [
  { name: '행복', value: 5, emoji: '😊' },
  { name: '기쁨', value: 4, emoji: '😄' },
  { name: '보통', value: 3, emoji: '😐' },
  { name: '슬픔', value: 2, emoji: '😢' },
  { name: '화남', value: 1, emoji: '😠' },
];

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
