import { useState, useRef } from 'react';
import TodoItem from '../components/TodoItem';

export default function Todos() {
  const [todos, setTodos] = useState([{ id: 1, text: 'React 공부하기', done: false }]);
  const inputRef = useRef();

  const addTodo = () => {
    const text = inputRef.current.value;
    if (!text.trim()) return;
    setTodos([...todos, { id: Date.now(), text, done: false }]);
    inputRef.current.value = '';
  };

  return (
    <div>
      <h2>할 일 목록</h2>
      <input ref={inputRef} placeholder="할 일 입력" />
      <button onClick={addTodo}>추가</button>
      <ul>
        {todos.map((todo) => (
          <TodoItem key={todo.id} todo={todo} />
        ))}
      </ul>
    </div>
  );
}
