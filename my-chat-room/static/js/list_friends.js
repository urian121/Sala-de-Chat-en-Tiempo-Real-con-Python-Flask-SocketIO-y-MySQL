// Definiendo un estado para controlar cuando el archivo existe o no existe
let formScriptLoaded = false;
let ultimoIdAmigo = null;
let li_amigos = document.querySelectorAll(".messaging-member");
if (li_amigos) {
  li_amigos.forEach((item) => {
    item.addEventListener("click", () => {
      li_amigos.forEach((item) => {
        item.classList.remove("messaging-member--active");
      });

      item.classList.add("messaging-member--active");

      /**
       * Realizando solicitud HTTP
       */
      let id_amigo = parseInt(item.getAttribute("id"));
      if (ultimoIdAmigo === id_amigo) {
        // Termina la ejecución de la función sin realizar ninguna acción adicional
        return;
      } else {
        mostrar_amigo_y_chat_seleccionado(id_amigo);
      }
      ultimoIdAmigo = id_amigo;
    });
  });
}

/**
 * Solicitud que recibe el id del amigo seleccionado
 * retorna toda la información del amigo selecionado como (mensajes, audios, imagenes, perfil)
 */
async function mostrar_amigo_y_chat_seleccionado(id_amigo) {
  try {
    const responseAmigo = await axios.post("/mostrar-amigo-seleccionado", {
      id_amigo,
    });
    if (!responseAmigo.status) {
      console.log(`HTTP error! status: ${responseAmigo.status} 😭`);
    }

    const sectionRecientes = document.querySelector(".user-profile");
    sectionRecientes.innerHTML = "";
    sectionRecientes.innerHTML = responseAmigo.data;

    const responseChat = await axios.post("/mostrar-chat-amigo-seleccionado", {
      id_amigo,
    });
    if (!responseChat.status) {
      console.log(`HTTP error! status: ${responseChat.status} 😭`);
    }

    const chat__container = document.querySelector(".chat__container");
    chat__container.innerHTML = "";
    chat__container.innerHTML = responseChat.data;

    //Asignandole un valor al input 'para_id_user'
    document.querySelector("#para_id_user").value = parseInt(id_amigo);

    const mensajeInput = document.querySelector("#mensaje");
    mensajeInput ? mensajeInput.focus() : "";
  } catch (error) {
    console.error(error);
  } finally {
    if (!formScriptLoaded) {
      createJS();
      formScriptLoaded = true;
    }
  }
}

/**
 * la función createJS() se encarga de crear y cargar un archivo JavaScript en el documento HTML
 */
function createJS() {
  let cuerpoJS = "/static/js/info_profile.js";
  let scriptCuerpo = document.createElement("script");
  scriptCuerpo.src = cuerpoJS;
  scriptCuerpo.type = "module";
  document.body.appendChild(scriptCuerpo);

  let elementoJS = "/static/js/process_chat.js";
  let scriptElement = document.createElement("script");
  scriptElement.src = elementoJS;
  scriptElement.type = "module";
  document.body.appendChild(scriptElement);

  let elementoProcessAudio = "/static/js/process_audio.js";
  let scriptProcessAudio = document.createElement("script");
  scriptProcessAudio.src = elementoProcessAudio;
  scriptProcessAudio.type = "module";

  document.body.appendChild(scriptProcessAudio);
}
