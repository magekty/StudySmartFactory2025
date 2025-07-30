import { BrowserRouter, Route, Routes, Link } from "react-router-dom";
import "./App.css";
import { useEffect, useState } from "react";
import { getToken, removeToken } from "./utils/api";
import { decodeJwt } from "./utils/decodeJwt";

import Home from "./components/Home";
import Register from "./components/Register";
import Login from "./components/Login";
import Profile from "./components/Profile";
import Admin from "./components/Admin";

function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);
  const [role, setRole] = useState(null);
  const [username, setUsername] = useState(null);

  useEffect(() => {
    const token = getToken();
    if (token) {
      setIsLoggedIn(true);
      const decoded = decodeJwt(token);
      setUsername(decoded.sub); // username - subject
      setRole(decoded.role); // ADMIN, USER
    }
  }, []);

  const handleLogout = () => {
    removeToken();
    setIsLoggedIn(false);
    setUsername(null);
    setRole(null);
  };

  return (
    <BrowserRouter>
      <div className="App">
        <h1>React + JWT Demo</h1>
        <nav>
          <Link to="/">홈</Link>
          {!isLoggedIn ? (
            <>
              <Link to="/register">회원가입</Link>
              <Link to="/login">로그인</Link>
            </>
          ) : (
            <>
              <Link to="/profile">프로필</Link>
              {role === "ADMIN" && <Link to="/admin">관리자</Link>}
              <button onClick={handleLogout}>로그아웃</button>
            </>
          )}
        </nav>
      </div>
      <Routes>
        <Route
          path="/"
          element={<Home isLoggedIn={isLoggedIn} username={username} />}
        />
        <Route path="/register" element={<Register />} />
        <Route
          path="/login"
          element={
            <Login
              onLogin={(token) => {
                setIsLoggedIn(true);
                const decoded = decodeJwt(token);
                setUsername(decoded.sub);
                setRole(decoded.role);
              }}
            />
          }
        />
        <Route path="/profile" element={<Profile />} />
        <Route path="/admin" element={<Admin />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
