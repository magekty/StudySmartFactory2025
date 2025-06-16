import { Routes, Route } from 'react-router-dom';
import Home from './pages/Home';
import Todos from './pages/Todos';
import UserDetail from './pages/UserDetail';
import Header from './components/Header';

export default function App() {
  return (
    <>
      <Header />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/todos" element={<Todos />} />
        <Route path="/user/:id" element={<UserDetail />} />
        <Route path="*" element={<h2>페이지를 찾을 수 없습니다.</h2>} />
      </Routes>
    </>
  );
}
