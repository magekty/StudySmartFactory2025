import "./Button.css";
const Button = ({ label, onClick, isDisabled }) => {
  const type = "button";
  return (
    <button
      className="normal-button"
      onClick={onClick}
      type={type}
      disabled={isDisabled}
    >
      {label}
    </button>
  );
};
export default Button;
