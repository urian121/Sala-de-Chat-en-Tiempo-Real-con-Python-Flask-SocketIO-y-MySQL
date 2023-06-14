
# Importando el objeto app de mi
from application import *


from werkzeug.utils import escape


# Importando cenexión a BD
from functions.function_login import *


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
        print("c1")
        return redirect(url_for('index'))

    if not re.match(r'[^@]+@[^@]+\.[^@]+', email_user):
        flash('Correo electrónico inválido.', 'error')
        print("c2")
        return redirect(url_for('index'))

    if len(pass_user) <= 3:
        flash('La contraseña debe tener al menos 4 caracteres.', 'error')
        print("c3")
        return redirect(url_for('index'))

    if not tlf_user.isdigit() or len(tlf_user) != 10:
        flash('El número de teléfono debe tener 10 dígitos.', 'error')
        print("c4")
        return redirect(url_for('index'))

    if not foto_user.filename:
        flash('Por favor, debe seleccionar una foto.', 'error')
        print("c5")
        return redirect(url_for('index'))

    process_foto_name = procesar_foto_perfil(foto_user)

    # Se han validado todos los datos, se puede continuar con el procesamiento en la base de datos
    resultado_insert = procesar_insert_userBD(
        user, email_user, tlf_user, pass_user, process_foto_name)

    if resultado_insert == 1:
        flash('Registro exitoso.', 'success')
        return redirect(url_for('index'))
    else:
        flash('Error, la cuenta no fue creada.', 'error')
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
                resp_process_login = validad_loginBD(email_user, pass_user)
                if (resp_process_login):
                    flash('¡Ha iniciado sesión correctamente!', 'success')
                    return redirect(url_for('chat'))
                else:
                    flash('Datos incorrectos, por favor revise', 'error')
                    return redirect(url_for('index'))
            else:
                flash(
                    'Por favor, proporcione un correo electrónico y una contraseña', 'error')
                return redirect(url_for('index'))


@app.route('/cerrar-session', methods=['GET'])
def cerraSesion():
    session.pop('conectado', None)
    session.pop('id_user', None)
    session.pop('user', None)
    session.pop('email_user', None)
    flash('Tu sesión fue cerrada correctamente.', 'success')
    return redirect(url_for('index'))
