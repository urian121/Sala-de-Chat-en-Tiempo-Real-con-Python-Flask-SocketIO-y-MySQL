
from flask import session

import os
from os import path  # Modulo para obtener la ruta o directorio
import uuid  # Modulo de python para crear un string


from confiBD.conexionBD import *


import re
from werkzeug.security import generate_password_hash, check_password_hash


def procesar_insert_userBD(user, email_user, tlf_user, pass_user, process_foto_name):
    try:
        # Generación de la contraseña cifrada
        nueva_password = generate_password_hash(pass_user, method='sha256')

        # Conexión a la base de datos
        with connectionBD() as conexion_MySQLdb, conexion_MySQLdb.cursor(dictionary=True) as cursor:
            # Comprobar si ya existe una cuenta con el mismo correo electrónico
            cursor.execute(
                "SELECT * FROM tbl_users WHERE email_user = %s", (email_user,))
            result = cursor.fetchone()

            if result is not None:
                return 'Ya existe una cuenta con este correo electrónico.'

            # Insertar una nueva cuenta en la tabla de cuentas
            sql = "INSERT INTO tbl_users (user, email_user, tlf_user, pass_user, foto_user) VALUES (%s, %s, %s, %s, %s)"
            valores = (user, email_user, tlf_user,
                       nueva_password, process_foto_name)
            cursor.execute(sql, valores)
            conexion_MySQLdb.commit()

            resultado_insert = cursor.rowcount

        # Retornar el resultado de la inserción
        return resultado_insert

    except Exception as e:
        return f'Se produjo un error al insertar la cuenta en la base de datos: {str(e)}'


def verificar_password(password_plano, password_hash):
    return check_password_hash(password_hash, password_plano)


def validad_loginBD(email_user, pass_user):
    # Usando 'BINARY' para hacer una comparación sensible entre mayúsculas y minúsculas en MySQL
    with connectionBD() as conexion_MySQLdb, conexion_MySQLdb.cursor(dictionary=True) as cursor:
        cursor.execute(
            "SELECT * FROM tbl_users WHERE BINARY email_user = %s", [email_user])
        usuario = cursor.fetchone()

    if usuario:
        if check_password_hash(usuario['pass_user'], pass_user):
            session['conectado'] = True
            session['id_user'] = usuario['id_user']
            session['user'] = usuario['user']
            session['email_user'] = usuario['email_user']
            session['foto_user'] = usuario['foto_user']

            return 1
        else:
            return 0


# Validar extension de la imagen
def validar_extension(extension_file):
    # Comprueba si la extensión corresponde a una imagen
    extensiones_permitidas = ['.png', '.jpg', '.jpeg', '.gif']
    if extension_file.lower() not in extensiones_permitidas:
        return False
    else:
        return True


def procesar_foto_perfil(archivo):
    try:
        extension = os.path.splitext(archivo.filename)[1]

        if validar_extension(extension):
            foto_perfil = str(uuid.uuid4().hex) + extension

            # Construir la ruta completa de subida del archivo
            basepath = os.path.abspath(os.path.dirname(__file__))
            upload_dir = os.path.join(basepath, '../static', 'fotos_users')

            # Validar si existe la ruta y crearla si no existe
            if not os.path.exists(upload_dir):
                os.makedirs(upload_dir)

            # Construir la ruta completa de subida del archivo
            upload_path = os.path.join(upload_dir, foto_perfil)
            archivo.save(upload_path)

            return foto_perfil
        else:
            return False
    except Exception as e:
        print("Error al procesar archivo:", e)
        return []


def procesarFoto_user(foto_user):
    if foto_user:
        # Validar el peso del archivo
        tam_max = 1 * 1024 * 1024  # 1 megabytes
        tam_archivo = len(foto_user.read())
        foto_user.seek(0)  # Regresar al inicio del archivo
        if tam_archivo > tam_max:
            return False
        else:
            return True
