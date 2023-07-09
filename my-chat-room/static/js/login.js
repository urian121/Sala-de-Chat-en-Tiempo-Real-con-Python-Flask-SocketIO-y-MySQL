/**
 * Enviando formulario Login
 */

const form_login = document.getElementById("form_login");

// Agregar el evento "submit" al formulario
form_login.addEventListener("submit", async function (event) {
  event.preventDefault();
  try {
    // Obtener los datos del formulario
    const formData = new FormData(form_login);
    const response = await axios.post("/iniciar-sesion", formData);
    if (response.status !== 200) {
      console.log(`Error al procesar el Login: ${response.status} 😭`);
      return false;
    }

    // Emitir el evento "new_user_online" en el servidor, usuario nuevo conectado
    socket.emit("new_user_online", "Nuevo Usuario Conectado!");

    // Recargar la página.
    location.reload();

    /*
    setTimeout(() => {
      // Recargar la página.
       location.reload();
    }, 2000);
    */
  } catch (error) {
    console.error(error);
  }
});
