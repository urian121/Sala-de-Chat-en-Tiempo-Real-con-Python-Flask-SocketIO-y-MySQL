// Importando el objeto socket
import { socket } from "./socketIO.js";

//Accediendo al input con id mensaje
const mensajeInput = document.querySelector("#mensaje");

// Asignando el focus por defecto al input con id mensaje
mensajeInput.focus();

/**
 * Procesar formulario del Chat
 */
const form_chat = document.querySelector("#formulario_chat");
if (form_chat) {
  // Llamar a la función para obtener el elemento fileInput
  const fileInput = creandoInputFile();

  form_chat.addEventListener("submit", async (event) => {
    event.preventDefault();

    const mensajeInput = document.querySelector("#mensaje");
    const selectedFile = fileInput.files[0]; // Obtener el archivo seleccionado
    // Creando un objeto FormData con los datos del formulario
    const formData = new FormData();

    /**
     * Con !mensajeInput.value.trim() verifico si el campo de mensaje está vacío o contiene solo espacios en blanco.
     * Y con !selectedFile verifica si no se ha seleccionado ningún archivo.
     * Si ambas condiciones son verdaderas, se ejecuta el código dentro del bloque
     */
    if (!mensajeInput.value.trim() && !selectedFile) {
      console.log("Formulario vacío");
      mensajeInput.style.border = "1px solid #ffb2a0";
      return; // Detener el envío del formulario
    }

    // Reproducir el archivo de audio después de recibir una respuesta exitosa
    const audio = new Audio("static/audio/audio_chat.mp3");
    audio.play();

    //limpio el border del input mensaje
    mensajeInput.style.border = "";

    //Agregando los campos mensaje y archivo al objeto formData
    formData.append("mensaje", mensajeInput.value);
    formData.append("archivo", selectedFile);

    const url_form = "procesar-form-chat";
    try {
      // envía los datos del formulario al servidor
      const response = await axios.post(url_form, formData);

      // procesa la respuesta del servidor
      if (response.status === 200) {
        socket.emit("mensaje_chat", "OK");
        console.log("Mensaje enviado.");
        form_chat.reset();
      } else {
        console.log("Hubo un error en el servidor.");
      }
    } catch (error) {
      console.log("Hubo un error al enviar los datos.");
    } finally {
      console.log("peticion finalizada");
    }
  });

  // Agrega el elemento fileInput al formulario
  form_chat.appendChild(fileInput);
}

/**
 * Creando input type file
 */
function creandoInputFile() {
  // Crea el elemento el input type="file" y configúralo
  const fileInput = document.createElement("input");
  fileInput.type = "file";
  fileInput.style.display = "none";
  fileInput.name = "archivo"; // Establece el nombre del campo del archivo
  fileInput.accept = "image/*";
  fileInput.multiple = false; // Acepta solo una imagen

  // Click en la clase svg-icon--send-img
  const sendImgButton = document.querySelector(".svg-icon--send-img");
  sendImgButton.addEventListener("click", () => fileInput.click());

  return fileInput;
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
