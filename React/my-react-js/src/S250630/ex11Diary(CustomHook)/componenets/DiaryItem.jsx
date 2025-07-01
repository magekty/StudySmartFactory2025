import { useNavigate } from "react-router-dom";
import "./DiaryItem.css";
import { getEmotionImgById } from "../Util";
import Button from "./Button";

const DiaryItem = ({ id, emotionId, content, date }) => {
  const navigate = useNavigate();
  const goDetail = () => {
    navigate(`/diary/${id}`);
  };
  const goEdit = () => {
    navigate(`/edit/${id}`);
  };
  return (
    <div className="DiaryItem">
      <div
        className={["img-section", `img-section-${emotionId}`].join(" ")}
        onClick={goDetail}
      >
        <img src={getEmotionImgById(emotionId)} alt="기분 상태" />
      </div>
      <div className="info-section">
        <div className="date-wrapper">
          {new Date(parseInt(date)).toLocaleDateString()}
        </div>
        <div className="content-wrapper">{content.slice(0, 25)}</div>
      </div>
      <div className="button-section">
        <Button text={"수정하기"} onClick={goEdit} />
      </div>
    </div>
  );
};

export default DiaryItem;
