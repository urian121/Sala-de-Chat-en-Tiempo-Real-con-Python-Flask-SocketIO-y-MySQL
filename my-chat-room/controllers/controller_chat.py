
import os
from os import path  # Modulo para obtener la ruta o directorio
import uuid  # Modulo de python para crear un string
from confiBD.conexionBD import *


def lista_amigos_chat(id_user_session):
    try:
        with connectionBD() as conexion_MySQLdb:
            with conexion_MySQLdb.cursor(dictionary=True) as mycursor:
                querySQL = f"""
                    SELECT
                        u.id_user,
                        u.user,
                        u.email_user,
                        u.foto_user,
                        u.online,
                        SUM(CASE WHEN c.estatus_leido = 0 AND c.para_id_user = %s THEN 1 ELSE 0 END) AS total_mensajes_sin_leer
                    FROM
                        tbl_users u
                    LEFT JOIN
                        tbl_chat c ON u.id_user = c.para_id_user OR u.id_user = c.desde_id_user
                    WHERE
                        u.id_user != %s
                    GROUP BY
                        u.id_user, u.user, u.email_user, u.foto_user, u.online
                    ORDER BY
                        u.user ASC
                """
                mycursor.execute(querySQL, (id_user_session, id_user_session))
                lista_amigos_chats = mycursor.fetchall()
                return lista_amigos_chats

    except Exception as e:
        print(f"Ocurrió un error listando la lista de amigos/chat: {e}")
        return []


# Funcion que recibe el id del amigo seleccionado y retorna los chats del mismo.
def buscar_chat_amigoBD(id_user_session, id_amigo_seleccionado):
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


# Status amigo seleccionado
def status_amigo(id_amigo):
    try:
        with connectionBD() as conexion_MySQLdb:
            with conexion_MySQLdb.cursor(dictionary=True) as mycursor:
                querySQL = """
                            SELECT
                              u.id_user,
                              u.user,
                              u.foto_user,
                              u.online
                            FROM tbl_users AS u
                            WHERE id_user=%s
                            LIMIT 1
                        """
                mycursor.execute(querySQL, (id_amigo,))
                amigoBD = mycursor.fetchone()
                return amigoBD or []
    except Exception as e:
        print(
            f"Error status amigo seleccionado: {e}")
        return []


# Función que recibe el id del amigo seleccionado y retorna la información del amigo
def buscar_informacion_amigoBD(id_amigo):
    try:
        with connectionBD() as conexion_MySQLdb:
            with conexion_MySQLdb.cursor(dictionary=True) as mycursor:
                querySQL = """
                            SELECT 
                              u.user,
                              u.email_user,
                              u.tlf_user,
                              u.foto_user,
                              u.description_user,
                              u.online
                            FROM tbl_users AS u
                            WHERE id_user=%s
                            LIMIT 1
                        """
                mycursor.execute(querySQL, (id_amigo,))
                amigoBD = mycursor.fetchone()
                return amigoBD or []

    except Exception as e:
        print(
            f"Error al buscar el amigo seleccionado: {e}")
        return []


def procesar_form_msj(desde_id_user, para_id_user, mensaje):
    try:
        # Conexión a la base de datos
        with connectionBD() as conexion_MySQLdb:
            with conexion_MySQLdb.cursor(dictionary=True) as cursor:
                sql = (
                    "INSERT INTO tbl_chat(desde_id_user, para_id_user, mensaje) VALUES (%s, %s, %s)")
                valores = (desde_id_user, para_id_user, mensaje)
                cursor.execute(sql, valores)
                conexion_MySQLdb.commit()

                resultado_insert = cursor.rowcount
                return buscar_chat_amigoBD(desde_id_user, para_id_user) if resultado_insert > 0 else []

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

       # print(f"el nombre file: ", nuevo_nombre_archivo)
        return nuevo_nombre_archivo
    except Exception as e:
        print("Error al procesar archivo:", e)
        return None


def process_form(desde_id_user, para_id_user, mensaje, resp_process_archivo):
    try:
        with connectionBD() as conexion_MySQLdb:
            with conexion_MySQLdb.cursor(dictionary=True) as cursor:
                sql = (
                    "INSERT INTO tbl_chat(desde_id_user, para_id_user, mensaje, archivo_img) VALUES (%s, %s, %s, %s)")
                valores = (desde_id_user, para_id_user,
                           mensaje, resp_process_archivo)
                cursor.execute(sql, valores)
                conexion_MySQLdb.commit()

                resultado_insert = cursor.rowcount
                return 1 if resultado_insert > 0 else []

    except Exception as e:
        return f'Se produjo un error al insertar registrar el mensaje: {str(e)}'


# Guardando audio en servidor
def process_audio_chat(desde_id_user, para_id_user, fileAudio):
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
                    sql = "INSERT INTO tbl_chat(desde_id_user, para_id_user, file_audio) VALUES (%s, %s, %s)"
                    valores = (desde_id_user, para_id_user, nuevo_nombre_audio)
                    cursor.execute(sql, valores)
                    conexion_MySQLdb.commit()

                    resultado_insert = cursor.rowcount
                    return 1 if resultado_insert > 0 else []

        except Exception as e:
            return f'Se produjo un error al insertar registrar el mensaje: {str(e)}'

    except Exception as e:
        print("Error al procesar archivo:", e)
        return None
