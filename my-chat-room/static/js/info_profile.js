const bodyHTML = document.body;
bodyHTML.addEventListener("click", (event) => {
  event.preventDefault();

  let body_chat = document.querySelector(".chat");
  let profile_ = $(".user-profile");
  let chat_ = $(".chat");

  if (
    event.target.classList.contains("messaging-member") ||
    event.target.classList.contains("messaging-member__message")
  ) {
    chat_.fadeIn();
    chat_.addClass("chat--show");
  } else if (event.target.classList.contains("bi-arrow-down")) {
    body_chat.classList.remove("chat--show");
  } else if (event.target.classList.contains("bi-three-dots")) {
    profile_.fadeIn();
    profile_.addClass("user-profile--show");
  } else if (event.target.classList.contains("bi-x-lg")) {
    profile_.removeClass("user-profile--show");
  }
});
