
import { useState, useEffect, useCallback } from 'react';
import { DiaryEntry } from '../types';
import { LOCAL_STORAGE_KEY } from '../constants';

export const useDiary = () => {
  const [entries, setEntries] = useState<Record<string, DiaryEntry>>({});

  useEffect(() => {
    try {
      const savedEntries = localStorage.getItem(LOCAL_STORAGE_KEY);
      if (savedEntries) {
        setEntries(JSON.parse(savedEntries));
      }
    } catch (error) {
      console.error("저장된 다이어리 데이터를 불러오는 데 실패했습니다.", error);
    }
  }, []);

  const saveEntry = useCallback((entry: DiaryEntry) => {
    const newEntries = { ...entries, [entry.date]: entry };
    setEntries(newEntries);
    try {
      localStorage.setItem(LOCAL_STORAGE_KEY, JSON.stringify(newEntries));
    } catch (error) {
      console.error("다이어리 데이터를 저장하는 데 실패했습니다.", error);
    }
  }, [entries]);

  const getEntryForDate = useCallback((date: string): DiaryEntry | null => {
    return entries[date] || null;
  }, [entries]);

  return { entries, saveEntry, getEntryForDate };
};
