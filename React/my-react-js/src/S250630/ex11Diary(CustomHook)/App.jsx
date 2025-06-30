import { useEffect, useReducer, createContext, useRef } from "react";
import { BrowserRouter, Route, Routes } from "react-router-dom";

const mockData = [
  {
    id: 1,
    date: new Date("2025-07-01").getTime(),
    content: "오늘은 새 반장이 선출된 날",
    emotionId: 1,
  },
  {
    id: 2,
    date: new Date("2025-07-04").getTime(),
    content: "react oneday proj날",
    emotionId: 1,
  },
  {
    id: 3,
    date: new Date("2025-06-30").getTime(),
    content: "오늘은 6월 마지막 날",
    emotionId: 1,
  },
];
const reducer = (state, action) => {
  switch (action.type) {
    case "INIT":
      return action.data;
    case "CREATE":
      return [...state, action.data];
    case "UPDATE":
      return state.map((item) =>
        String(item.id) === String(action.data.id) ? { ...action.data } : item
      );
    case "DELETE":
      return state.filter((item) => String(item.id) !== String(action.data.id));
    default:
      return state;
  }
};
const Home = () => {};
const New = () => {};
const Diary = () => {};
const Edit = () => {};
const DiaryStateContext = createContext();
const DiaryDispatchContext = createContext();

const App = () => {
  const idRef = useRef(4);
  const [data, dispatch] = useReducer(reducer, []);
  useEffect(() => {
    dispatch({ type: "INIT", data: mockData });
  }, []);
  const onCreate = (date, content, emotionId) => {
    dispatch({
      type: "CREATE",
      data: {
        id: idRef.current,
        date: new Date(date).getTime(),
        content,
        emotionId,
      },
    });
    idRef.current++;
  };
  const onUpdate = (targetId, date, content, emotionId) => {
    dispatch({
      type: "UPDATE",
      data: {
        id: targetId,
        date: new Date(date).getTime(),
        content,
        emotionId,
      },
    });
  };
  const onDelete = (targetId) => {
    dispatch({
      type: "DELETE",
      targetId,
    });
  };
  return (
    <DiaryStateContext.Provider value={data}>
      <DiaryDispatchContext.Provider value={{ onCreate, onUpdate, onDelete }}>
        <BrowserRouter>
          <div className="App">
            <Routes>
              <Route path="/" element={<Home />} />
              <Route path="/new" element={<New />} />
              <Route path="/diary/:id" element={<Diary />} />
              <Route path="/edit/:id" element={<Edit />} />
              {/* <Route path="/delete/:id" element={<Delete/>}/> */}
            </Routes>
          </div>
        </BrowserRouter>
      </DiaryDispatchContext.Provider>
    </DiaryStateContext.Provider>
  );
};

export default App;
