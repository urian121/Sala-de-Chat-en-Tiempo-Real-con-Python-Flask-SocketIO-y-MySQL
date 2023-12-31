# IMPORTANDO LA CLASE flask de Flask
from flask import Flask

# Creando una instancia de la clase Flask y asigna esa instancia a la variable app
app = Flask(__name__)
application = app
app.secret_key = '97110c78ae51a45af397b6534caef90ebb9b1dcb3380f008f90b23a5d1616bf1bc29098105da20fe'
# Establece el límite de tamaño de contenido máximo permitido para las solicitudes entrantes en 16 megabytes
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024


