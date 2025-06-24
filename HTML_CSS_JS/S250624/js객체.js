let book = {
  title: "자바스크립트",
  page: 500,
  actRead: function () {
    console.log("~~~");
  },
};
//const myBook = new book();
let now = new Date();
console.log(now);
console.log(book);
book.actRead();
