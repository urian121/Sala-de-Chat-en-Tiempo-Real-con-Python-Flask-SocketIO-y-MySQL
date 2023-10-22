//Iniciando SocketIO y Configurando el socket con opciones
const socket = io({
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

const uploadInput = document.getElementById("upload-input");
const avatarImg = document.getElementById("avatar-img");
const cameraImg = document.getElementById("camera-img");

uploadInput.addEventListener("change", function (e) {
  const file = e.target.files[0];
  const reader = new FileReader();

  reader.onload = function (e) {
    avatarImg.src = e.target.result;
  };

  reader.readAsDataURL(file);
});

/**
 * Crear cuenta de Usuario
 */
const formulario = document.querySelector("#form_crear_cuenta");
// Agrega un evento de escucha al evento de envío del formulario
formulario.addEventListener("submit", async (e) => {
  e.preventDefault(); // Evita que se envíe el formulario de forma predeterminada

  // Realiza cualquier validación adicional del formulario aquí
  try {
    const formData = new FormData(formulario);
    const response = await axios.post("/procesar-cuenta-user", formData, {
      headers: {
        "Content-Type": "multipart/form-data",
      },
    });

    if (response.status !== 200) {
      console.log(`Error al procesar el Login: ${response.status} 😭`);
      return false;
    }

    const data = response.data;
    console.log(response);

    if (data.status === "OK") {
      const data_user_nuevo = {
        user: data.user,
        email_user: data.email_user,
        process_foto_name: data.process_foto_name,
      };
      console.log("Usuario creado:", data_user_nuevo);

      socket.emit("nueva_cuenta_creada", data_user_nuevo);
      window.location.href = data.redirect;
    } else {
      console.log("Error en el inicio de sesión");
    }
  } catch (error) {
    // Maneja los errores aquí
    console.error(error);
  }
});
