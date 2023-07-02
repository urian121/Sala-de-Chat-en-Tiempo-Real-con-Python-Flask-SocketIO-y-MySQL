let buton = document.querySelector("#click");
if (buton) {
  console.log(buton);
  console.log(document.querySelectorAll("#click"));
  buton.addEventListener("click", (event) => {
    console.log("Hay Click ---");
  });
}
