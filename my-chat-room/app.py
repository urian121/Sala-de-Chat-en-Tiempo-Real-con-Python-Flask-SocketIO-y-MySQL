from flask import Flask, render_template, request, jsonify


# Importando las clases SocketIO y emit del módulo flask_socketio
from flask_socketio import SocketIO, emit
from funciones import *  # Importando mis Funciones

# Creando una instancia de la clase Flask y asigna esa instancia a la variable app
app = Flask(__name__)
# Cambia el valor según tus necesidades (en bytes)
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024


# Creando una instancia de Socket.IO en una aplicación Flask
socketio = SocketIO(app)


# Escuchando si el servidor esta conectado del lado del servidor
@socketio.on('connect')
def handle_connect():
    print('Cliente conectado')


# Escuchando si el cliente se desconecta del lado del servidor
@socketio.on('disconnect')
def handle_disconnect():
    print('Cliente desconectado')


# Definiendo mi ruta de Inicio
@app.route('/')
def index():
    lista_mensajes = lista_mensajes_chat() or []
    return render_template('public/inicio.html', lista_mensajes=lista_mensajes)


@app.route('/demo')
def demo():
    return render_template('public/demo.html')


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


# Esta función 'recibir_mensaje' se encarga de escuchar el evento "mensaje_chat"
# del lado del servidor y mostrar el mensaje recibido en la consola del servidor
@socketio.on('mensaje_chat')
def recibir_mensaje(mensaje_chat):
    # print(f"Respuesta {mensaje_chat}")
    emit('mensaje_chat', render_template('public/mensajes_chat.html',
         lista_mensajes=lista_mensajes_chat()), broadcast=True)


# Arrancando aplicacion Flask
if __name__ == '__main__':
    """ 
    Se llama a la función socketio.run() para iniciar el servidor de Flask-SocketIO.
    Esto significa que cuando ejecutes este archivo específico, el servidor Flask-SocketIO 
    se iniciará y estará listo para recibir conexiones y manejar eventos de socket.
    """
    socketio.run(app, debug=True, port=5100)
