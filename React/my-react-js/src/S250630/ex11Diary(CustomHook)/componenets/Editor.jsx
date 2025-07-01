import { useNavigate } from "react-router-dom";
import Button from "./Button";
import { useCallback, useEffect, useState } from "react";
import EmotionItem from "./EmotionItem";
import { emotionList, getFormattedDate } from "../Util";

const Editor = ({ initData, onSubmit }) => {
  const navigate = useNavigate();
  const [state, setState] = useState({
    date: getFormattedDate(new Date()),
    emotionId: 3,
    content: "",
  });
  const onGoBackHandler = () => {
    navigate(-1);
  };
  const onSubmitHandler = () => {
    onSubmit(state);
  };
  const changeDateHandler = (event) => {
    setState({ ...state, date: event.target.value });
  };
  const changeContentHandler = (event) => {
    setState({ ...state, content: event.target.value });
  };

  // 메모이제이션(재사용) 함수 재생성 방지 [] 빈 배열 처음에만 생성됨
  // React.memo인 경우 불필요한 리렌더링 방지
  const changeEmotionHandler = useCallback((emotionId) => {
    setState((state) => ({ ...state, emotionId }));
  }, []);
  useEffect(() => {
    if (initData) {
      setState({
        ...initData,
        date: getFormattedDate(new Date(parseInt(initData.date))),
      });
    }
  }, [initData]);
  return (
    <div className="Editor">
      <div className="input-wrapper">
        <h2>오늘의 날짜</h2>
        <input type="date" value={state.date} onChange={changeDateHandler} />
      </div>
      <div className="editor-section">
        <h2>오늘의 감정</h2>
        <div className="input-wrapper emotion-list-wrapper">
          {emotionList.map((item) => (
            <EmotionItem
              key={item.id}
              {...item}
              onClick={changeEmotionHandler}
              isSelected={state.emotionId}
            />
          ))}
        </div>
      </div>
      <div className="editor-section">
        <h2>오늘의 일기</h2>
        <div className="input-wrapper">
          <textarea
            placeholder="오늘의 기분을 적어봐요"
            value={state.content}
            onChange={changeContentHandler}
          />
        </div>
      </div>
      <div className="editor-section bottom-section">
        <Button text={"취소 하기"} onClick={onGoBackHandler} />
        <Button text={"작성 완료"} onClick={onSubmitHandler} />
      </div>
    </div>
  );
};
export default Editor;
