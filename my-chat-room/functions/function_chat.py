import os
from os import path  # Modulo para obtener la ruta o directorio
import uuid  # Modulo de python para crear un string
from confiBD.conexionBD import *


def lista_mensajes_chat():
    try:
        with connectionBD() as conexion_MySQLdb:
            with conexion_MySQLdb.cursor(dictionary=True) as mycursor:
                querySQL = """
                        SELECT 
                            DATE_FORMAT(fecha_mensaje, '%d de %b %Y %I:%i %p') AS fecha_dia_mes_year,
                            mensaje, archivo, file_audio
                        FROM tbl_chat ORDER BY id_chat ASC
                        """
                mycursor.execute(querySQL,)
                lista_chat = mycursor.fetchall()
                if lista_chat:
                    return lista_chat
                else:
                    return {}
    except Exception as e:
        print(f"Ocurrió un error listando los chat: {e}")
        return 0


def lista_amigos_chat():
    try:
        with connectionBD() as conexion_MySQLdb:
            with conexion_MySQLdb.cursor(dictionary=True) as mycursor:
                querySQL = "SELECT * FROM tbl_users ORDER BY user ASC"
                mycursor.execute(querySQL,)
                lista_amigos_chat = mycursor.fetchall()
                if lista_amigos_chat:
                    return lista_amigos_chat
                else:
                    return {}
    except Exception as e:
        print(f"Ocurrió un error listando la lista de amigos/chat: {e}")
        return 0


# Funcion que recibe el id del amigo seleccionado y retorna los chats del mismo.
def buscar_chat_amigoBD(id_amigo):
    try:
        with connectionBD() as conexion_MySQLdb:
            with conexion_MySQLdb.cursor(dictionary=True) as mycursor:
                querySQL = """
                        SELECT 
                            DATE_FORMAT(fecha_mensaje, '%d de %b %Y %I:%i %p') AS fecha_dia_mes_year,
                            mensaje, archivo, file_audio
                        FROM tbl_chat ORDER BY id_chat ASC
                        """
                mycursor.execute(querySQL,)
                lista_chat = mycursor.fetchall()
                # mycursor.execute(querySQL, (id_amigo,))
                if lista_chat:
                    return lista_chat
                else:
                    return []
    except Exception as e:
        print(
            f"Error al buscar el amigo seleccionado: {e}")
        return []


# Función que recibe el id del amigo seleccionado y retorna la información del amigo
def buscar_informacion_amigoBD(id_amigo):
    try:
        with connectionBD() as conexion_MySQLdb:
            with conexion_MySQLdb.cursor(dictionary=True) as mycursor:
                querySQL = """
                            SELECT *
                              FROM tbl_users
                              WHERE id_user=%s
                              LIMIT 1
                            """
                mycursor.execute(querySQL, (id_amigo,))
                amigoBD = mycursor.fetchone()
                if amigoBD:
                    return amigoBD
                else:
                    return []
    except Exception as e:
        print(
            f"Error al buscar el amigo seleccionado: {e}")
        return []


def procesar_form_msj(desde_id_user, mensaje):
    try:
        # Conexión a la base de datos
        with connectionBD() as conexion_MySQLdb:
            with conexion_MySQLdb.cursor(dictionary=True) as cursor:
                sql = (
                    "INSERT INTO tbl_chat(desde_id_user, mensaje) VALUES (%s, %s)")
                valores = (desde_id_user, mensaje,)
                cursor.execute(sql, valores)
                conexion_MySQLdb.commit()

                resultado_insert = cursor.rowcount
                if (resultado_insert):
                    return lista_mensajes_chat()
                else:
                    return []
    # Simplemente se utiliza para capturar cualquier excepción que se produzca en el bloque try
    except Exception as e:
        return f'Se produjo un error al insertar registrar el mensaje: {str(e)}'


def procesar_archivo(archivo):
    try:
        extension = os.path.splitext(archivo.filename)[1]
        nuevo_nombre_archivo = str(uuid.uuid4().hex) + extension

        # Construir la ruta completa de subida del archivo
        basepath = os.path.abspath(os.path.dirname(__file__))
        upload_dir = os.path.join(basepath, '../static', 'archivos_chat')

        # Validar si existe la ruta y crearla si no existe
        if not os.path.exists(upload_dir):
            os.makedirs(upload_dir)

        # Construir la ruta completa de subida del archivo
        upload_path = os.path.join(upload_dir, nuevo_nombre_archivo)
        archivo.save(upload_path)

        return nuevo_nombre_archivo
    except Exception as e:
        print("Error al procesar archivo:", e)
        return None


def process_form(file, desde_id_user, mensaje):
    try:
        with connectionBD() as conexion_MySQLdb:
            with conexion_MySQLdb.cursor(dictionary=True) as cursor:
                sql = (
                    "INSERT INTO tbl_chat(desde_id_user, mensaje, archivo) VALUES (%s, %s, %s)")
                valores = (desde_id_user, mensaje, file)
                cursor.execute(sql, valores)
                conexion_MySQLdb.commit()

                resultado_insert = cursor.rowcount
                if (resultado_insert):
                    return lista_mensajes_chat()
                else:
                    return []
    except Exception as e:
        return f'Se produjo un error al insertar registrar el mensaje: {str(e)}'


# Guardando audio en servidor
def process_audio_chat(fileAudio):
    try:
        extension = os.path.splitext(fileAudio.filename)[1]
        nuevo_nombre_audio = str(uuid.uuid4().hex) + extension

        # Construir la ruta completa de subida del archivo
        basepath = os.path.abspath(os.path.dirname(__file__))
        upload_dir = os.path.join(basepath, '../static', 'audios_chat')

        # Validar si existe la ruta y crearla si no existe
        if not os.path.exists(upload_dir):
            os.makedirs(upload_dir)

        # Construir la ruta completa de subida del archivo
        upload_path = os.path.join(upload_dir, nuevo_nombre_audio)
        fileAudio.save(upload_path)

        try:
            with connectionBD() as conexion_MySQLdb:
                with conexion_MySQLdb.cursor(dictionary=True) as cursor:
                    sql = "INSERT INTO tbl_chat(file_audio) VALUES (%s)"
                    valores = (nuevo_nombre_audio,)
                    cursor.execute(sql, valores)
                    conexion_MySQLdb.commit()

                    resultado_insert = cursor.rowcount
                    if (resultado_insert):
                        return 1
                    else:
                        return []
        except Exception as e:
            return f'Se produjo un error al insertar registrar el mensaje: {str(e)}'

    except Exception as e:
        print("Error al procesar archivo:", e)
        return None
