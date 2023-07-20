
from application import app
from flask import render_template, jsonify


from funciones.funciones_sockeyIO import *


# Importando SocketIO del lado del Servidor
from flask_socketio import SocketIO, emit

# para crear una instancia de Socket.IO en una aplicación Flask
socketio = SocketIO(app)

# Escuchando si el servidor esta conectado del lado del servidor

"""
@socketio.on('connect')
def handle_connect():
    print('Cliente conectado')
# Escuchando si el cliente se desconecta del lado del servidor

@socketio.on('disconnect')
def handle_disconnect():
    print('Cliente desconectado')

"""


# Esta función 'recibir_mensaje' se encarga de escuchar el evento "mensaje_chat"
# del lado del servidor y mostrar el mensaje recibido en la consola del servidor
@socketio.on('mensaje_chat')
def recibir_mensaje(mensaje_chat):
    # print(f"Mensaje escuchado desde el Servidoe: {mensaje_chat}")
    id_user_session = mensaje_chat['desde_id_user']
    id_amigo_seleccionado = mensaje_chat['para_id_user']

    # Emitiendo el total de mensajes sin leer para el que usuario que acaba de recibir el mensaje
    total_mensajes_sin_leer = cantidad_mensajes_sin_leer(id_amigo_seleccionado)
    emit('total_mensaje_sin_leer', {
         'total_mensajes': total_mensajes_sin_leer, 'para_id_user': id_amigo_seleccionado}, broadcast=True)

    emit('mensaje_chat', render_template('public/mensajes_chat.html',
         lista_mensajes=buscar_chat_amigoBDX(id_user_session, id_amigo_seleccionado)), broadcast=True)


# Escuchando cuando un usuario se conecta
@socketio.on('new_user_online')
def handle_user_conectado(new_user_online):
    emit('new_user_online', new_user_online, broadcast=True)


# Escuchando 'user_desconectado' para emitir cuando un usuario se desconecta
@socketio.on('user_desconectado')
def handle_user_desconectado(user_desconectado):
    emit('user_desconectado', user_desconectado, broadcast=True)


# Nuevo usuario creado, escuchando por nueva_cuenta_creada
@socketio.on('nueva_cuenta_creada')
def handle_nuevo_user_creado(nueva_cuenta_creada):
    # print(f"Hola {nueva_cuenta_creada}")
    emit('nueva_cuenta_creada', nueva_cuenta_creada, broadcast=True)
