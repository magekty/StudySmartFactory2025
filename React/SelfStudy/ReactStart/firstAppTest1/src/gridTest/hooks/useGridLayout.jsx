import { useEffect, useRef, useState, useCallback } from "react";

const useGridLayout = (items) => {
  const containerRef = useRef(null);
  const [layoutReady, setLayoutReady] = useState(false);

  // getGridItemSpans 함수는 더 이상 사용되지 않으므로 제거합니다.
  // 이전 버전의 Masonry/Packed 로직에서 아이템의 span을 JS에서 읽기 위해 사용되었습니다.

  // 레이아웃을 계산하고 적용하는 핵심 함수
  const calculateLayout = useCallback(() => {
    const currentContainer = containerRef.current;
    if (!currentContainer || items.length === 0) return;

    const containerWidth = currentContainer.clientWidth;
    const computedStyle = getComputedStyle(currentContainer);
    const gap = parseFloat(computedStyle.gap || "0px");

    // 각 아이템의 기본 셀 너비를 100px로 가정합니다 (CSS의 minmax(100px, 1fr)와 연동)
    const minCellWidth = 100;

    // 컨테이너 너비에 따라 최적의 열 개수 계산
    let numColumns = Math.floor(containerWidth / (minCellWidth + gap));
    if (numColumns < 1) numColumns = 1; // 최소 1개 열은 보장

    // 그리드 컨테이너의 열 템플릿 설정
    currentContainer.style.gridTemplateColumns = `repeat(${numColumns}, 1fr)`;
    currentContainer.style.gridAutoRows = `minmax(50px, auto)`; // CSS와 일치, 아이템 높이에 따라 자동 조절

    // CSS의 grid-auto-flow: dense; 와 App.css에 정의된 각 item-NxM 클래스의
    // grid-column: span N; 및 grid-row: span M; 속성을 통해
    // 아이템의 배치 및 빈 공간 채우기가 이루어지므로,
    // 이 JS 훅에서는 더 이상 개별 아이템의 위치나 스팬을 직접 제어하지 않습니다.

    setLayoutReady(true);
  }, [items]); // items가 변경될 때만 calculateLayout 재생성

  useEffect(() => {
    calculateLayout(); // 초기 레이아웃 계산

    // 윈도우 리사이즈 이벤트 리스너 추가 (디바운싱 적용)
    let resizeTimer;
    const handleResize = () => {
      clearTimeout(resizeTimer);
      resizeTimer = setTimeout(calculateLayout, 200);
    };

    window.addEventListener("resize", handleResize);

    // 컴포넌트 언마운트 시 이벤트 리스너 및 타이머 정리
    return () => {
      window.removeEventListener("resize", handleResize);
      clearTimeout(resizeTimer);
    };
  }, [calculateLayout]); // calculateLayout 함수가 변경될 때만 이 useEffect를 다시 실행

  return { containerRef, layoutReady };
};

export default useGridLayout;
