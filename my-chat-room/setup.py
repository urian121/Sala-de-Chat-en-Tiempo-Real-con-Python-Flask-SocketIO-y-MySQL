# Declarando nombre de la aplicación e inicializando, crear la aplicación Flask
from application import app

# Importando todos mis routers
from routers.socketIO import *
from routers.router_chat import *  # Router Tienda
from routers.router_login import *  # Router Login
from routers.router_page_not_found import *


# Ejecutando el objeto Flask, arrancando aplicacion Flask
if __name__ == '__main__':
    """ 
    Se llama a la función socketio.run() para iniciar el servidor de Flask-SocketIO.
    Esto significa que cuando ejecutes este archivo específico, el servidor Flask-SocketIO 
    se iniciará y estará listo para recibir conexiones y manejar eventos de socket.
    """
    socketio.run(app, debug=True, port=5600)
