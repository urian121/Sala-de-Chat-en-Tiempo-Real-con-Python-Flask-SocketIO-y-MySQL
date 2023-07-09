const uploadInput = document.getElementById("upload-input");
const avatarImg = document.getElementById("avatar-img");
const cameraImg = document.getElementById("camera-img");

uploadInput.addEventListener("change", function (e) {
  const file = e.target.files[0];
  const reader = new FileReader();

  reader.onload = function (e) {
    avatarImg.src = e.target.result;
  };

  reader.readAsDataURL(file);
});
