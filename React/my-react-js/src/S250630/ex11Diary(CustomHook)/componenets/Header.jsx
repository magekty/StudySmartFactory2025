import "./Header.css";
const Header = ({ title, leftChild, rightChild }) => {
  return (
    <div className="Header">
      <div className="header-left">{leftChild}</div>
      <div className="header-title">{title}</div>
      <div className="header-right">{rightChild}</div>
    </div>
  );
};

export default Header;
