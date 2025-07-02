import React, { useState } from "react";
import "./App.css";
import useGridLayout from "./hooks/useGridLayout"; // 변경된 훅 임포트

// 그리드 아이템 데이터 정의
const initialGridItems = [
  { id: 1, sizeClass: "item-1x1", content: "아이템 1 (1x1)" },
  { id: 2, sizeClass: "item-2x1", content: "아이템 2 (2x1)" },
  { id: 3, sizeClass: "item-1x2", content: "아이템 3 (1x2)" },
  { id: 4, sizeClass: "item-2x2", content: "아이템 4 (2x2)" },
  { id: 5, sizeClass: "item-1x1", content: "아이템 5 (1x1)" },
  { id: 6, sizeClass: "item-3x1", content: "아이템 6 (3x1)" },
  { id: 7, sizeClass: "item-1x3", content: "아이템 7 (1x3)" },
  { id: 8, sizeClass: "item-2x2", content: "아이템 8 (2x2)" },
  { id: 9, sizeClass: "item-1x1", content: "아이템 9 (1x1)" },
  { id: 10, sizeClass: "item-1x2", content: "아이템 10 (1x2)" },
  { id: 11, sizeClass: "item-2x1", content: "아이템 11 (2x1)" },
  { id: 12, sizeClass: "item-1x1", content: "아이템 12 (1x1)" },
  { id: 13, sizeClass: "item-3x1", content: "아이템 13 (3x1)" },
  { id: 14, sizeClass: "item-2x1", content: "아이템 14 (2x1)" },
  { id: 15, sizeClass: "item-1x2", content: "아이템 15 (1x2)" },
  { id: 16, sizeClass: "item-2x2", content: "아이템 16 (2x2)" },
  { id: 17, sizeClass: "item-1x1", content: "아이템 17 (1x1)" },
  { id: 18, sizeClass: "item-2x1", content: "아이템 18 (2x1)" },
  { id: 19, sizeClass: "item-1x2", content: "아이템 19 (1x2)" },
  { id: 20, sizeClass: "item-1x1", content: "아이템 20 (1x1)" },
];

function App() {
  const [gridItems] = useState(initialGridItems); // 아이템 데이터는 useState로 관리
  const { containerRef, layoutReady } = useGridLayout(gridItems); // useGridLayout 훅 사용

  return (
    <div className="grid-container" ref={containerRef}>
      {gridItems.map((item) => (
        <div
          key={item.id}
          className={`grid-item ${item.sizeClass}`}
          // layoutReady 상태를 사용하여 초기 로드 시 깜빡임을 방지할 수 있습니다.
          style={{
            opacity: layoutReady ? 1 : 0,
            transition: "opacity 0.5s ease",
          }}
        >
          {item.content}
        </div>
      ))}
    </div>
  );
}

export default App;
