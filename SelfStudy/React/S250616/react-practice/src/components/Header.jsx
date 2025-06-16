import { Link } from 'react-router-dom';
import { useTheme } from '../context/ThemeContext';

export default function Header() {
  const { theme, toggleTheme } = useTheme();

  return (
    <header style={{ padding: 10, background: theme === 'dark' ? '#333' : '#eee' }}>
      <nav>
        <Link to="/">Home</Link> | <Link to="/todos">Todos</Link>
        <button onClick={toggleTheme} style={{ float: 'right' }}>
          {theme === 'dark' ? '라이트모드' : '다크모드'}
        </button>
      </nav>
    </header>
  );
}
