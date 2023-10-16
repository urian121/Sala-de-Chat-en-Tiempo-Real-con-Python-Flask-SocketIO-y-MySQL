
from confiBD.conexionBD import *


def ultimo_mensaje_enviado_recibido(id_user_session, id_amigo_seleccionado):
    try:
        with connectionBD() as conexion_MySQLdb:
            with conexion_MySQLdb.cursor(dictionary=True) as mycursor:
                querySQL = """
                    SELECT
                        u.email_user, 
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
                    ORDER BY c.id_chat  DESC LIMIT 1
                """
                params = (id_user_session, id_amigo_seleccionado,
                          id_amigo_seleccionado, id_user_session)
                # print("Consulta SQL:", querySQL)
                # print("Parámetros:", params)
                mycursor.execute(querySQL, params)
                lista_chat = mycursor.fetchone()
                return lista_chat or []
    except Exception as e:
        print(
            f"Error al buscar el amigo seleccionado: {e}")
        return []


# Cantidad de mensajes sin leer por usuario
def cantidad_mensajes_sin_leer(id_amigo_seleccionado):
    try:
        with connectionBD() as conexion_MySQLdb:
            with conexion_MySQLdb.cursor(dictionary=True) as mycursor:
                querySQL = """
                    SELECT COUNT(*) AS total_mensajes_sin_leer FROM tbl_chat
                    WHERE estatus_leido = %s 
                    AND para_id_user = %s
                """
                params = (0, id_amigo_seleccionado)
                mycursor.execute(querySQL, params)
                total_mensajes = mycursor.fetchone()  # Use fetchone() instead of fetchall()
                # Access the count using the alias
                return total_mensajes['total_mensajes_sin_leer']
    except Exception as e:
        print(f"Error en la cantidad de mensajes sin leer: {e}")
        return 0  # Return 0 or raise an exception, depending on the desired behavior
