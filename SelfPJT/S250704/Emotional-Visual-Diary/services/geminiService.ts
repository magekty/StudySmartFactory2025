import { DiaryEntry, Emotion } from '../types';
import { EMOTIONS } from '../constants';

const getEmotionDetails = (emoji: string): Emotion | undefined => {
  return EMOTIONS.find(e => e.emoji === emoji);
};

export const generateWeeklySummary = (weekEntries: DiaryEntry[]): string => {
  if (weekEntries.length === 0) {
    return "분석할 데이터가 없습니다. 먼저 다이어리를 작성해보세요.";
  }
  if (weekEntries.length < 2) {
    return "주간 요약을 생성하려면 최소 2일 이상의 기록이 필요합니다.";
  }

  const emotionCounts: Record<string, number> = {};
  let totalEmotionValue = 0;
  
  weekEntries.forEach(entry => {
    const emotion = getEmotionDetails(entry.mainEmotion);
    if (emotion) {
      emotionCounts[emotion.name] = (emotionCounts[emotion.name] || 0) + 1;
      totalEmotionValue += emotion.value;
    }
  });

  const mostFrequentEmotionName = Object.keys(emotionCounts).reduce((a, b) => emotionCounts[a] > emotionCounts[b] ? a : b, '');
  
  const averageEmotionValue = totalEmotionValue / weekEntries.length;

  let trend = 'stable';
  if (weekEntries.length >= 4) {
      const half = Math.ceil(weekEntries.length / 2);
      const firstHalfEntries = weekEntries.slice(0, half);
      const secondHalfEntries = weekEntries.slice(half);

      const firstHalfValue = firstHalfEntries.reduce((sum, entry) => sum + (getEmotionDetails(entry.mainEmotion)?.value || 3), 0);
      const secondHalfValue = secondHalfEntries.reduce((sum, entry) => sum + (getEmotionDetails(entry.mainEmotion)?.value || 3), 0);
      
      const firstHalfAvg = firstHalfValue / firstHalfEntries.length;
      const secondHalfAvg = secondHalfValue / secondHalfEntries.length;

      if (secondHalfAvg > firstHalfAvg + 0.5) trend = 'improving';
      else if (secondHalfAvg < firstHalfAvg - 0.5) trend = 'declining';
  }

  let summary = `이번 주에는 총 ${weekEntries.length}일의 다이어리를 작성하셨네요. `;
  
  if(mostFrequentEmotionName) {
      summary += `'${mostFrequentEmotionName}' 감정을 가장 많이 느끼신 한 주였어요. `;
  }

  switch (trend) {
      case 'improving':
          summary += "주 후반으로 갈수록 감정이 긍정적으로 변하는 멋진 모습을 보여주셨어요. ";
          break;
      case 'declining':
          summary += "조금 힘든 시간을 보내신 것 같아요. 스스로를 다독여주는 시간을 가져보는 건 어떨까요? ";
          break;
      default:
          summary += "꾸준하게 감정을 기록하고 자신을 돌보는 모습이 인상적입니다. ";
          break;
  }

  if (averageEmotionValue > 3.5) {
      summary += "전반적으로 긍정적인 에너지가 가득한 한 주였네요! 이 기운을 다음 주에도 이어가시길 바라요.";
  } else if (averageEmotionValue < 2.5) {
      summary += "마음이 조금 지쳐 보이지만, 자신의 감정을 꾸준히 기록하는 것만으로도 큰 의미가 있답니다. 작은 것에서 즐거움을 찾아보세요.";
  } else {
      summary += "대체로 평온한 한 주를 보내셨군요. 다음 주에는 더 즐거운 일들이 가득하기를 응원합니다.";
  }

  return summary;
};
