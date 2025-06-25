// 배열, 객체

let fruits = ["사과", "바나나"];

console.log(fruits[0]);

let apple = fruits[0];
let banana = fruits[1];
let [apple2, banana2] = ["사과", "바나나"];
console.log(apple2, banana2);
let [apple3, banana3] = fruits;
console.log(apple3, banana3);

let [a, b] = [];
console.log(a, b);
let seasons = ["봄", "여름", "가을", "겨울"];
let spring = seasons[0];
let fall = seasons[2];
let [spring2, , fall2] = ["봄", "여름", "가을", "겨울"];
console.log(spring2, fall2);
let [sensorType, ...sensorValue] = ["voltage", 380, 381, 382, 378];
console.log(sensorType);
console.log(sensorValue);

let classSmartFactory = {
  className: "smartFactory",
  numOfStudent: 17,
};
let className2 = classSmartFactory.className;
let numOfStudent2 = classSmartFactory.numOfStudent;
console.log(classSmartFactory);
console.log(className2);
console.log(numOfStudent2);
let { className: className3, numOfStudent: numOfStudent3 } = classSmartFactory;
console.log(className3);
console.log(numOfStudent3);
