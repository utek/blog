import os
import sys
import http.server
import socketserver

from invoke import task

DEPLOY_PATH = "output"


@task
def clean(c):
    if os.path.isdir(DEPLOY_PATH):
        c.run("rm -rf {}".format(DEPLOY_PATH))
        c.run("mkdir {}".format(DEPLOY_PATH))


@task
def build(c):
    c.run("pelican -s pelicanconf.py")


@task
def rebuild(c):
    clean(c)
    build(c)


@task
def regenerate(c):
    c.run("pelican -r -s pelicanconf.py")


@task
def serve(c):
    os.chdir(DEPLOY_PATH)

    PORT = 8000

    class AddressReuseTCPServer(socketserver.TCPServer):
        allow_reuse_address = True

    server = AddressReuseTCPServer(("", PORT), http.server.SimpleHTTPRequestHandler)

    sys.stderr.write("Serving on port {0} ...\n".format(PORT))
    server.serve_forever()


@task
def reserve(c):
    build(c)
    serve(c)


@task
def publish(c):
    c.run("pelican -s publishconf.py")
