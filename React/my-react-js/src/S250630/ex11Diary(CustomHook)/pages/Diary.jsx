import { useNavigate, useParams } from "react-router-dom";
import useDiary from "../hooks/useDiary";
import { getFormattedDate } from "../Util";
import Header from "../componenets/Header";
import Button from "../componenets/Button";
import Viewer from "../componenets/Viewer";
const Diary = () => {
  const { id } = useParams();
  console.log("Diary.jsx - useParams id:", id);
  const data = useDiary(id);
    console.log("Diary.jsx - useDiary 반환 data:", data);
  const navigate = useNavigate();
  const goBack = () => {
    navigate(-1);
  };
  const goEdit = () => {
    navigate(`/edit/${id}`);
  };
  if (!data) {
    return <>아직 읽고 있어요</>;
  }
  const { date, emotionId, content } = data;
    console.log("Diary.jsx - 구조 분해 후 emotionId (정상 시점):", emotionId);
  const title = `${getFormattedDate(new Date(Number(date)))}`;
  return (
    <div className="Diary">
      <Header
        title={title}
        leftChild={<Button text={"< 뒤로 가기"} onClick={goBack} />}
        rightChild={<Button text={"수정 하기"} onClick={goEdit} />}
      />
      <Viewer content={content} emotionId={emotionId} />
    </div>
  );
};

export default Diary;
