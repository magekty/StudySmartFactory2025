// iterable
// 배열(순서가 있음 index)
// 객체(순서가 없음 key:value)
let midTerm = [80, 90, 100]; // 국[0], 영[1], 수[2]
let finalTerm = {
  korean: 80,
  english: 90,
  math: 100,
};
console.log(finalTerm[0]); // undefined
// 대표적인 iterable Map, Set
console.log("#########################MAP############################");
let mapFinalTerm = new Map([
  ["korean", 80],
  ["english", 90],
  ["math", 100],
]);
console.log(mapFinalTerm);
console.log([...mapFinalTerm][0][1]); // [ 'korean', 80 ]
mapFinalTerm.set("science", 90); // 추가
console.log(mapFinalTerm);
console.log(mapFinalTerm.keys());
console.log(mapFinalTerm.values());
console.log(mapFinalTerm.entries());
for (let key of mapFinalTerm.keys()) {
  console.log(key);
}
console.log(mapFinalTerm.size);
console.log(mapFinalTerm.has("korean"));
mapFinalTerm.delete("korean");
console.log(mapFinalTerm);
mapFinalTerm.clear();
console.log(mapFinalTerm);
console.log("#########################SET############################");
// let setFinalTerm = new Set([
//   ["korean", 80],
//   ["english", 90],
//   ["math", 100],
// ]);
// console.log(setFinalTerm);
// console.log([...setFinalTerm][0]);

// Set (중복 제거)
let array = [1, 2, 4, 2, 1];
let set1 = new Set(array);
console.log(array);
console.log(set1);
set1.add(10);
console.log(set1);
console.log(set1.has(10));
set1.delete(2);
console.log(set1);
set1.clear();
console.log(set1);

let arr = [10, 20, 30, 40, 50];
let iterator = arr[Symbol.iterator]();
console.log(arr);
console.log(iterator.next());
console.log(iterator.next());
console.log(iterator.next());
console.log(iterator.next());
console.log(iterator.next());
console.log(iterator.next());

// generator
console.log("#########################Generator############################");
const fn1 = () => {
  console.log(1);
  console.log(2);
  console.log(3);
};
fn1();
function* gen1() {
  yield 1;
  yield 2;
  yield 3;
}
let g1 = gen1();
console.log(g1.next());
console.log(g1.next());
console.log(g1.next());
console.log(g1.next());
let g2 = gen1();
for (let item of g2) {
  console.log(item);
}
