let li_amigos = document.querySelectorAll(".messaging-member");
if (li_amigos) {
  li_amigos.forEach((item) => {
    item.addEventListener("click", () => {
      li_amigos.forEach((item) => {
        item.classList.remove("messaging-member--active");
      });

      item.classList.add("messaging-member--active");
      let idAmigoActivo = parseInt(item.id);
      //let id_amigo = item.getAttribute("id");
      document.querySelector("#para_id_user").value = idAmigoActivo;
      console.log("ID del amigo activo:", idAmigoActivo);

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

    const data_amigo = response.data;
    const sectionRecientes = document.querySelector(".user-profile");
    sectionRecientes.innerHTML = "";
    sectionRecientes.innerHTML = data_amigo;

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

    const data_chat_amigo = response.data;
    const chat__container = document.querySelector(".chat__container");
    chat__container.innerHTML = "";
    chat__container.innerHTML = data_chat_amigo;
  } catch (error) {
    console.error(error);
  }
}
