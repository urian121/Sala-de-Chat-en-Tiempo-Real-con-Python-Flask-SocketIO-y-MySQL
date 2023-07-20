
# Importando el objeto app de mi
from application import *
from flask import session, request, redirect, url_for


@app.errorhandler(404)
def page_not_found(error):
    if 'conectado' in session and request.method == 'GET':
        return redirect(url_for('chat'))
    else:
        return redirect(url_for('index'))
