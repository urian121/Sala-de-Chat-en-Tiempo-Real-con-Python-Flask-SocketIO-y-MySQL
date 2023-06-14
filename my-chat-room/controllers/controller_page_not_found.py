
# Importando el objeto app de mi
from application import *


@app.errorhandler(404)
def page_not_found(error):
    if 'conectado' in session and request.method == 'GET':
        return redirect(url_for('chat'))
    else:
        return redirect(url_for('index'))
