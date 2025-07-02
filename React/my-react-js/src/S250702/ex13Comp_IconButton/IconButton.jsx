import "./IconButton.css";

const IconButton = ({ icon, label, onClick, isDisabled }) => {
  return (
    <div className="IconButton">
      <button disabled={isDisabled} className="IconButton" onClick={onClick}>
        <span className="icon">{icon}</span>
        <span className="label">{label}</span>
      </button>
    </div>
  );
};

export default IconButton;
