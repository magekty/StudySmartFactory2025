import useDiary from "../hooks/useDiary";
import { useNavigate, useParams } from "react-router-dom";
import Button from "../componenets/Button";
import Header from "../componenets/Header";
import Editor from "../componenets/Editor";
import { useContext } from "react";
import { DiaryDispatchContext } from "../App";

/* const Edit = () => {
  const { id } = useParams();
  const data = useDiary(id);
  const { onDelete, onUpdate } = useContext(DiaryDispatchContext);
  const navigate = useNavigate();
  const goBack = () => {
    navigate(-1);
  };
  const onClickDelete = () => {
    if (window.confirm("일기를 정말 삭제할까요? 다시 복구 안되요!")) {
      onDelete(id);
      navigate("/", { replace: true });
    }
  };
  const onSubmit = (data) => {
    if (window.confirm("일기를 정말 수정할까요? 다시 복구 안되요!")) {
      const { date, content, emotionId } = data;
      onUpdate(id, date, content, emotionId);
      navigate("/", { replace: true });
    }
  };
  return (
    <div className="Edit">
      <Header
        title={"일기 수정하기"}
        leftChild={<Button text={"< 뒤로 가기"} onClick={goBack} />}
        rightChild={<Button text={"삭제 하기"} onClick={onClickDelete} />}
      />
      <Editor initDate={data} onSubmit={onSubmit} />
    </div>
  );
};

export default Edit;
 */

const Edit = () => {
  const { id } = useParams();
  const data = useDiary(id);

  const { onDelete, onUpdate } = useContext(DiaryDispatchContext);
  const navigate = useNavigate();
  const goBack = () => {
    navigate(-1); //이전 페이지로 이동
  };
  const onClickDelete = () => {
    if (window.confirm("진짜 삭제? 다시 복구 안됨")) {
      onDelete(id);
      navigate("/", { replace: true });
    }
  };
  const onSubmit = () => {
    if (window.confirm("진짜 수정? 다시 복구 안됨")) {
      const { date, content, emotionId } = data;
      onUpdate(date, content, emotionId);
      navigate("/", { replace: true });
    }
  };

  return (
    <div className="Edig">
      <Header
        title={"일기 수정하기"}
        leftChild={<Button text={"뒤로가기"} onClick={goBack} />}
        rightChild={<Button text={"삭제하기"} onClick={onClickDelete} />}
      />
      <Editor initData={data} onSubmit={onSubmit} />
    </div>
  );
};
export default Edit;
