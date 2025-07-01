import { useContext, useEffect, useState } from "react";
import { DiaryStateContext } from "../App";
import { useNavigate } from "react-router-dom";
const useDiary = (id) => {
  const data = useContext(DiaryStateContext);

console.log("useDiary.js - useContext data (초기):", data);
  const [diary, setDiary] = useState(null);
  const navigate = useNavigate();
  
  useEffect(() => {

    const matchDiary = data.find((item) => String(item.id) === String(id));
    console.log("★★★ useDiary 훅 - 찾은 일기 (matchDiary):", matchDiary);
    if (matchDiary) {
      setDiary(matchDiary);
    } else {
      alert("일기가 없어요");
      navigate("/", { replace: true });
    }
  }, [id, data]);
  return diary;
};
export default useDiary;
