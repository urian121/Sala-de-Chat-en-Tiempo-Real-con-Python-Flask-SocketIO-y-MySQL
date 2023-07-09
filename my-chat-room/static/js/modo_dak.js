const darkModeToggler = document.querySelector(".dark_mode_toogler");
const body = document.querySelector("body");
const miNav = document.querySelector("#mi_nav");

// Verificar el estado actual del modo oscuro en el localStorage
let darkModeEnabled = localStorage.getItem("darkMode") === "true";
updateDarkMode();

// Agregar un event listener al botón de alternar modo oscuro
darkModeToggler.addEventListener("click", function () {
  darkModeEnabled = !darkModeEnabled;

  if (body.classList.contains("backgroundBody")) {
    body.classList.replace("backgroundBody", "dark-mode");
  } else if (body.classList.contains("dark-mode")) {
    body.classList.replace("dark-mode", "backgroundBody");
  }
  updateDarkMode();
});

function updateDarkMode() {
  body.classList.toggle("dark-mode", darkModeEnabled);
  miNav.classList.toggle("nav_nocturno", darkModeEnabled);
  localStorage.setItem("darkMode", darkModeEnabled);
}
