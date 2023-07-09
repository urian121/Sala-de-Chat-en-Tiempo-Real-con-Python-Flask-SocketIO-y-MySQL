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

const bodyHTML = document.body;
bodyHTML.addEventListener("click", (event) => {
  event.preventDefault();

  if (
    event.target.classList.contains("messaging-member") ||
    event.target.classList.contains("messaging-member__message")
  ) {
    $chat.fadeIn();
    $chat.addClass("chat--show");
  } else if (event.target.classList.contains("bi-arrow-down")) {
    $chat.removeClass("chat--show");
  } else if (event.target.classList.contains("bi-three-dots")) {
    $profile.fadeIn();
    $profile.addClass("user-profile--show");
  } else if (event.target.classList.contains("bi-x-lg")) {
    $profile.removeClass("user-profile--show");
  }
});
