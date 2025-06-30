import "./LifeCycleSample.css";
import { Component } from "react";

// Life Cycle
// will 작동 전에 앞으로 일어날 동작
// did: 작동 후
// mount -> update -> unmount
// mount: constructor -> getDerivedStateFromProps -> render -> componentDidMount
// update: props, state, 부모의 화면, this.forceUpdate 등이 바뀔 때
//         getDerivedStateFromProps -> shouldComponentUpdate -> render ->
//         getSnapshotBeforeUpdate -> componentDidUpdate
// unmount: componentWillUnmount

class LifeCycleSample extends Component {
  constructor(props) {
    super(props);
    this.state = {
      number: 0,
      color: null,
    };
    console.log("난 지금 생성자 진행함");
  }
  static getDerivedStateFromProps(nextProps, prevState) {
    console.log("난 지금 getDerivedStateFromProps");
    if (nextProps.color !== prevState.color) return { color: nextProps.color };
    return null;
  }
  plusHandler = () => {
    this.setState({ number: this.state.number + 1 });
  };
  render() {
    console.log("난 지금 render 상태");
    return (
      <div>
        <h1 style={{ color: this.props.color }}>{this.state.number}</h1>
        <p>color:{this.state.color}</p>
        <button onClick={this.plusHandler}>증가</button>
      </div>
    );
  }
  componentDidMount() {
    console.log("난 지금 componentDidMount 상태");
  }
  shouldComponentUpdate(nextProps, nextState) {
    console.log("난 지금 shouldComponentUpdate 상태");
    return true;
  }
  getSnapshotBeforeUpdate(prevProps, prevState) {
    console.log("난 지금 getSnapshotBeforeUpdate 상태");
    return true;
  }
  componentDidUpdate(prevProps, prevState, snapshot) {
    console.log("난 지금 componentDidUpdate 상태");
    if (snapshot) console.log("snapshot(업데이트 전의 색상): ", snapshot);
  }
  componentWillUnmount() {
    console.log("난 지금 componentWillUnmount 상태");
  }
}

export default LifeCycleSample;
