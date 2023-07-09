// Inicializando SocketIO y exportando el objeto socket
export const socket = io();

// Escuchando connect
socket.on("connect", function () {
  console.log("Socket Activo y escuchando.!");
});

// Escuchando disconnect
socket.on("disconnect", function () {
  console.log("Socket Desconectado.!");
});

/**
 * Manejar el evento de clic en el enlace 'link-cerrar-sesion'
 */
let link_cerrar_sesion = document.getElementById("link-cerrar-sesion");
if (link_cerrar_sesion) {
  link_cerrar_sesion.addEventListener("click", async function (event) {
    event.preventDefault();

    // Capturar el valor del atributo 'data-session'
    let sessionValue = parseInt(link_cerrar_sesion.dataset.session);
    try {
      const resp = await axios.post("/cerrar-session");

      if (resp.status !== 200) {
        console.log(`HTTP error! 😭`);
        return false;
      }

      // Emitir el evento "user_desconectado" en el servidor
      socket.emit("user_desconectado", sessionValue);

      // Recargar la página
      location.reload();
    } catch (error) {
      console.error(error);
    }
  });
}

/**
 *  Escuchar evento "user_desconectado" cuando el usuario se desconecta
 */
socket.on("user_desconectado", function (id_user_session_desconectado) {
  console.log(`Usuario Desconectado ${id_user_session_desconectado}`);
  quitar_status_activo_user(id_user_session_desconectado);
});

function quitar_status_activo_user(id_amigo) {
  let li_offline_friend = document.querySelectorAll(".messaging-member");
  if (li_offline_friend) {
    li_offline_friend.forEach((item) => {
      // Verificar si el ID del elemento coincide
      if (item.getAttribute("id") === id_amigo.toString()) {
        let amigo_activo = item.querySelector(".amigo_activo");

        // Verificar si existe el elemento con la clase "amigo_activo"
        if (amigo_activo) {
          // Quitar la clase "amigo_activo"
          amigo_activo.classList.remove("amigo_activo");
        }
      }
    });
  }
}

/**
 * Escuchando cuando un usuario que ya estaba registrado se vuelve a conectar
 */
socket.on("new_user_online", function (user) {
  console.log(`*** Usuario conectado ${user}`);
  agregar_status_activo_user();
});

/**
 * Escuchar evento "new_user_online" cuando el usuario se Conecta
 */
function agregar_status_activo_user(id_amigo) {
  let li_online_friend = document.querySelectorAll(".messaging-member");
  if (li_online_friend) {
    li_online_friend.forEach((item) => {
      // Verificar si el ID del elemento coincide
      if (item.getAttribute("id") === id_amigo.toString()) {
        let amigo_activo = item.querySelector(".user-status");

        // Verificar si existe el elemento con la clase "user-status"
        if (amigo_activo) {
          // Quitar la clase "amigo_activo"
          amigo_activo.classList.add("amigo_activo");
        }
      }
    });
  }
}
