import "./TodoItem.css";

const TodoItem = ({ id, content, isDone, createdDate, onUpdate, onDelete }) => {
  const onClickDelete = () => {
    onDelete(id);
  };
  const onChangeCheckbox = () => {
    onUpdate(id);
  };

  return (
    <div className="TodoItem">
      <div className="checkbox-col">
        <input onChange={onChangeCheckbox} type="checkbox" checked={isDone} />
      </div>
      <div className="title-col">{content}</div>
      <div className="date-col">{new Date(createdDate).toLocaleString()}</div>
      <div className="btn-col">
        <button onClick={onClickDelete}>삭제</button>
      </div>
    </div>
  );
};
export default TodoItem;
