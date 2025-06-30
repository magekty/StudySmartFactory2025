import {
  BrowserRouter,
  Link,
  Route,
  Routes,
  useParams,
} from "react-router-dom";
import "./App.css";
const HOME = () => {
  return (
    <div>
      <h1>Home</h1>
      <Link to="/about">About</Link>
    </div>
  );
};
const About = () => {
  return (
    <div>
      <h1>About</h1>
      <Link to="/user/1">User1</Link>
    </div>
  );
};
const User1 = () => {
  return (
    <div>
      <h1>User1</h1>
      <Link to="/user/2">User2</Link>
    </div>
  );
};
const User2 = () => {
  return (
    <div>
      <h1>User2</h1>
      <Link to="/">HOME</Link>
    </div>
  );
};
const User = () => {
  const { userId } = useParams("userId");
  // switch (userId) {
  //   case 1:
  //     return (
  //       <div>
  //         <h1>User1</h1>
  //         <Link to="/">HOME</Link>
  //       </div>
  //     );
  //   case 2:
  //     return (
  //       <div>
  //         <h1>User2</h1>
  //         <Link to="/">HOME</Link>
  //       </div>
  //     );
  //   default:
  //     return;
  // }
  return (
    <div>
      <h1>User</h1>
      <p>{userId}님 어서오세여</p>
    </div>
  );
};

const App = () => {
  // 동적인 코드
  return (
    <BrowserRouter>
      <nav>
        <ul>
          <li>
            <Link to="/">HOME</Link>
          </li>
          <li>
            <Link to="/about">About</Link>
          </li>
          <li>
            <Link to="/user/1">User1</Link>
          </li>
          <li>
            <Link to="/user/2">User2</Link>
          </li>
        </ul>
      </nav>
      <Routes>
        <Route path="/" element={<HOME />} />
        <Route path="/about" element={<About />} />
        <Route path="/user/:userId" element={<User />} />
        {/* <Route path="/user/2" element={<User2 />} /> */}
      </Routes>
    </BrowserRouter>
  );
};

export default App;
