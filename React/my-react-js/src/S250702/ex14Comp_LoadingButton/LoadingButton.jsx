import "./LoadingButton.css";

const LoadingButton = ({ label, onClick, loading }) => {
  return (
    <button className="loading-button" onClick={onClick} disabled={loading}>
      {loading ? <span className="spinner"></span> : label}
    </button>
  );
};

export default LoadingButton;
