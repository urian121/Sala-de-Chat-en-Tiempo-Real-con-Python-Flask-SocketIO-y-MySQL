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

    const data = response.data;
    if (data.status === "OK") {
      // Redireccionar a la URL proporcionada
      socket.emit("new_user_online", parseInt(data.id_sesion));
      window.location.href = data.redirect;
    } else {
      console.log("Error en el inicio de sesión");
    }
  } catch (error) {
    console.error(error);
  }
});
