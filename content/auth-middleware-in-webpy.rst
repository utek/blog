WebPy middleware authorization
##############################

:date: 2012-11-12 20:00
:tags: python, webpy, middleware
:slug: webpy-middleware-authorization
:author: Łukasz Bołdys
:category: programming


middleware.py
-------------

.. code-block:: python

    class AuthApp(SimpleHTTPRequestHandler):
        def __init__(self, environ, start_response):
            self.headers = []
            self.environ = environ
            self.start_response = start_response

        def send_response(self, status, msg=""):
            self.status = str(status) + " " + msg

        def send_header(self, name, value):
            self.headers.append((name, value))

        def end_headers(self):
            pass

        def log_message(*a): pass

        def __iter__(self):
            environ = self.environ
            self.send_header('WWW-Authenticate','Basic realm="App authorization"')
            self.send_response(401, "Unauthorized")
            self.start_response(self.status, self.headers)
            yield "Unauthorized"

        AUTH = settings.AUTH

        class AuthMiddleware:
            """WSGI Middleware for authentication."""
            def __init__(self, app):
                self.app = app
            def __call__(self, environ, start_response):
                #allowed = [("test", "test")]
                allowed = AUTH
                auth = environ.get('HTTP_AUTHORIZATION')
                authreq = False
                if auth is None:
                    authreq = True
                else:
                    auth = re.sub('^Basic ','',auth)
                    username,password = base64.decodestring(auth).split(':')
                    if (username,password) in allowed:
                        return self.app(environ, start_response)
                    else:
                        authreq = True
                if authreq:
                    return AuthApp(environ, start_response)


In your main webpy project code
--------------------------------

.. code-block:: python

    app = web.application(urls, locals())
    app.add_processor(load_sqla)

    application = app.wsgifunc(AuthMiddleware) # for WSGI

    if __name__ == "__main__":
        pass
        app.run(AuthMiddleware) # for direct execution





