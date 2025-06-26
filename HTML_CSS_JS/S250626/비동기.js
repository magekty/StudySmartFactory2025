function dispA() {
  console.log("A");
}
function dispB() {
  console.log("B");
}
function dispC() {
  console.log("C");
}
function dispB_delay2() {
  setTimeout(() => {
    console.log("B_2sec");
  }, 2000);
}
function process_main() {
  dispA();
  dispB();
  dispC();
}
function process_main_delay() {
  dispA();
  dispB();
  dispB_delay2();
  dispC();
}
//process_main();
// process_main_delay();
function dispBcallback(mycallback) {
  setTimeout(() => {
    console.log("B_2sec_callback");
    mycallback();
  }, 2000);
}
function process_main_delay_callback() {
  dispA();
  dispB();
  dispBcallback(dispC);
}
// process_main_delay_callback();

// 햄버거 주문 과정
// 1. 고객이 주문을 한다. 1000ms : order
// 2. 결제               500ms : pay
// 3. 조리실에 주문 전달   300ms : orderTx
// 4. 햄버거 조리        3000ms : cook
// 5. 햄버거 포장        1000ms : pack
// 6. 고객에게 전달       500ms : out
// 7. 고객의 내용물 확인   100ms : confirm

function order() {
  setTimeout(() => {
    console.log("고객이 주문을 한다. 1000ms");
  }, 1000);
}
function pay() {
  setTimeout(() => {
    console.log("결제               500ms");
  }, 500);
}
function orderTx() {
  setTimeout(() => {
    console.log("조리실에 주문 전달   300ms");
  }, 300);
}
function cook() {
  setTimeout(() => {
    console.log("햄버거 조리        3000ms");
  }, 3000);
}
function pack() {
  setTimeout(() => {
    console.log("햄버거 포장        1000ms");
  }, 1000);
}
function out() {
  setTimeout(() => {
    console.log("고객에게 전달       500ms");
  }, 500);
}
function confirm() {
  setTimeout(() => {
    console.log("고객의 내용물 확인   100ms");
  }, 100);
}
function getBurger() {
  order();
  pay();
  orderTx();
  cook();
  pack();
  out();
  confirm();
}

// getBurger();

// callback 지옥
function* getBurger1() {
  yield order();
  yield pay();
  yield orderTx();
  yield cook();
  yield pack();
  yield out();
  yield confirm();
}
let g = getBurger1();
// g.next();

function getBurgerCallback() {
  setTimeout(() => {
    console.log("1. 고객이 주문을 한다. 1000ms");
    setTimeout(() => {
      console.log("2. 결제               500ms");
      setTimeout(() => {
        console.log("3. 조리실에 주문 전달   300ms");
        setTimeout(() => {
          console.log("4. 햄버거 조리        3000ms");
          setTimeout(() => {
            console.log("5. 햄버거 포장        1000ms");
            setTimeout(() => {
              console.log("6. 고객에게 전달       500ms");
              setTimeout(() => {
                console.log("7. 고객의 내용물 확인   100ms");
              }, 100);
            }, 500);
          }, 1000);
        }, 3000);
      }, 300);
    }, 500);
  }, 1000);
}
// getBurgerCallback();

/* promise
new Promise((resolve, reject)) => {

})

let isPizza = true;
const pizza = new Promise((resolve, reject) => {
  if (isPizza) resolve("피자 주문 ok");
  else reject("피자 주문 취소");
});

pizza
  .then((result) => console.log(result))
  .catch((err) => console.log("error"))
  .finally(() => console.log("step 하나 완료")); */

const pizza = (mes) => {
  return new Promise((resolve, reject) => resolve("피자를 주문합니다."));
};
const step1 = (mes) => {
  console.log(mes);
  return new Promise((resolve, reject) => {
    setTimeout(() => resolve("피자 도우 준비"), 3000);
  });
};
const step2 = (mes) => {
  console.log(mes);
  return new Promise((resolve, reject) => {
    setTimeout(() => resolve("피자 토핑 준비"), 1000);
  });
};
const step3 = (mes) => {
  console.log(mes);
  return new Promise((resolve, reject) => {
    setTimeout(() => resolve("굽기"), 3000);
  });
};
/* pizza()
  .then((res) => step1(res))
  .then((res) => step2(res))
  .then((res) => step3(res))
  .then((res) => console.log(res));
function abc() {
  for (let index = 0; index < 10000; index++) {
    console.log(index);
  }
}
abc(); */
// async await
async function asyncWhatIsYourOrder() {
  let myOrder = "한솥도시락";
  return myOrder;
}
async function asyncShowYourOrder(mes) {
  return `async: ${mes}를 주문 받았습니다.`;
}
// asyncWhatIsYourOrder().then(asyncShowYourOrder).then(console.log);

async function order() {
  const res = await asyncWhatIsYourOrder();
  const res2 = await asyncShowYourOrder(res);
  console.log(res2);
}

// order();
