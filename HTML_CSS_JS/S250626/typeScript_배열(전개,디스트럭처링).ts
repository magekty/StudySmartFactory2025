// typeScript_배열(전개, 디스트럭처링)
/* const arr = [1, 2, 3];
const [a, b] = arr;

const arr2: number[] = [1, 2, 3];
const [a2, b2] = arr2;
console.log(a2, b2); */

// 객체 디스트럭처링
/* // JS
const user = { name: "김부산", age: 25 };
// const { name, age } = user;

// TS
type User2 = { name: string; age: number };
type AdminUser2 = User2 & { admin: boolean };
const user2: User2 = { name: "김부산", age: 25 };
const newUser2: AdminUser2 = { ...user, admin: true }; */

// default와 디스트럭처링
/* // JS
const { name3 = "김부산" } = {};
console.log("name3: " + name3);

// TS
type User = { name1?: string };
const user: User = {};
const { name1 = "김부산" } = user;
console.log("name1: " + name1); */

// 나머지 받기 (...rest)
// JS
const user4 = { name4: "김부산", age: 25, admin: true };
const { name4, ...rest } = user4;
console.log("user4 - name4" + name4);
console.log("user4 - rest" + rest);

// TS
type User = { name5: string; age: number; admin: boolean };
const user: User = { name5: "김부산", age: 25, admin: true };
const { name5, ...rest5 }: { name5: string } & Omit<User, "name5"> = user;
console.log(name5);
console.log(rest5);
