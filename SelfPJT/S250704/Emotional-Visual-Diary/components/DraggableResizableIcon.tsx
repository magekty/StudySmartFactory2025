import React, { useState, useRef, useEffect, MouseEvent } from 'react';
import { PlacedItem } from '../types';

interface DraggableResizableIconProps {
  item: PlacedItem;
  onUpdate: (id: string, updates: Partial<PlacedItem>) => void;
  onRemove: (id: string) => void;
}

export default function DraggableResizableIcon({ item, onUpdate, onRemove }: DraggableResizableIconProps) {
  const [interactionState, setInteractionState] = useState({ isDragging: false, isResizing: false });
  const [isActive, setIsActive] = useState(false);
  const nodeRef = useRef<HTMLDivElement>(null);
  
  const interactionDetails = useRef({
    startX: 0,
    startY: 0,
    startLeft: 0,
    startTop: 0,
    startSize: 0,
  });

  const handleDragStart = (e: MouseEvent<HTMLDivElement>) => {
    e.preventDefault();
    e.stopPropagation();
    interactionDetails.current = {
      startX: e.clientX,
      startY: e.clientY,
      startLeft: item.x,
      startTop: item.y,
      startSize: item.size,
    };
    setInteractionState({ isDragging: true, isResizing: false });
  };
  
  const handleResizeStart = (e: MouseEvent<HTMLDivElement>) => {
    e.preventDefault();
    e.stopPropagation();
    interactionDetails.current = {
      ...interactionDetails.current,
      startX: e.clientX,
      startY: e.clientY,
      startSize: item.size,
    };
    setInteractionState({ isDragging: false, isResizing: true });
  };
  
  useEffect(() => {
    const handleMouseMove = (e: globalThis.MouseEvent) => {
      if (!nodeRef.current) return;
      const parentRect = nodeRef.current.parentElement!.getBoundingClientRect();
      const { startX, startY, startLeft, startTop, startSize } = interactionDetails.current;
      
      if (interactionState.isDragging) {
        const newX = startLeft + (e.clientX - startX);
        const newY = startTop + (e.clientY - startY);
        
        const boundedX = Math.max(0, Math.min(newX, parentRect.width - item.size));
        const boundedY = Math.max(0, Math.min(newY, parentRect.height - item.size));

        onUpdate(item.id, { x: boundedX, y: boundedY });
      }
      
      if (interactionState.isResizing) {
          const dx = e.clientX - startX;
          const newSize = Math.max(20, Math.min(parentRect.width, startSize + dx));
          
          const boundedX = Math.max(0, Math.min(item.x, parentRect.width - newSize));
          const boundedY = Math.max(0, Math.min(item.y, parentRect.height - newSize));

          onUpdate(item.id, { size: newSize, x: boundedX, y: boundedY });
      }
    };
    
    const handleMouseUp = () => {
      setInteractionState({ isDragging: false, isResizing: false });
    };

    if (interactionState.isDragging || interactionState.isResizing) {
      window.addEventListener('mousemove', handleMouseMove);
      window.addEventListener('mouseup', handleMouseUp);
    }

    return () => {
      window.removeEventListener('mousemove', handleMouseMove);
      window.removeEventListener('mouseup', handleMouseUp);
    };
  }, [interactionState, onUpdate, item.id, item.size, item.x, item.y]);
  
  const handleDoubleClick = (e: MouseEvent) => {
    e.stopPropagation();
    if(window.confirm('이 아이템을 삭제하시겠습니까?')) {
        onRemove(item.id);
    }
  };

  const isImageIcon = item.type === 'image';
  const isInteracting = interactionState.isDragging || interactionState.isResizing;

  return (
    <div
      ref={nodeRef}
      onMouseDown={handleDragStart}
      onDoubleClick={handleDoubleClick}
      onMouseEnter={() => setIsActive(true)}
      onMouseLeave={() => !isInteracting && setIsActive(false)}
      className="absolute select-none cursor-move group"
      style={{
        left: `${item.x}px`,
        top: `${item.y}px`,
        width: `${item.size}px`,
        height: `${item.size}px`,
        outline: isActive || isInteracting ? '2px dashed rgba(56, 189, 248, 0.7)' : 'none',
        borderRadius: isImageIcon ? '8px' : '0',
        transition: isInteracting ? 'none' : 'outline 0.1s ease-in-out',
      }}
    >
      <img 
        src={item.src} 
        alt="placed item" 
        className="w-full h-full" 
        draggable="false"
        style={{
          objectFit: isImageIcon ? 'cover' : 'contain',
          borderRadius: isImageIcon ? '6px' : '0',
          imageRendering: 'auto'
        }}
      />
      {(isActive || isInteracting) && (
        <>
            <div
              onMouseDown={handleResizeStart}
              className="absolute -right-2 -bottom-2 w-5 h-5 bg-sky-500 border-2 border-white rounded-full cursor-nwse-resize z-10"
              title="크기 조절"
            />
            <div className="absolute -top-7 left-1/2 -translate-x-1/2 bg-black bg-opacity-60 text-white text-xs px-2 py-1 rounded-md whitespace-nowrap opacity-0 group-hover:opacity-100 transition-opacity">
                더블클릭하여 삭제
            </div>
        </>
      )}
    </div>
  );
}
