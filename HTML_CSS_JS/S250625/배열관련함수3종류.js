// map: 일괄처리
let num50manjum = [10, 20, 30, 40, 50];
let num100manjum = [10, 20, 40, 30, 70];

let nums50to100 = [];
for (let i = 0; i < 5; i++) {
  nums50to100[i] = num50manjum[i] * 2;
}
console.log(nums50to100);

let nums50to100_2 = num50manjum.map((num) => num * 2);
console.log(nums50to100_2);

// filter : 조건 주어서 걸러냄
// 60 이상 걸러내기
let filtered60 = [];
for (let i = 0; i < 5; i++) {
  if (nums50to100[i] >= 60) filtered60.push(nums50to100[i]);
}

console.log(nums50to100);
console.log(filtered60);

let temperatures = [23, 24, 25, 26, 29, 27, 23, 20];
let highTemp = temperatures.filter((temp) => temp >= 25);
console.log(highTemp);

let highTemp2 = temperatures.filter((temp, i) => {
  if (temp >= 25) {
    console.log(`${i}: ${temp}`);
    return temp >= 25;
  }
});
console.log(highTemp2);

// reduce : 누적 계산
let data = [1, 2, 3, 4, 5];
let sum = 0;
for (let i = 0; i < data.length; i++) {
  sum += data[i];
}
console.log(sum);
let sum2 = data.reduce((total, now) => total + now, 0);
let gop = data.reduce((total, now) => total * now, 1);
console.log(sum2, gop);
