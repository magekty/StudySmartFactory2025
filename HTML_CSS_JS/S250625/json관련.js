// JSON.stingify()
// JSON.parse()

const student = {
  name: "김부산",
  age: 50,
  specialty: "해양",
  isMarryed: false,
};
const jsonStudent = JSON.stringify(student);
console.log(student);
console.log(jsonStudent);
const objectStudent = JSON.parse(jsonStudent);
console.log(objectStudent);
