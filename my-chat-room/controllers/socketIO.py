# Importando el objeto app de mi
from application import app

from flask_socketio import SocketIO, emit

# para crear una instancia de Socket.IO en una aplicación Flask
socketio = SocketIO(app)

# Escuchando si el servidor esta conectado del lado del servidor
@socketio.on('connect')
def handle_connect():
    print('Cliente conectado')


# Escuchando si el cliente se desconecta del lado del servidor
@socketio.on('disconnect')
def handle_disconnect():
    print('Cliente desconectado')
