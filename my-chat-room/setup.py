# Importando Flask y algunos paquetes
from application import *


# Importando mis controlles
from controllers.controller_login import *
from controllers.controller_chat import *

# Importando SocketIO del lado del Servidor
from controllers.socketIO import *

# Controlador para manejar paginas no encontradas
from controllers.controller_page_not_found import *


# Arrancando aplicacion Flask
if __name__ == '__main__':
    """ 
    Se llama a la función socketio.run() para iniciar el servidor de Flask-SocketIO.
    Esto significa que cuando ejecutes este archivo específico, el servidor Flask-SocketIO 
    se iniciará y estará listo para recibir conexiones y manejar eventos de socket.
    """
    socketio.run(app, debug=True, port=5600)
