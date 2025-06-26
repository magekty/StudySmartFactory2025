// type, interface

// type
// 기본 객체 구조
type Animal = {
  name: string;
  age: number;
};
type DogAnimal = Animal & {
  breed: string;
};
const dog1: DogAnimal = {
  name: "chuchu",
  age: 5,
  breed: "시추",
};

type PetType = "dog" | "cat" | "fish";
function getPetInfo(type: PetType) {
  if (type == "dog") return 1;
  else if (type == "cat") return "ㅁ";
  else return 3;
}
// console.log(getPetInfo("cat"));
// console.log(getPetInfo("horse"));

interface Animal_interface {
  name: string;
  age: number;
}

interface Dog extends Animal_interface {
  mungmung(): void;
}
interface Cat extends Animal_interface {
  yaong(): void;
}
const myDog: Dog = {
  name: "busan",
  age: 5,
  mungmung() {
    console.log("mung mung!");
  },
};

interface Animal4Class {
  name: string;
  speak(): void;
}
class cDog implements Animal4Class {
  name: string;
  constructor(name: string) {
    this.name = name;
  }
  speak(): void {
    console.log(`${this.name}이 speaks mung mung!`);
  }
}
class cCat implements Animal4Class {
  name: string;
  constructor(name: string) {
    this.name = name;
  }
  speak(): void {
    console.log(`${this.name}가 speaks ya-ong!`);
  }
}
function speakYourSound(animal: Animal4Class): void {
  animal.speak();
}
const dog = new cDog("뭉치");
const cat = new cCat("망치");
speakYourSound(dog);
speakYourSound(cat);

class Zoo {
  private animals: Animal4Class[] = [];
  addAnimal(animal: Animal4Class): void {
    this.animals.push(animal);
  }
  speakAllanimals(): void {
    this.animals.forEach((a) => a.speak());
  }
}
const zoo = new Zoo();
zoo.addAnimal(dog);
zoo.addAnimal(cat);
zoo.speakAllanimals();
