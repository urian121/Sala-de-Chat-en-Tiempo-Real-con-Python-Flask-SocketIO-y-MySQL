// Importando el objeto socket
import { socket } from "./socketIO.js";

const btnAudio = document.querySelector(".custom-form__send-audio");
if (btnAudio) {
  let mediaRecorder;
  let contadorValor = 0;
  let intervalId;

  btnAudio.addEventListener("click", async () => {
    if (mediaRecorder && mediaRecorder.state === "recording") {
      mediaRecorder.stop();
      return;
    }

    btnAudio.style.color = "#222";
    btnAudio.style.backgroundColor = "#D93025";
    btnAudio.style.top = "9%";
    btnAudio.style.animation = "heartbeat 1s infinite";

    contadorValor = 0;
    console.log("Tiempo de grabación: 0 segundos");

    try {
      const stream = await navigator.mediaDevices.getUserMedia({
        audio: true,
      });

      mediaRecorder = new MediaRecorder(stream);
      const audioChunks = [];

      mediaRecorder.addEventListener("dataavailable", (event) => {
        audioChunks.push(event.data);
      });

      mediaRecorder.addEventListener("stop", () => {
        const audioBlob = new Blob(audioChunks, { type: "audio/webm" });
        enviarAudio(audioBlob);

        btnAudio.innerHTML = '<i class="bi bi-mic-fill"></i>';
        btnAudio.style.color = "";
        btnAudio.style.backgroundColor = "";
        btnAudio.style.top = "50%";
        btnAudio.style.animation = "";

        clearInterval(intervalId);
        console.log(
          "Grabación finalizada. Tiempo total: " + contadorValor + " segundos"
        );
      });

      mediaRecorder.start();
      btnAudio.innerHTML =
        '<i class="bi bi-mic-mute-fill" style="font-size: 24px;"></i>';

      intervalId = setInterval(() => {
        contadorValor++;
        console.log("Tiempo de grabación: " + contadorValor + " segundos");
      }, 1000);
    } catch (error) {
      console.log("Error al acceder al micrófono:", error);
    }
  });
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
