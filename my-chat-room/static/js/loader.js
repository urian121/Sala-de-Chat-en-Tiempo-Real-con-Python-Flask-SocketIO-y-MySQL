window.addEventListener("load", (event) => {
  const loader = document.getElementById("loader-out");
  setTimeout(function () {
    loader.style.opacity = "0";
    setTimeout(function () {
      loader.style.display = "none";
    }, 400);
  }, 400);
});
