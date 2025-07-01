import { useEffect, useState } from "react";
import Button from "./Button";
import "./DiaryList.css";
import DiaryItem from "./DiaryItem";
import { useNavigate } from "react-router-dom";

const sortOptionList = [
  { value: "latest", name: "최신 순" },
  { value: "oldest", name: "오래된 순" },
];
const DiaryList = ({ data }) => {
  const [sortedData, setSortedData] = useState([]);
  const [sortType, setSortType] = useState("latest");

  useEffect(() => {
    const compare = (a, b) => {
      if (sortType === "latest") return Number(b.date) - Number(a.date);
      else return Number(a.date) - Number(b.date);
    };
    const copyList = JSON.parse(JSON.stringify(data));
    // const copyList = structuredClone(data); // 가장 최신 표준방법 구조화된 복사

    copyList.sort(compare);
    setSortedData(copyList);
  }, [data, sortType]);
  const navigate = useNavigate();
  const onClickNew = () => {
    navigate("/new");
  };
  const onChangeSortType = (event) => {
    setSortType(event.target.value);
  };

  return (
    <div className="DiaryList">
      <div className="menu-wrapper">
        <div className="left-col">
          <select value={sortType} onChange={onChangeSortType}>
            {sortOptionList.map((item, index) => (
              <option key={index} value={item.value}>
                {item.name}
              </option>
            ))}
          </select>
        </div>
        <div className="right-col">
          <Button text={"새 일기 쓰기"} onClick={onClickNew} />
        </div>
      </div>
      <div className="list-wrapper">
        {sortedData.map((item) => (
          <DiaryItem key={item.id} {...item} />
        ))}
      </div>
    </div>
  );
};

export default DiaryList;
