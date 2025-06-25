console.log("---기본 for---");
let arr = ["a", "b", "c"];
for (let i = 0; i < arr.length; i++) {
  console.log(arr[i]);
}

console.log("---array foreach---");
arr.forEach((item) => console.log(item));

console.log("---객체: for in---");
const smartFactory = {
  classname: "스마트 팩토리",
  numOfStudent: 17,
  location: "센텀벤처타운",
};

for (key in smartFactory) {
  console.log(`key: ${key}, value: ${smartFactory[key]}`);
}

console.log("---iterable: for of---");
for (let item of arr) {
  console.log(item);
}
