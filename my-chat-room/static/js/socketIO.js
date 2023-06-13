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
