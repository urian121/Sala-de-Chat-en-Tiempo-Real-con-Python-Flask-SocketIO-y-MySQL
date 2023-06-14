
# Importando el objeto app de mi
from application import *


# Importando cenexión a BD
from functions.function_chat import *


# Esta función 'recibir_mensaje' se encarga de escuchar el evento "mensaje_chat"
# del lado del servidor y mostrar el mensaje recibido en la consola del servidor
@socketio.on('mensaje_chat')
def recibir_mensaje(mensaje_chat):
    # print(f"Respuesta {mensaje_chat}")
    emit('mensaje_chat', render_template('public/mensajes_chat.html',
         lista_mensajes=lista_mensajes_chat()), broadcast=True)


@app.route('/home', methods=['GET'])
def chat():
    if 'conectado' in session and request.method == 'GET':
        lista_mensajes = lista_mensajes_chat() or []
        return render_template('public/inicio.html', lista_mensajes=lista_mensajes)
    else:
        flash('primero debes iniciar sesión.', 'error')
        return render_template('public/login/base_login.html')


# Procesando el audio que llega desde el formulario del chat
@app.route('/procesar-audio-chat', methods=['POST'])
def process_audio():
    audio_file = request.files['audio']
    resp_process_audio_chat = process_audio_chat(audio_file)
    if (resp_process_audio_chat):
        return jsonify({'status': 1, 'file': 'audio'})
    else:
        return jsonify({'status': 1, 'file': 'audio'})


@app.route('/procesar-form-chat', methods=['POST'])
def process_form_chat():
    if 'archivo' in request.files and 'mensaje' in request.form:
        # Ambos el archivo y el mensaje están presentes en la solicitud
        mensaje = request.form.get('mensaje', '')
        archivo = request.files['archivo']
        resp_process_archivo = procesar_archivo(archivo)
        if resp_process_archivo:
            process_form_chat = process_form(resp_process_archivo, mensaje)
            if (process_form_chat):
                return jsonify({'status': 1})
            else:
                return jsonify({'status': 0})
    else:
        # Solo el mensaje está presente en la solicitud
        mensaje = request.form.get('mensaje')
        procesar_msj = procesar_form_msj(mensaje)
        if procesar_msj:
            return jsonify({'status': 1})
        else:
            return jsonify({'status': 0})
