addEventListener("DOMContentLoaded", (event) => {
  console.log("Documento cargado OK");
});

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
        return; // Termina la ejecución de la función sin realizar ninguna acción adicional
      } else {
        amigo_seleccionado(id_amigo); // Llama a la función amigo_seleccionado con el id_amigo como argumento
      }
      ultimoIdAmigo = id_amigo;
    });
  });
}

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
  } catch (error) {
    console.error(error);
  } finally {
    console.log("carga completada");

    // Llamando a la función
    createJS();
  }
}

/**
 * la función createJS() se encarga de crear y cargar un archivo JavaScript en el documento HTML
 */
function createJS() {
  console.log("Llegué a la función createJS");
  let elementoJS = "/static/js/form.js";
  // Verifica si ya existe un elemento <script> con el mismo src
  const existingScript = document.querySelector(`script[src="${elementoJS}"]`);

  if (existingScript) {
    eliminarScript(existingScript);
    // Espera un poco antes de crear el nuevo script
    setTimeout(() => {
      createScript();
    }, 1000); // Ajusta el tiempo de espera según sea necesario
  } else {
    createScript();
  }
}

function eliminarScript(existingScript) {
  console.log("El archivo JS ya estaba cargado en el HTML, ", existingScript);
  // Elimina el script existente
  existingScript.parentNode.removeChild(existingScript);
}

function createScript() {
  console.log("Creando nuevo archivo JS");
  let elementoJS = "/static/js/form.js";
  let scriptElement = document.createElement("script");
  scriptElement.src = elementoJS;
  scriptElement.type = "module";

  // Agrega el elemento <script> al <body>
  document.body.appendChild(scriptElement);
}
