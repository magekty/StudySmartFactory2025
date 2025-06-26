// TS
const btn = document.getElementById("btn") as HTMLButtonElement;
const msg = document.getElementById("message") as HTMLParagraphElement;
btn.addEventListener("click", function () {
  msg.textContent = "안녕";
});
