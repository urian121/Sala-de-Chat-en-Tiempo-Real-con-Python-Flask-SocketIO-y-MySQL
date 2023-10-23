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
    descargar_foto(event.target.id);
  } else if (event.target.classList.contains("bi-wechat")) {
    window.location.href = window.location.href;
  }

  // Obligando a enviar el formulario apenas se cargue la imagen
  /*fileInput.addEventListener("change", (event) => {
    sendForm(event.target);
  });
  */
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

/**
 *  Funcion para descargar imagen desde el Chat
 */
function descargar_foto(foto) {
  let host = window.location.host;
  let urlImagen = `http://${host}/static/archivos_chat/${foto}`;
  let link = document.createElement("a");
  link.href = urlImagen;
  link.download = foto;
  link.click();
}

function limpiar_form() {
  document.querySelector("#mensaje").value = "";
  document.querySelector("#archivo_img").value = "";
  document.querySelector("#archivo_img").value = "";
}

/**
 * Escuchando el evento "mensaje_chat" en el cliente JavaScript y recibiendo el mensaje enviado desde el servidor
 */
socket.on("mensaje_chat", (mensajeBD) => {
  // Extraer los datos del mensaje
  let {
    desde_id_user,
    para_id_user,
    fecha_dia_mes_year,
    mensaje,
    archivo_img,
    file_audio,
  } = mensajeBD.info_msj;

  if (localStorage.getItem("amigoId")) {
    let amigo_click = localStorage.getItem("amigoId"); // Amigo seleccionado
    let amigo_en_sesion = localStorage.getItem("idSesion"); //Amigo en sesion

    console.log("Amigo seleccionado", amigo_click);
    console.log("Amigo en sesion", amigo_en_sesion);
    console.log("Para quien es el msj", para_id_user);
    console.log("Quien envia el mensaje", desde_id_user);

    if (
      (para_id_user == amigo_click && desde_id_user == amigo_en_sesion) ||
      (para_id_user == amigo_en_sesion && desde_id_user == amigo_click)
    ) {
      const listaMensajes = document.querySelector(".chat__list-messages");
      const clase_amigo =
        sesion_amigo !== para_id_user
          ? "chat__bubble--me"
          : "chat__bubble--you";
      const class_fecha = sesion_amigo !== para_id_user ? "fecha_chat" : "";
      const rutaBase = "/static/audios_chat/";
      const rutaBaseImg = "/static/archivos_chat/";
      const url_img =
        archivo_img !== null && archivo_img !== ""
          ? rutaBaseImg + archivo_img
          : "";

      const url_audio =
        file_audio !== null && file_audio !== "" ? rutaBase + file_audio : "";

      const mensajeLi = document.createElement("li");
      mensajeLi.innerHTML = `
  <div class="chat__time ${class_fecha}">${fecha_dia_mes_year}</div>

      ${
        url_img !== ""
          ? `<div class="contenedor_img">
            <img
              src="${url_img}"
              alt=""
              style="max-width: 80%" />
            <a href="#">
              <i id="${archivo_img}" class="bi bi-cloud-arrow-down"></i>
            </a>
          </div>`
          : ""
      }

    ${
      url_audio !== ""
        ? `
      <br />
      <audio
        src="${url_audio}"
        controls>
        Tu navegador no admite la reproducción de audio.
      </audio>`
        : ""
    }

    ${
      mensaje !== null && mensaje !== ""
        ? `<div class="chat__bubble ${clase_amigo}">${mensaje}</div>`
        : ""
    }
  `;

      listaMensajes.appendChild(mensajeLi);

      scroll_chat();

      //Emitir el evento 'posicionar_mensajes' al servido, para posicionar el mensaje como reciente
      socket.emit("posicionar_mensajes", para_id_user);
    }
  }
});

socket.on("posicionar_mensajes", (para_id_user) => {
  let elementoActivo = document.querySelector(
    ".messaging-member.messaging_member_active"
  );

  if (elementoActivo) {
    let lista = document.querySelector("ul.messages-page__list"); // Selecciona la lista <ul>
    if (elementoActivo && lista) {
      elementoActivo.classList.add("transicion-efecto"); // Aplica la clase de transición
      lista.insertBefore(elementoActivo, lista.firstElementChild);
      setTimeout(function () {
        elementoActivo.classList.remove("transicion-efecto"); // Elimina la clase de transición
      }, 5);
    }
  }
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
