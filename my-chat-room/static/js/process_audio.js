// Importando el objeto socket
import { socket } from "./socketIO.js";

/**
 * En lugar de asignar directamente el evento click al botón, ahora asignamos el evento
 * click al contenedor (en este caso, el body).
 * Luego, verificamos si el evento click ocurrió en el botón con la clase "bi-mic-fill" dentro del evento delegado.
 */

const bodyHTML = document.body;
bodyHTML.addEventListener("click", (event) => {
  event.preventDefault();

  if (event.target.classList.contains("bi-mic-fill")) {
    console.log("Llegue: ", event.target);
    const btnAudio = event.target;
    activar_grabador_audio(btnAudio);
  }
});

async function activar_grabador_audio(btnAudio) {
  console.log("llegue a la funcion activar_grabador_audio");
  let mediaRecorder;
  let contadorValor = 0;
  let intervalId;
  const MAX_DURATION = 120; // Duración máxima de la grabación en segundos

  let handleBtnAudioClick; // Definir handleBtnAudioClick

  // Eliminar el manejador de eventos anterior
  btnAudio.removeEventListener("click", handleBtnAudioClick);

  if (mediaRecorder && mediaRecorder.state === "recording") {
    mediaRecorder.stop();
    return;
  }

  btnAudio.style.color = "#222";
  btnAudio.style.top = "9%";
  btnAudio.style.animation = "heartbeat 1s infinite";

  contadorValor = 0;

  try {
    const stream = await navigator.mediaDevices.getUserMedia({
      audio: true,
    });

    mediaRecorder = new MediaRecorder(stream);
    const audioChunks = [];

    mediaRecorder.addEventListener("dataavailable", (event) => {
      audioChunks.push(event.data);
    });

    handleBtnAudioClick = async () => {
      if (mediaRecorder.state === "recording") {
        mediaRecorder.stop();
      }
    };

    mediaRecorder.addEventListener("start", () => {
      btnAudio.addEventListener("click", handleBtnAudioClick);
    });

    mediaRecorder.addEventListener("stop", () => {
      const audioBlob = new Blob(audioChunks, { type: "audio/webm" });
      enviarAudio(audioBlob);

      reiniciarIcon(btnAudio);

      clearInterval(intervalId);
      console.log(
        "Grabación finalizada. Tiempo total: " + contadorValor + " segundos"
      );
    });

    mediaRecorder.start();

    document.querySelector(".custom-form__send-audio").style.backgroundColor =
      "#FF6347";
    btnAudio.classList.remove("bi-mic-fill");
    btnAudio.classList.add("bi-mic-mute-fill");
    btnAudio.style.fontSize = "24px";

    intervalId = setInterval(() => {
      contadorValor++;
      console.log("Tiempo de grabación: " + contadorValor + " segundos");

      //Limitando el tiepo de grabación por audio
      if (contadorValor >= MAX_DURATION) {
        mediaRecorder.stop();
      }
    }, 1000);
  } catch (error) {
    console.log("Error al acceder al micrófono:", error);
  }
}

/**
 * Funcion que recibe el icono de entrada para el audio, y retorna el icono original.
 */
function reiniciarIcon(btnAudio) {
  document.querySelector(".custom-form__send-audio").style.backgroundColor = "";
  btnAudio.classList.remove("bi-mic-mute-fill");
  btnAudio.classList.add("bi-mic-fill");
  btnAudio.style.fontSize = "";
  btnAudio.style.color = "";
  btnAudio.style.top = "50%";
  btnAudio.style.animation = "";
}

// Función para enviar el archivo de audio al servidor
async function enviarAudio(audioBlob) {
  const formData = new FormData();
  formData.append("audio", audioBlob, "audio.webm");

  const url_form = "/procesar-audio-chat";
  try {
    const response = await axios.post(url_form, formData, {
      headers: {
        "Content-Type": "multipart/form-data",
      },
    });

    if (response.status === 200) {
      // Reproducir el archivo de audio después de recibir una respuesta exitosa
      const audio = new Audio("static/audio/audio_chat.mp3");
      audio.play();

      socket.emit("mensaje_chat", "OK");
      console.log("Audio enviado.");
    } else {
      console.log("El audio no fue enviado.");
    }
  } catch (error) {
    console.log("Error al enviar el audio.");
  } finally {
    console.log("Petición finalizada");
  }
}
