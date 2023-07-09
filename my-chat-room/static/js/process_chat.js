// Importando el objeto socket
import { socket } from "./socketIO.js";

/**
 * En lugar de asignar directamente el evento click al botón, ahora asignamos el evento
 * click al contenedor (en este caso, el body).
 * Luego, verificamos si el evento click ocurrió en el botón con id "click" dentro del evento delegado.
 * En resumen, este código permite detectar y manejar los clics
 * en el botón con ID "click" dentro del botón contenedor.
 */
const bodyHTML = document.body;
const fileInput = document.querySelector("#archivo_img");
bodyHTML.addEventListener("click", (event) => {
  event.preventDefault();
  const submitButton = document.querySelector(".custom-form__send-submit");
  const svgIcon = document.querySelector(".svg-icon--send");
  const svgSendFile = document.querySelector(".svg-icon--send-img");

  if (
    event.target.type === "submit" ||
    event.target.isEqualNode(submitButton) ||
    event.target.isEqualNode(svgIcon) ||
    svgIcon.contains(event.target)
  ) {
    sendForm(event.target);
  } else if (
    event.target.classList.contains("custom-form__send-img") ||
    event.target.classList.contains("svg-icon--send-img")
  ) {
    fileInput.dispatchEvent(new MouseEvent("click"));
  } else if (event.target.classList.contains("bi-cloud-arrow-down")) {
    descargar_foto(event.target);
  }
  // Obligando a enviar el formulario apenas se cargue la imagen
  /*fileInput.addEventListener("change", (event) => {
    sendForm(event.target);
  });
  */

  /*else if (svgSendFile.contains(event.target)) {
    bodyHTML.addEventListener("click", (event) => {
      if (event.target.classList.contains("svg-icon--send-img")) {
        fileInput.dispatchEvent(new MouseEvent("click"));
      }
    });
  }*/
});

async function sendForm(submitButton) {
  //Se utiliza para obtener la referencia al elemento <form> más cercano al botón de envío (submitButton)
  const form_chat = submitButton.closest("form");

  const mensajeInput = document.querySelector("#mensaje");
  const archivo_img = document.querySelector("#archivo_img");
  const selectedFile = archivo_img.files[0];

  const formData = new FormData(form_chat);

  /**
   * Con !mensajeInput.value.trim() verifico si el campo de mensaje está vacío o contiene solo espacios en blanco.
   * Y con !selectedFile verifica si no se ha seleccionado ningún archivo.
   * Si ambas condiciones son verdaderas, se ejecuta el código dentro del bloque
   */
  if (!mensajeInput.value.trim() && !selectedFile) {
    mensajeInput.style.border = "1px solid #ffb2a0";
    return; // Detener el envío del formulario
  }

  //limpio el border del input mensaje
  mensajeInput.style.border = "";

  const audio = new Audio("static/audio/audio_chat.mp3");
  audio.play();

  if (archivo_img && selectedFile) {
    formData.append("archivo_img", selectedFile);
  }

  // console.log("Mi Data:", formData);

  const url_form = "/procesar-form-chat";
  try {
    const response = await axios.post(url_form, formData);

    if (response.status === 200) {
      let data_info_chat = {
        desde_id_user: parseInt(document.querySelector("#desde_id_user").value),
        para_id_user: parseInt(document.querySelector("#para_id_user").value),
      };
      // Emitir el evento con los dos valores
      socket.emit("mensaje_chat", data_info_chat);

      // socket.emit("mensaje_chat", "OK");
      limpiar_form();
    } else {
      console.log("Hubo un error en el servidor.");
    }
  } catch (error) {
    console.log("Hubo un error al enviar los datos.");
  } finally {
    console.log("Petición finalizada");
  }
}

async function descargar_foto(foto) {
  console.log("Hola ", foto.id);
  let foto_chat = foto.id;

  try {
    const response = await axios.post("/descargar_foto_chat", {
      foto_chat,
    });
    if (response.status === 200) {
      console.log("todo Bello");
    } else {
      console.log("Hubo un error en el servidor.");
    }
  } catch (error) {
    console.log("Hubo un error al enviar los datos.");
  }
}

function limpiar_form() {
  document.querySelector("#mensaje").value = "";
  document.querySelector("#archivo_img").value = "";
  document.querySelector("#archivo_img").value = "";
}

/**
 * Escuchando el evento "mensaje_chat" en el cliente JavaScript y recibiendo el mensaje enviado desde el servidor
 */
socket.on("mensaje_chat", (mensaje) => {
  scroll_chat();
  const divContent = document.querySelector(".chat__content");
  divContent.innerHTML = "";
  divContent.innerHTML += mensaje;
});

/**
 * Manipular el scroll cuando existe un nuevo mensaje
 */
const scroll_chat = () => {
  const chatContent = document.querySelector(".chat__content");
  const scrollHeight = chatContent.scrollHeight;

  // Realiza la animación del scroll
  const scrollToBottom = () => {
    const scrollOptions = {
      top: scrollHeight,
      behavior: "smooth",
    };
    chatContent.scrollTo(scrollOptions);
  };

  // Llama a la función para realizar la animación después de un breve retraso
  setTimeout(scrollToBottom, 100); // Ajusta el valor del retraso según sea necesario
};
