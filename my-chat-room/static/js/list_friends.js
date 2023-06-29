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
      let id_amigo = item.getAttribute("id");
      amigo_seleccionado(id_amigo);
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
  }
}
