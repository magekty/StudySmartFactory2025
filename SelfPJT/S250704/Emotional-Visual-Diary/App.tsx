import { useState, useMemo } from 'react';
import { DiaryEntry } from './types';
import { useDiary } from './hooks/useDiary';
import { ThemeProvider } from './contexts/ThemeContext';
import DiaryEditor from './components/DiaryEditor';
import StatsPanel from './components/StatsPanel';
import Modal from './components/Modal';
import { ChevronLeftIcon } from './components/icons/ChevronLeftIcon';
import { ChevronRightIcon } from './components/icons/ChevronRightIcon';
import { CalendarIcon } from './components/icons/CalendarIcon';
import { EMOTIONS } from './constants';

const formatDate = (date: Date): string => {
  return date.toISOString().split('T')[0];
};

function App() {
  const [selectedDate, setSelectedDate] = useState(new Date());
  const { entries, saveEntry } = useDiary();
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [modalMessage, setModalMessage] = useState('');

  const formattedDate = useMemo(() => formatDate(selectedDate), [selectedDate]);

  const currentEntry = useMemo(() => {
    return entries[formattedDate] || {
      date: formattedDate,
      mainEmotion: EMOTIONS[2].emoji, // '보통'
      backgroundImage: null,
      placedItems: [],
    };
  }, [entries, formattedDate]);

  const handleDateChange = (days: number) => {
    setSelectedDate(prevDate => {
      const newDate = new Date(prevDate);
      newDate.setDate(newDate.getDate() + days);
      return newDate;
    });
  };

  const handleSave = (entry: DiaryEntry) => {
    saveEntry(entry);
    setModalMessage('오늘의 다이어리가 저장되었습니다!');
    setIsModalOpen(true);
  };
  
  const handleValidationFail = (message: string) => {
    setModalMessage(message);
    setIsModalOpen(true);
  };

  const goToToday = () => {
    setSelectedDate(new Date());
  };

  return (
    <ThemeProvider emotion={currentEntry.mainEmotion}>
      <div className="min-h-screen bg-slate-100 p-4 sm:p-6 lg:p-8">
        <div className="max-w-7xl mx-auto">
          <header className="mb-8 text-center">
            <h1 className="text-6xl sm:text-7xl font-bold text-slate-800 font-dongle">Emoti Day</h1>
            <p className="mt-1 text-lg text-slate-600">당신의 하루를 시각적으로 기록하고 돌아보세요</p>
          </header>

          <div className="bg-white p-4 rounded-xl shadow-md mb-6 flex items-center justify-between">
              <button 
                onClick={() => handleDateChange(-1)} 
                className="p-2 rounded-full hover:bg-slate-100 transition-colors"
                aria-label="이전 날짜"
              >
                  <ChevronLeftIcon className="w-6 h-6 text-slate-600" />
              </button>
              <div className="flex items-center gap-2">
                <CalendarIcon className="w-6 h-6 text-slate-500" />
                <h2 className="text-xl sm:text-2xl font-semibold text-slate-700">
                  {selectedDate.toLocaleDateString('ko-KR', { year: 'numeric', month: 'long', day: 'numeric', weekday: 'long' })}
                </h2>
              </div>
              <button 
                onClick={() => handleDateChange(1)} 
                className="p-2 rounded-full hover:bg-slate-100 transition-colors"
                aria-label="다음 날짜"
                disabled={formatDate(selectedDate) === formatDate(new Date())}
              >
                  <ChevronRightIcon className={`w-6 h-6 ${formatDate(selectedDate) === formatDate(new Date()) ? 'text-slate-300' : 'text-slate-600'}`} />
              </button>
          </div>
          
          {formatDate(selectedDate) !== formatDate(new Date()) && (
            <div className="text-center mb-4">
              <button onClick={goToToday} className="text-sky-600 hover:text-sky-800 font-medium transition-colors">
                오늘 날짜로 돌아가기
              </button>
            </div>
          )}

          <main className="grid grid-cols-1 lg:grid-cols-3 gap-8">
            <div className="lg:col-span-2">
              <DiaryEditor 
                key={formattedDate} // Force re-mount on date change
                entry={currentEntry}
                onSave={handleSave}
                onValidationFail={handleValidationFail}
              />
            </div>
            <div className="lg:col-span-1">
              <StatsPanel entries={Object.values(entries)} />
            </div>
          </main>
        </div>
        <Modal isOpen={isModalOpen} onClose={() => setIsModalOpen(false)}>
            <p className="text-slate-700 text-center">{modalMessage}</p>
        </Modal>
      </div>
    </ThemeProvider>
  );
}

export default App;