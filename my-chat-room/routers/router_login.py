from flask import render_template, request, flash, session, redirect, url_for, jsonify
from werkzeug.security import generate_password_hash
# Importando el objeto app de mi
from application import app

# Configuracion para el envio de eMAIL
import resend

import random

import re
from werkzeug.utils import escape

# Importando cenexión a BD
from controllers.controller_login import *


@app.route('/',  methods=['GET'])
def index():
    if 'conectado' in session and request.method == 'GET':
        return redirect(url_for('chat'))
    else:
        return render_template('public/login/base_login.html')


@app.route('/login')
def login():
    return render_template('public/login/base_login.html')


@app.route('/crear-cuenta')
def crear_cuenta():
    return render_template('public/login/register.html')


@app.route('/recuperando-de-cuenta-de-usuario', methods=['POST'])
def recuperar_cuenta_usuario():
    email_user = request.form.get('email_user').strip()

    # Verificar si el correo electrónico existe en la base de datos
    with connectionBD() as conexion_MySQLdb, conexion_MySQLdb.cursor(dictionary=True) as cursor:
        cursor.execute(
            "SELECT * FROM tbl_users WHERE email_user = %s", [email_user])
        usuario = cursor.fetchone()

        if usuario is None:
            flash(
                'Correo electrónico no encontrado. Verifica la dirección de correo.', 'error')
            return redirect(url_for('index'))

        resp = enviar_email_recuperacion(email_user)
        if resp:
            try:
                nueva_password = generate_password_hash(
                    resp, method='scrypt')
                with connectionBD() as conexion_MySQLdb:
                    with conexion_MySQLdb.cursor(dictionary=True) as cursor:
                        querySQL = """
                            UPDATE tbl_users
                            SET 
                                pass_user = %s
                            WHERE email_user = %s
                        """
                        params = (nueva_password, email_user)
                        cursor.execute(querySQL, params)
                        conexion_MySQLdb.commit()
            except Exception as e:
                print(
                    f"Ocurrió en enviar_email_recuperacion: {e}")

            flash('Se envio una clave temporal a tu correo.', 'success')
            return redirect(url_for('index'))
        else:
            flash('No se pudo enviar el mensaje para recuperar el email.', 'error')
            return redirect(url_for('index'))


def enviar_email_recuperacion(email_user):
    resend.api_key = "re_iFQLh5Gm_AiVx2SDXYxqemBXotWsLbn57"
    nueva_clave_tmp = generar_clave_aleatoria()
    r = resend.Emails.send({
        "from": "AmigosOnline@resend.dev",
        "to": email_user,
        "subject": "Recuperar clave AmigosOnline",
        "html": f"""<p>Hola, te hemos generado una contraseña temporal para que puedas iniciar sesion </p>
                        <p>Tu clave temporal:<strong>{nueva_clave_tmp}</p>"""
    })
    return nueva_clave_tmp


def generar_clave_aleatoria():
    clave = ''.join([str(random.randint(0, 9)) for _ in range(4)])
    return clave


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
        pesoArchivo = procesar_foto_user(foto_user)

        if pesoArchivo:
            process_foto_name = procesar_foto_perfil(foto_user)
            if process_foto_name:
                # Se han validado todos los datos, se puede continuar con el procesamiento en la base de datos
                resultado_insert = procesar_insert_userBD(
                    user, email_user, tlf_user, pass_user, process_foto_name)

                if resultado_insert == 1:
                    flash('Tu cuenta fue creada con exitos.', 'success')
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
@app.route('/iniciar-sesion', methods=['GET', 'POST'])
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
                    return jsonify({'status': 'OK', 'redirect': url_for('chat'), 'id_sesion': session['id_user'], 'foto_user': session['foto_user'], 'user': session['user']})
                else:
                    flash('Datos incorrectos, por favor revise', 'error')
                    return redirect(url_for('index'))
            else:
                flash(
                    'Por favor, proporcione un correo electrónico y una contraseña', 'error')
                return redirect(url_for('index'))


# Actualizar datos de mi perfil
@app.route("/actualizar-datos-perfil", methods=['POST'])
def actualizarPerfil():
    if request.method == 'POST' and 'conectado' in session:
        try:
            # Extraer datos del diccionario data_form
            id_user = session['id_user']
            user = request.form['user']
            email_user = request.form['email_user']
            tlf_user = request.form['tlf_user']
            description_user = request.form['description_user']

            # Verificar si el campo 'pass_user' existe y no está vacío en el formulario
            if 'pass_user' in request.form and request.form['pass_user']:
                pass_user = request.form['pass_user']
            else:
                pass_user = None

            # Verificar si el campo 'foto_user' existe en el formulario
            if 'foto_user' in request.files:
                foto_user = request.files['foto_user']
                # Llamar a la función para procesar la foto de perfil
                foto_perfil = procesar_foto_perfil(foto_user)
            else:
                foto_user = None
                foto_perfil = None

            with connectionBD() as conexion_MySQLdb:
                with conexion_MySQLdb.cursor(dictionary=True) as cursor:
                    # Construir la consulta SQL
                    querySQL = """
                        UPDATE tbl_users
                        SET 
                            user = %s,
                            email_user = %s,
                            tlf_user = %s,
                            description_user = %s
                            {}
                            {}
                        WHERE id_user = %s
                    """.format(", pass_user = %s" if pass_user else "", ", foto_user = %s" if foto_perfil else "")

                    # Construir la lista de parámetros
                    params = [user, email_user, tlf_user, description_user]

                    # Agregar el campo 'pass_user' a los parámetros si existe
                    if pass_user:
                        nueva_password = generate_password_hash(
                            pass_user, method='scrypt')
                        params.append(nueva_password)

                    # Agregar el campo 'foto_user' procesado a los parámetros si existe
                    if foto_perfil:
                        params.append(foto_perfil)

                    params.append(id_user)
                    cursor.execute(querySQL, params)
                    conexion_MySQLdb.commit()

            flash('Los datos fueron actualizados correctamente.', 'success')
            return redirect(url_for('chat'))
        except Exception as e:
            print(f"Ocurrió un error en la función actualizarPerfil: {e}")
            flash('Hubo un error al actualizar los datos.', 'error')
            # Redirige a una página de error o a donde corresponda
            return redirect(url_for('chat'))
    else:
        flash('Primero debes iniciar sesión.', 'error')
        return redirect(url_for('inicio'))


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
