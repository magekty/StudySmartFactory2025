export default function TodoItem({ todo }) {
  return (
    <li style={{ textDecoration: todo.done ? 'line-through' : 'none' }}>
      {todo.text}
    </li>
  );
}
