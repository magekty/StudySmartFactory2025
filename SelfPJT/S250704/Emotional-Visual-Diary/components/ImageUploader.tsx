
import React, { useRef, useState } from 'react';

interface ImageUploaderProps {
  onImageUpload: (dataUrl: string) => void;
  label: string;
}

export default function ImageUploader({ onImageUpload, label }: ImageUploaderProps) {
  const [feedback, setFeedback] = useState<string>('');
  const fileInputRef = useRef<HTMLInputElement>(null);

  const handleFileChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (file) {
      if (file.size > 5 * 1024 * 1024) { // 5MB limit
        setFeedback('파일 크기는 5MB를 초과할 수 없습니다.');
        return;
      }
      const reader = new FileReader();
      reader.onload = () => {
        onImageUpload(reader.result as string);
        setFeedback(`${file.name} 이미지가 선택되었습니다.`);
        if (fileInputRef.current) {
          fileInputRef.current.value = ""; // Reset file input
        }
      };
      reader.onerror = () => {
        setFeedback('이미지를 읽는 데 실패했습니다.');
      };
      reader.readAsDataURL(file);
    }
  };

  const handleClick = () => {
    fileInputRef.current?.click();
  };

  return (
    <div>
      <input
        type="file"
        ref={fileInputRef}
        onChange={handleFileChange}
        className="hidden"
        accept="image/png, image/jpeg, image/gif"
      />
      <button
        onClick={handleClick}
        className="w-full bg-white border border-slate-300 text-slate-700 font-medium py-2 px-4 rounded-lg hover:bg-slate-50 transition-colors focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-sky-500"
      >
        {label}
      </button>
      {feedback && <p className="text-sm text-slate-500 mt-2 truncate">{feedback}</p>}
    </div>
  );
}