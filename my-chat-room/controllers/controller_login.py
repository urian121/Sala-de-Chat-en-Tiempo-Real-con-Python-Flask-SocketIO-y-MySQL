from flask import render_template, request, flash, session, redirect, url_for, jsonify
# Importando el objeto app de mi
from application import app

from werkzeug.utils import escape

# Importando cenexión a BD
from functions.function_login import *

# Importando SocketIO del lado del Servidor
from flask_socketio import SocketIO, emit

# para crear una instancia de Socket.IO en una aplicación Flask
socketio = SocketIO(app)


@app.route('/',  methods=['GET'])
def index():
    if 'conectado' in session and request.method == 'GET':
        return redirect(url_for('chat'))
    else:
        flash('primero debes iniciar sesión.', 'error')
        return render_template('public/login/base_login.html')


@app.route('/login')
def login():
    return render_template('public/login/base_login.html')


@app.route('/crear-cuenta')
def crear_cuenta():
    return render_template('public/login/register.html')


@app.route('/recuperar-cuenta')
def recuperar_cuenta():
    return render_template('public/login/recovery.html')


@app.route('/procesar-cuenta-user',  methods=['POST'])
def process_register_user():
    user = request.form.get('user', '').strip()
    email_user = request.form.get('email_user', '').strip()
    tlf_user = request.form.get('tlf_user', '').strip()
    pass_user = request.form.get('pass_user', '').strip()
    foto_user = request.files['foto_user']

    if not all([user, email_user, tlf_user, pass_user]):
        flash('Por favor, complete todos los campos del formulario.', 'error')
        return redirect(url_for('index'))

    if not re.match(r'[^@]+@[^@]+\.[^@]+', email_user):
        flash('Correo electrónico inválido.', 'error')
        return redirect(url_for('index'))

    if len(pass_user) <= 3:
        flash('La contraseña debe tener al menos 4 caracteres.', 'error')
        return redirect(url_for('index'))

    if not tlf_user.isdigit() or len(tlf_user) != 10:
        flash('El número de teléfono debe tener 10 dígitos.', 'error')
        return redirect(url_for('index'))

    if not foto_user.filename:
        flash('Por favor, debe seleccionar una foto.', 'error')
        return redirect(url_for('index'))

    if (foto_user):
        # validar tipo y tamaño de la imagen
        pesoArchivo = procesarFoto_user(foto_user)

        if pesoArchivo:
            process_foto_name = procesar_foto_perfil(foto_user)
            if process_foto_name:
                # Se han validado todos los datos, se puede continuar con el procesamiento en la base de datos
                resultado_insert = procesar_insert_userBD(
                    user, email_user, tlf_user, pass_user, process_foto_name)

                if resultado_insert == 1:
                    flash('Registro exitoso.', 'success')
                    return jsonify(
                        {
                            'status': 'OK',
                            'redirect': url_for('index'),
                            'user': user,
                            'email_user': email_user,
                            'process_foto_name': process_foto_name
                        })
                else:
                    flash('Error, la cuenta no fue creada.', 'error')
                    return redirect(url_for('index'))
            flash('Error, recuerde debe ser una imagen', 'error')
            return redirect(url_for('index'))
        else:
            flash('Error, la foto debe pesar menos de 1MB', 'error')
            return redirect(url_for('index'))


# Procesar el inicio de sesión
@app.route('/iniciar-sesion', methods=['POST'])
def login_user():
    conectado = session.get('conectado')
    if conectado:
        flash('Ya has iniciado sesión', 'success')
        return redirect(url_for('chat'))
    else:
        if request.method == 'POST':
            email_user = escape(request.form.get('email_user'))
            pass_user = escape(request.form.get('pass_user'))

            if email_user and pass_user:
                if (validad_loginBD(email_user, pass_user)):
                    flash('¡Ha iniciado sesión correctamente!', 'success')
                    return jsonify({'status': 'OK', 'redirect': url_for('chat'), 'id_sesion': session['id_user']})
                else:
                    flash('Datos incorrectos, por favor revise', 'error')
                    return redirect(url_for('index'))
            else:
                flash(
                    'Por favor, proporcione un correo electrónico y una contraseña', 'error')
                return redirect(url_for('index'))


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
    print(f"Hola {nueva_cuenta_creada}")
    emit('nueva_cuenta_creada', nueva_cuenta_creada, broadcast=True)


# Cerrando sesión del user
@app.route('/cerrar-session', methods=['POST', 'GET'])
def cerraSesion():
    result = update_status_user(session['id_user'], 0)
    if result > 0:
        session.pop('conectado', None)
        session.pop('id_user', None)
        session.pop('user', None)
        session.pop('email_user', None)
        session.pop('foto_user', None)
        flash('Tu sesión fue cerrada correctamente.', 'success')
    return redirect(url_for('index'))
