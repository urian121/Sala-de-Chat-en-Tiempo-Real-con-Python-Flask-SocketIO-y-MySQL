$chat = $(".chat");
$profile = $(".user-profile");

/* ===================================
    Screen resize handler
====================================== */
const smallDevice = window.matchMedia("(max-width: 767px)");
const largeScreen = window.matchMedia("(max-width: 1199px)");
smallDevice.addEventListener("change", handleDeviceChange);
largeScreen.addEventListener("change", handleLargeScreenChange);

handleDeviceChange(smallDevice);
handleLargeScreenChange(largeScreen);

function handleDeviceChange(e) {
  if (e.matches) chatMobile();
  else chatDesktop();
}

function handleLargeScreenChange(e) {
  if (e.matches) profileToogleOnLarge();
  else profileExtraLarge();
}

function chatMobile() {
  $chat.addClass("chat--mobile");
}

function chatDesktop() {
  $chat.removeClass("chat--mobile");
}

function profileToogleOnLarge() {
  $profile.addClass("user-profile--large");
}

function profileExtraLarge() {
  $profile.removeClass("user-profile--large");
}

/* ===================================
    Events
====================================== */

$(".messaging-member").click(function () {
  $chat.fadeIn();
  $chat.addClass("chat--show");
});

$(".chat__previous").click(function () {
  $chat.removeClass("chat--show");
});

$(".chat__details").click(function () {
  $profile.fadeIn();
  $profile.addClass("user-profile--show");
});

$(".user-profile__close").click(function () {
  $profile.removeClass("user-profile--show");
});

/**
 * Modo Dark
 */
const darkModeToggler = document.querySelector(".dark_mode_toogler");
const body = document.querySelector("body");
const miNav = document.querySelector("#mi_nav");

// Verificar el estado actual del modo oscuro en el localStorage
let darkModeEnabled = localStorage.getItem("darkModeEnabled") === "true";
updateDarkMode();

// Agregar un event listener al botón de alternar modo oscuro
darkModeToggler.addEventListener("click", function () {
  darkModeEnabled = !darkModeEnabled;
  updateDarkMode();
});

function updateDarkMode() {
  body.classList.toggle("dark-mode", darkModeEnabled);
  miNav.classList.toggle("nav_nocturno", darkModeEnabled);
  localStorage.setItem("darkModeEnabled", darkModeEnabled);
}
