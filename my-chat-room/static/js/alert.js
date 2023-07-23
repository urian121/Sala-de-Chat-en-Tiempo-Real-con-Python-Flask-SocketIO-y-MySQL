/**
 * Funcion para lenvantar alerta desde el JavaScript
 */
function my_alert(msj, tipo_msj) {
  // Verificar si ya existe el div con id='myNotification'
  const divExistente = document.querySelector("#myNotification");
  if (divExistente) {
    divExistente.remove();
  }

  // Crear un div
  const mensajeDiv = document.createElement("div");
  mensajeDiv.id = "myNotification";

  // Agregar el div después del body
  const body = document.querySelector("body");
  body.insertAdjacentElement("afterend", mensajeDiv);

  // Establecer el contenido del div
  mensajeDiv.innerHTML = `
    <div class="toast_custom active" style="position: fixed; min-width: 50%;">
      <div class="toast-content">
      ${
        tipo_msj == "success"
          ? `<i class="bi bi-check-circle-fill" style="font-size: 30px; color: #1a7ee6;"></i>`
          : `<i class="bi bi-exclamation-triangle icon_error"></i>`
      }
        <div class="message">
          <span class="text text-1">
          ${tipo_msj == "success" ? "Felicitaciones " : `Recuerder`}
          </span>
          <span class="text text-2"> ${msj} </span>
        </div>
      </div>
        <i class="close bi bi-x"></i>
      <div class="progress active"></div>
    </div>
  `;

  const alert_custom = document.querySelector(".toast_custom");
  const closeIcon = document.querySelector(".close");
  const progress = document.querySelector(".progress");

  closeIcon.addEventListener("click", () => {
    alert_custom.classList.remove("active");
    setTimeout(() => {
      progress.classList.remove("active");
    }, 300);
  });

  setTimeout(() => {
    alert_custom.classList.remove("active");
  }, 8000);
}
