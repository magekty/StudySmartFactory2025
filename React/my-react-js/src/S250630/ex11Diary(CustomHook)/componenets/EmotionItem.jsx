const EmotionItem = ({ id, img, name, onClick, isSelected }) => {
  const onClickHandler = () => {
    onClick(id);
  };
  return (
    <div
      className={[
        "EmotionItem",
        isSelected ? `EmotionItem-on-${id}` : `EmotionItem-off`,
      ].join(" ")}
      onClick={onClickHandler}
    >
      <img src={img} alt="" />
      <span>{name}</span>
    </div>
  );
};

export default EmotionItem;
