// JS 오류 vs TS 장점
/* // JS style // 함수 인자 타입 오류
function hello(name) {
  return "hello" + name.toUpperCase();
}
console.log(hello("kty"));

// TS style // compile때 오류 파악 가능
function hello1(name: string) {
  return "hello " + name.toUpperCase();
}
console.log(hello1(1));
// TSError: ⨯ Unable to compile TypeScript:
// S250626/js오류ts장점.ts(11,20): error TS2345: Argument of type 'number' is not assignable to parameter of type 'string'. */

// 객체 속성 접근 오류
/* // js style - runtime error
const user = { name: "김부산" };
console.log(user.age.toFiexd(1));

// ts style - compile error
const user2 = { name: "김부산" };
console.log(user2.age.toFiexd(1));
// TSError: ⨯ Unable to compile TypeScript:
// S250626/js오류ts장점.ts(22,19): error TS2339: Property 'age' does not exist on type '{ name: string; }'. */

// 배열에서 타입 혼재(숫자, 문자열)
/* const numbers = [1, 2, "3", 4];
const total = numbers.reduce((sum, n) => sum + n, 0); */

// 객체 속성 오타
/* // js style
const user3 = { name: "김부산", email: "as@as.com" };
console.log(user3.emial);
// ts style
const user3 = { name: "김부산", email: "as@as.com" };
console.log(user3.emial); */

// null check, js는 x, ts는 ok
/* function myPrint(value: string | null) {
  if (value.length) {
    console.log(value.length);
  }
}
myPrint(null); */
