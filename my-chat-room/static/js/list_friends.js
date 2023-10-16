// Definiendo un estado para controlar cuando el archivo existe o no existe
let formScriptLoaded = false;
let ultimoIdAmigo = null;
let li_amigos = document.querySelectorAll(".messaging-member");
if (li_amigos) {
  li_amigos.forEach((item) => {
    item.addEventListener("click", () => {
      li_amigos.forEach((item) => {
        item.classList.remove("messaging_member_active");
      });
      item.classList.add("messaging_member_active");

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

      guardar_amigo_seleccionado(id_amigo);
      actualizar_status_msj_no_leidos();
    });
  });
}

/**
 * Funcion para guardar el el localStorage el id del amigo seleccionado
 */
function guardar_amigo_seleccionado(id_amigo) {
  // Consultar si la variable existe en el localStorage
  if (localStorage.getItem("amigoId")) {
    localStorage.setItem("amigoId", parseInt(id_amigo));
  } else {
    // La variable no existe en el localStorage, créala
    localStorage.setItem("amigoId", parseInt(id_amigo));
  }
}

/**
 * Funcion para actualizar la cantidad de mensajes sin leer en el amigo selecionado
 */
function actualizar_status_msj_no_leidos() {
  // Selecciona el elemento con la clase messaging_member_active
  const elementoActivo = document.querySelector(".messaging_member_active");

  if (elementoActivo) {
    // Busca el span dentro del elemento activo
    const spanMensajesSinLeer = elementoActivo.querySelector(
      ".mensajes_sin_leer span"
    );
    if (spanMensajesSinLeer) {
      setTimeout(() => {
        spanMensajesSinLeer.textContent = "0";
      }, 400);
    }
  }
}

/**
 * Solicitud que recibe el id del amigo seleccionado
 * retorna toda la información del amigo selecionado como (mensajes, audios, imagenes, perfil)
 */
async function mostrar_amigo_y_chat_seleccionado(id_amigo) {
  loader(true);
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

    /**
     * Mostar todo el Chat del amigo seleccionado
     */
    const responseChat = await axios.post("/mostrar-chat-amigo-seleccionado", {
      id_amigo,
    });
    if (!responseChat.status) {
      console.log(`HTTP error! status: ${responseChat.status} 😭`);
    }

    const chat__container = document.querySelector(".chat__container");
    chat__container.innerHTML = "";
    chat__container.innerHTML = responseChat.data;

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
 * Funcion para hacer el efecto Loading
 */
let cargando = false;
function loader(cargando) {
  let body = document.body;
  if (cargando) {
    body.style.opacity = "0.3";
    body.style.bottom = "0";
    body.style.left = "0";
    body.style.right = "0";
    body.style.top = "0";
    body.style.zIndex = "99999999999999999999";
    setTimeout(() => {
      body.style.opacity = "10";
    }, 500);
  } else {
    body.style.opacity = "10";
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
