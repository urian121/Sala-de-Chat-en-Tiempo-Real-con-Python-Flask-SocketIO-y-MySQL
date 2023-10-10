// Inicializando SocketIO y exportando el objeto socket
// export const socket = io();
export const socket = io({
  reconnection: true, // Habilitar reconexión automática
  reconnectionAttempts: 3, // Número máximo de intentos de reconexión
  reconnectionDelay: 1000, // Tiempo de espera (en milisegundos) entre intentos de reconexión
});

// Escuchando connect
socket.on("connect", function () {
  console.log("Socket Activo y escuchando.!");
});

// Escuchando disconnect
socket.on("disconnect", function () {
  console.log("Socket Desconectado.!");
});

/**
 * Escuchando cuando se crea una nueva cuenta nueva
 */
// Escucha el evento "nueva_cuenta_creada"
socket.on("nueva_cuenta_creada", (data_user_nuevo) => {
  // Maneja la data recibida desde el cliente
  console.log(data_user_nuevo);
  // Realiza las operaciones necesarias con la data recibida
});

/**
 * Manejar el evento de clic en el enlace 'link-cerrar-sesion'
 */
let link_cerrar_sesion = document.getElementById("link-cerrar-sesion");
if (link_cerrar_sesion) {
  link_cerrar_sesion.addEventListener("click", async function (event) {
    event.preventDefault();

    // Capturar los datos del usuario que esta cerrando la sesión
    const data_sesion_off = {
      id_sesion: parseInt(link_cerrar_sesion.dataset.session),
      user: link_cerrar_sesion.dataset.user,
      foto_user: link_cerrar_sesion.dataset.foto_user,
    };

    try {
      const resp = await axios.post("/cerrar-session");

      if (resp.status !== 200) {
        console.log(`HTTP error! 😭`);
        return false;
      }

      // Emitir el evento "user_desconectado" en el servidor
      socket.emit("user_desconectado", data_sesion_off);

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
socket.on("user_desconectado", function (data_user_desconectado) {
  console.log(`Informacion usuario desconectado`, data_user_desconectado);

  let id_user_desconectado = parseInt(data_user_desconectado.id_sesion);
  quitar_status_activo_user(id_user_desconectado);

  let infom_msj = [
    data_user_desconectado.user,
    data_user_desconectado.foto_user,
  ];
  my_custom_alert(infom_msj, "error");
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
socket.on("new_user_online", function (data_new_user_online) {
  //console.log(data_new_user_online);

  let id_user_conectado = data_new_user_online.id_sesion;
  agregar_status_activo_user(parseInt(id_user_conectado));

  let infom_msj = [data_new_user_online.user, data_new_user_online.foto_user];
  my_custom_alert(infom_msj, "success");
});

/**
 * Escuchar evento "new_user_online" cuando el usuario se Conecta
 */
function agregar_status_activo_user(id_user_conectado) {
  let li_online_friend = document.querySelectorAll(".messaging-member");
  if (li_online_friend) {
    li_online_friend.forEach((item) => {
      // Verificar si el ID del elemento coincide
      if (parseInt(item.getAttribute("id")) === id_user_conectado) {
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

/**
 * Escuhando cuando hay un nuevo mensaje sin leer de cualquier usuario
 */
socket.on("total_mensaje_sin_leer", function (data_total_mensaje_sin_leer) {
  console.log(
    "Total mensajes sin leer: ",
    data_total_mensaje_sin_leer.total_mensajes
  );
  console.log("para_id_user: ", data_total_mensaje_sin_leer.para_id_user);
  console.log("desde_id_user: ", data_total_mensaje_sin_leer.desde_id_user);
  // Recorrer cada li del ul
  const ulElement = document.querySelector(".messages-page__list");
  ulElement.querySelectorAll("li").forEach((liElement) => {
    // Obtener el ID del usuario del li actual
    const memberId = parseInt(liElement.getAttribute("id"));

    // Verificar si el ID del usuario del li coincide con el ID recibido del servidor
    if (memberId === parseInt(data_total_mensaje_sin_leer.desde_id_user)) {
      // Actualizar el valor de mensajes sin leer en el div y el span correspondiente al usuario
      const mensajesSinLeerDiv = liElement.querySelector(".mensajes_sin_leer");
      const mensajesSinLeerSpan = mensajesSinLeerDiv.querySelector("span");
      mensajesSinLeerSpan.textContent =
        data_total_mensaje_sin_leer.total_mensajes;
    }
  });
});

/**
 * Funcion para lenvantar alerta desde el JavaScript
 */
function my_custom_alert(infom_msj, tipo_msj) {
  // console.log(infom_msj);

  // Verificar si ya existe el div con id='myNotification'
  const divExistente = document.querySelector("#myNotification");
  if (divExistente) {
    divExistente.remove();
  }

  // Crear un div
  const mensajeDiv = document.createElement("div");
  mensajeDiv.id = "myNotification";

  // Agregar el div después del body
  const body = document.querySelector("body");
  body.insertAdjacentElement("afterend", mensajeDiv);

  // Establecer el contenido del div
  mensajeDiv.innerHTML = `
   <div class="toast_custom active" style="position: fixed; min-width: 50%;">
      <div class="toast-content">
      ${
        tipo_msj == "success"
          ? `<img src="/static/fotos_users/${infom_msj[1]}" alt="${infom_msj[0]}" loading="lazy" style="max-width: 50px;border-radius: 50%;">`
          : `<img src="/static/fotos_users/${infom_msj[1]}" alt="${infom_msj[0]}" loading="lazy" style="max-width: 50px;border-radius: 50%;">`
      }
        <div class="message">
          <span class="text text-1">
          ${tipo_msj == "success" ? `${infom_msj[0]}` : `${infom_msj[0]}`}
          </span>
         
          <span class="text text-2">
            ${
              tipo_msj == "success"
                ? 'Acaba de iniciar sesión <i class="bi bi-check-circle-fill" style="font-size: 30px; color: #1a7ee6;"></i>'
                : "Acaba de cerrar sesión <i class='bi bi-exclamation-triangle icon_error' style='color: #fb6e7b;'></i>"
            }
          </span>
        </div>
      </div>
        <i class="close bi bi-x"></i>
      <div class="progress active"></div>
    </div>
  `;

  const alert_custom = document.querySelector(".toast_custom");
  const closeIcon = document.querySelector(".close");
  const progress = document.querySelector(".progress");

  closeIcon.addEventListener("click", () => {
    alert_custom.classList.remove("active");
    setTimeout(() => {
      progress.classList.remove("active");
    }, 300);
  });

  setTimeout(() => {
    alert_custom.classList.remove("active");
  }, 8000);
}
