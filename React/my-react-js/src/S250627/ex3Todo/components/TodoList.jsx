import "./TodoList.css";
import { useState } from "react";
import TodoItem from "./TodoItem";

const TodoList = ({ todo, onUpdate, onDelete }) => {
  const [search, setSearch] = useState("");
  const onChangeSearch = (event) => {
    setSearch(event.target.value);
  };
  const getSearchResult = () => {
    return search === ""
      ? todo
      : todo.filter((item) => item.content.includes(search));
  };
  return (
    <div className="TodoList">
      <h3>Todo List</h3>
      <input
        className="searchbar"
        placeholder="검색어를 입력하세요"
        value={search}
        onChange={onChangeSearch}
      />
      <div className="lists-wrapper">
        {getSearchResult().map((item) => (
          <TodoItem
            key={item.id}
            {...item}
            onUpdate={onUpdate}
            onDelete={onDelete}
          />
        ))}
      </div>
    </div>
  );
};
export default TodoList;
