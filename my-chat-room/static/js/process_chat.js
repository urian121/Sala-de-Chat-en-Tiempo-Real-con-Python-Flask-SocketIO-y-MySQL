/**
 * Solicitud que recibe el id del amigo seleccionado
 * retorna toda la información del amigo selecionado como (mensajes, audios, imagenes, perfil)
 */
async function amigo_seleccionado(id_amigo) {
  try {
    const response = await axios.post("/mostrar-amigo-seleccionado", {
      id_amigo,
    });
    if (!response.status) {
      console.log(`HTTP error! status: ${response.status} 😭`);
    }

    const sectionRecientes = document.querySelector(".user-profile");
    sectionRecientes.innerHTML = "";
    sectionRecientes.innerHTML = response.data;

    chat_amigo_seleccionado(id_amigo);
  } catch (error) {
    console.error(error);
  }
}

/**
 * Funcion que recibe el id del amigo seleccionado y retorna todos los chats del mismo.
 */
async function chat_amigo_seleccionado(id_amigo) {
  try {
    const response = await axios.post("/mostrar-chat-amigo-seleccionado", {
      id_amigo,
    });
    if (!response.status) {
      console.log(`HTTP error! status: ${response.status} 😭`);
    }

    const chat__container = document.querySelector(".chat__container");
    chat__container.innerHTML = "";
    chat__container.innerHTML = response.data;

    //Asignando un valor al campo para_id_user, es decir agregando el id del amigo seleccionado
    document.querySelector("#para_id_user").value = parseInt(id_amigo);

    //Accediendo al input con id mensaje
    const mensajeInput = document.querySelector("#mensaje");
    mensajeInput ? mensajeInput.focus() : "";

    // Crea un nuevo elemento <script>
    var scriptElement = document.createElement("script");
    scriptElement.src = "/static/js/form.js";

    // Agrega un event listener para el evento 'load' del script
    scriptElement.addEventListener("load", () => {
      // El archivo JS se ha cargado completamente
      console.log("Archivo JS cargado");
    });

    // Agrega el elemento <script> al documento
    document.body.appendChild(scriptElement);
  } catch (error) {
    console.error(error);
  }
}
