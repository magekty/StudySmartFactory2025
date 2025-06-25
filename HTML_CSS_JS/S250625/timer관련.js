// setTimeout

console.log("--시작--");
setTimeout(() => {
  console.log("--끝--");
}, 3000);
// console.log("--끝--");

let counter = 0;
const myTimer = setInterval(() => {
  if (counter > 10) clearInterval(myTimer);
  counter++;
  console.log("1초마다 실행됨");
}, 1000);
