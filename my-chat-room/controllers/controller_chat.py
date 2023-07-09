# Importando el objeto app de mi
from application import app
from flask import render_template, request, flash, session, jsonify
# biblioteca  send_file para forzar la descarga
from flask import send_from_directory, send_file
from functions.function_chat import *

# Importando SocketIO del lado del Servidor
from controllers.socketIO import *


# Esta función 'recibir_mensaje' se encarga de escuchar el evento "mensaje_chat"
# del lado del servidor y mostrar el mensaje recibido en la consola del servidor
@socketio.on('mensaje_chat')
def recibir_mensaje(mensaje_chat):
   # print(f"Respuesta mensaje: {mensaje_chat}")
    id_user_session = mensaje_chat['desde_id_user']
    id_amigo_seleccionado = mensaje_chat['para_id_user']

    emit('mensaje_chat', render_template('public/mensajes_chat.html',
         lista_mensajes=buscar_chat_amigoBD(id_user_session, id_amigo_seleccionado)), broadcast=True)


@app.route('/sala-de-chat', methods=['GET'])
def chat():
    if 'conectado' in session and request.method == 'GET':
        parametros_chat = {
            'lista_amigos': lista_amigos_chat(session["id_user"]) or []
        }
        return render_template('public/inicio.html', **parametros_chat)
    else:
        flash('primero debes iniciar sesión.', 'error')
        return render_template('public/login/base_login.html')


# Buscar chat del amigo que fue seleccionado
@app.route('/mostrar-chat-amigo-seleccionado', methods=['POST'])
def mostrar_chat_amigo():
    id_amigo_seleccionado = int(request.json.get('id_amigo'))
    resp_status_amigo = status_amigo(id_amigo_seleccionado)
    data_chat_amigo = buscar_chat_amigoBD(
        session["id_user"], id_amigo_seleccionado)
# lista_mensajes=data_chat_amigo or []
    data_amigo = {
        "resp_status_amigo": resp_status_amigo,
        "lista_mensajes": data_chat_amigo
    }
    return render_template('public/home/base_chat_perfil.html', **data_amigo)


# Funcion para filtrar y mostrar el amigo seleccionado desde el chat
@app.route('/mostrar-amigo-seleccionado', methods=['POST'])
def mostrar_amigo():
    id_amigo = int(request.json.get('id_amigo'))
    infor_amigo = buscar_informacion_amigoBD(id_amigo)
    return render_template('public/home/friend_profile.html', data_amigo_seleccionado=infor_amigo)


# Procesando el audio que llega desde el formulario del chat
@app.route('/procesar-audio-chat', methods=['POST'])
def process_audio():
    desde_id_user = request.form.get('desde_id_user')
    para_id_user = request.form.get('para_id_user')
    audio_file = request.files['audio']

    if (process_audio_chat(
            desde_id_user, para_id_user, audio_file)):
        return jsonify({'status': 1, 'file': 'audio'})
    else:
        return jsonify({'status': 1, 'file': 'audio'})


# Procesar todo mi formulario desde el chat
@app.route('/procesar-form-chat', methods=['POST'])
def process_form_chat():
    desde_id_user = int(request.form.get('desde_id_user'))
    para_id_user = int(request.form.get('para_id_user'))
    mensaje = request.form.get('mensaje', '')

    if 'archivo_img' in request.files and request.files['archivo_img'] and 'mensaje' in request.form:
        # Ambos el archivo y el mensaje están presentes en la solicitud
        archivo = request.files['archivo_img']
        resp_process_archivo = procesar_archivo(archivo)
        if resp_process_archivo:
            process_form_chat = process_form(
                desde_id_user, para_id_user, mensaje, resp_process_archivo)

            return jsonify({'status': 1}) if process_form_chat else jsonify({'status': 0})
    else:
        # Solo el mensaje está presente en la solicitud
        procesar_msj = procesar_form_msj(desde_id_user, para_id_user, mensaje)
        return jsonify({'status': 1}) if procesar_msj else jsonify({'status': 0})


@app.route('/descargar_foto_chat', methods=['POST'])
def descargar_foto_chat():
    foto_chat = request.json.get('foto_chat')
    basepath = os.path.abspath(os.path.dirname(__file__))
    directorio_archivos = 'static/archivos_chat'
    ruta_archivo = os.path.join(basepath, directorio_archivos, foto_chat)

    """ 
    foto_chat = request.json.get('foto_chat')
    basepath = path.dirname(__file__)
    url_File = path.join(basepath, 'static/archivos_chat', foto_chat)
    resp = send_file(url_File, as_attachment=True)
    return resp
    """
    try:
        return send_from_directory(basepath, ruta_archivo, as_attachment=True, attachment_filename=foto_chat)
    except FileNotFoundError:
        return 'Archivo no encontrado', 404
