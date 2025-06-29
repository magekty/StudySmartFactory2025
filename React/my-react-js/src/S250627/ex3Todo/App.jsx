import "./App.css";
import { useRef, useState } from "react";
import Header from "./components/Header";
import TodoEditor from "./components/TodoEditor";
import TodoList from "./components/TodoList";

const mockTodo = [
  {
    id: 0,
    isDone: false,
    content: "리액트 공부하기",
    createdDate: new Date().getTime(),
  },
  {
    id: 1,
    isDone: false,
    content: "빨래 널기",
    createdDate: new Date().getTime(),
  },
  {
    id: 2,
    isDone: false,
    content: "노래 연습하기",
    createdDate: new Date().getTime(),
  },
];

function App() {
  const [todo, setTodo] = useState(mockTodo);
  const idRef = useRef(3);

  const onCreate = (content) => {
    const newItem = {
      id: idRef.current,
      isDone: false,
      content: content,
      createdDate: new Date().getTime(),
    };
    setTodo([...todo, newItem]);
    idRef.current++;
  };
  const onUpdate = (targetId) => {
    setTodo(
      todo.map((item) =>
        item.id === targetId ? { ...item, isDone: !item.isDone } : item
      )
    );
  };
  const onDelete = (targetId) => {
    setTodo(todo.filter((item) => item.id !== targetId));
  };

  return (
    <div className="App">
      <Header />
      <TodoEditor onCreate={onCreate} />
      <TodoList todo={todo} onUpdate={onUpdate} onDelete={onDelete} />
    </div>
  );
}
export default App;
