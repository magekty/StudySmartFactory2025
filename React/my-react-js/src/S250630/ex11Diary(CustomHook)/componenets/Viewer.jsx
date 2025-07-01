import { emotionList } from "../Util";

const Viewer = ({ content, emotionId }) => {
  const emotionItem = emotionList.find((item) => item.id === emotionId);
  // console.log("Viewer props:", { content, emotionId });
  return (
    <div className="Viewer">
      <section>
        <h2>오늘의 감정</h2>
        <div
          className={[
            "emotion-img-wrapper",
            `emotion-img-wrapper-${emotionId}`,
          ].join(" ")}
        >
          <img src={emotionItem.img} alt="기분" />
          <div className="emotion-descript">{emotionItem.name}</div>
        </div>
      </section>
      <section>
        <h2>오늘의 일기</h2>
        <div className="content-wrapper">
          <p>{content}</p>
        </div>
      </section>
    </div>
  );
};
export default Viewer;

/* const Viewer = ({ content, emotionId }) => {
  const emotionItem = emotionList.find((item) => item.id === emotionId);
  console.log(emotionId);
  return (
    <div className="Viewer">
      <section>
        <h2>오늘의 감정</h2>
        <div
          className={[
            "emotion-img-wrapper",
            `emotion-img-wrapper-${emotionId}`,
          ].join(" ")}
        >
          <img src={emotionItem.img}></img>
          <div className="emotion-description">{emotionItem.name}</div>
        </div>
      </section>
      <section>
        <h2>오늘의 일기</h2>
        <div className="content-wrapper">
          <p>{content}</p>
        </div>
      </section>
    </div>
  );
};
export default Viewer;
 */