var myMoney = 10000;

console.log(`내 통장에 ${myMoney}원이 있다.`);
myMoney += 10000;
console.log(`내 통장에 ${myMoney}원이 있다.`);

var myMoney = "내 사랑";
console.log(`내 통장에 ${myMoney}원이 있다.`);
let index = [];
let array = [1, 2, 3, 4, 5, 6, 7, 8];
// for (let index = 0; index < array.length; index++) {
//   const element = array[index];
//   this.index[index] = array[index];
//   console.log(`배열값:${element}`);
// }
// for (let index = 0; index < this.index.length; index++) {
//   console.log(`global - 배열값:${this.index}`);
// }
this.index[0] = 1;
console.log(`test:${index[0]}`);
