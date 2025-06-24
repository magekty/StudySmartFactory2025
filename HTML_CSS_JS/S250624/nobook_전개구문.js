// 전개 연산자 ...
let fruits = ["banana", "watermelon", "apple"];
for (let i = 0; i < fruits.length; i++) {
  //   console.log(fruits[i]);
}

// console.log(...fruits);

let patty = ["닭고기", "소고기", "돼지고기", "피쉬"];
let vegitable = ["토마토", "양파", "양상추"];
let burger = ["햄버거 빵", ...patty, vegitable];
// let test = [patty];
// console.log(`burger: ${test} 이고 ${test.length}개`);
// patty.splice(1, 1);

console.log(`burger: ${burger} 이고 ${burger.length}개`);
let burger2 = ["햄버거 빵", ...patty, ...vegitable];
console.log(`burger: ${burger2} 이고 ${burger2.length}개`);

// 함수에서 전개구문
const addNum = (...nums) => {
  let sum = 0;
  for (let i = 0; i < nums.length; i++) {
    sum += nums[i];
  }
  return sum;
};

console.log(addNum(1, 2, 3));

// concat
const arr2 = [1, 2, 3];
const arr3 = [4, 5, 6];
const arr4 = arr2.concat(arr3);
const arr5 = [...arr2, ...arr3];
console.log(arr4);
console.log(arr5);
