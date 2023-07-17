
from application import app
from flask import render_template
from confiBD.conexionBD import *


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


def buscar_chat_amigoBDX(id_user_session, id_amigo_seleccionado):
    try:
        with connectionBD() as conexion_MySQLdb:
            with conexion_MySQLdb.cursor(dictionary=True) as mycursor:
                querySQL = """
                    SELECT
                        c.desde_id_user,
                        c.para_id_user,
                        DATE_FORMAT(c.fecha_mensaje, '%d de %b %Y %I:%i %p') AS fecha_dia_mes_year,
                        c.mensaje,
                        c.archivo_img,
                        c.file_audio
                    FROM tbl_users AS u
                    INNER JOIN tbl_chat AS c
                    ON u.id_user = c.para_id_user
                    WHERE (c.desde_id_user = %s AND c.para_id_user = %s)
                    OR (c.desde_id_user = %s AND c.para_id_user = %s)
                    ORDER BY c.id_chat
                """
                params = (id_user_session, id_amigo_seleccionado,
                          id_amigo_seleccionado, id_user_session)
                # print("Consulta SQL:", querySQL)
                # print("Parámetros:", params)
                mycursor.execute(querySQL, params)
                lista_chat = mycursor.fetchall()
                return lista_chat or []
    except Exception as e:
        print(
            f"Error al buscar el amigo seleccionado: {e}")
        return []
