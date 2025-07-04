
import React, { useMemo, useState, useCallback } from 'react';
import { LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import { DiaryEntry } from '../types';
import { EMOTIONS } from '../constants';
import { generateWeeklySummary } from '../services/geminiService';

interface StatsPanelProps {
  entries: DiaryEntry[];
}

export default function StatsPanel({ entries }: StatsPanelProps) {
  const [summary, setSummary] = useState('');

  const weeklyChartData = useMemo(() => {
    const emotionMap = new Map(EMOTIONS.map(e => [e.emoji, e.value]));
    const data: { name: string, 감정: number }[] = [];
    const today = new Date();
    
    for (let i = 6; i >= 0; i--) {
      const date = new Date(today);
      date.setDate(today.getDate() - i);
      const dateString = date.toISOString().split('T')[0];
      const entry = entries.find(e => e.date === dateString);
      
      data.push({
        name: date.toLocaleDateString('ko-KR', { month: '2-digit', day: '2-digit' }),
        감정: entry ? (emotionMap.get(entry.mainEmotion) || 0) : 0,
      });
    }
    return data;
  }, [entries]);

  const handleGenerateSummary = useCallback(() => {
    const today = new Date();
    const oneWeekAgo = new Date(today);
    oneWeekAgo.setDate(today.getDate() - 7);

    const weekEntries = entries.filter(entry => {
        const entryDate = new Date(entry.date);
        return entryDate > oneWeekAgo && entryDate <= today;
    }).sort((a,b) => new Date(a.date).getTime() - new Date(b.date).getTime());

    const result = generateWeeklySummary(weekEntries);
    setSummary(result);
  }, [entries]);


  return (
    <div className="space-y-6">
      <div className="bg-white p-6 rounded-xl shadow-md">
        <h3 className="text-xl font-semibold text-slate-800 mb-4">주간 감정 트렌드</h3>
        {entries.length > 0 ? (
          <div className="h-64 w-full">
            <ResponsiveContainer>
              <LineChart data={weeklyChartData} margin={{ top: 5, right: 20, left: -10, bottom: 5 }}>
                <CartesianGrid strokeDasharray="3 3" stroke="#e2e8f0" />
                <XAxis dataKey="name" stroke="#64748b" fontSize={12} />
                <YAxis
                  stroke="#64748b"
                  domain={[0, 5]}
                  ticks={[1, 2, 3, 4, 5]}
                  tickFormatter={(value) => EMOTIONS.find(e => e.value === value)?.name || ''}
                  fontSize={12}
                />
                <Tooltip
                    contentStyle={{ backgroundColor: 'rgba(255, 255, 255, 0.8)', borderRadius: '0.5rem', borderColor: '#cbd5e1' }}
                    labelStyle={{ color: '#1e293b', fontWeight: 'bold' }}
                    formatter={(value, name) => [EMOTIONS.find(e => e.value === value)?.name, '감정']}
                />
                <Legend />
                <Line type="monotone" dataKey="감정" stroke="#38bdf8" strokeWidth={2} activeDot={{ r: 8 }} />
              </LineChart>
            </ResponsiveContainer>
          </div>
        ) : (
          <p className="text-slate-500 text-center py-10">다이어리 기록이 없어 차트를 표시할 수 없습니다.</p>
        )}
      </div>
      <div className="bg-white p-6 rounded-xl shadow-md">
        <h3 className="text-xl font-semibold text-slate-800 mb-4">주간 감정 요약</h3>
        <button
          onClick={handleGenerateSummary}
          className="w-full bg-emerald-500 text-white font-bold py-2 px-4 rounded-lg shadow-md hover:bg-emerald-600 transition-all duration-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-500"
        >
          {'주간 요약 생성하기'}
        </button>
        {summary && (
            <div className="mt-4 p-4 bg-slate-50 rounded-lg border border-slate-200">
                <p className="text-slate-700 whitespace-pre-wrap leading-relaxed">{summary}</p>
            </div>
        )}
      </div>
    </div>
  );
}