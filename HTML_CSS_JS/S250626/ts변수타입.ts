// JS
let age = 30;
let nameOfstudent = "김부산";
let isAdmin = true;

// TS
let age2: number = 30;
let nameOfstudent2: string = "김부산";
let isAdmin2: boolean = true;

// 배열
// JS
let scores = [80, 90, 100];
// TS
let scores2: number[] = [80, 90, 100];
let scores3: Array<number> = [80, 90, 100];
let nameOfstudents: Array<string> = ["부산", "센텀"];

// gkatn
// JS
/* function hello(name_stu) {
  return "hello " + name_stu;
} */
// TS
function hello2(name_stu2: string): string {
  return "hello " + name_stu2;
}

// 객체
// JS
const student = {
  name: "김부산",
  age: 20,
};
// TS
type studentType = {
  name: string;
  age: number;
};
const student2: studentType = {
  name: "김부산",
  age: 20,
};
type studentOptional = {
  name: string; // 필수 속성
  age?: number; // 선택 항목
};
const student4: studentOptional = {
  name: "김부산",
};
const student5: studentOptional = {
  name: "김부산",
  age: 20,
};
/* const student6: studentType = {
  name: "김부산",
}; */
// 유니언
let value: string | boolean;
value = "";
value = false;
// value = 1;

// 자동 추론
let count = 5;
// count = "5";
count = 3;

// any (js -> ts 점진적 전환할 때 유용)
let valueToTS: any = 10;
valueToTS = "5";
valueToTS = 5;
