#!/usr/bin/python\

from flask import Flask, render_template, request
import socket

host = "/tmp/9Lq7BNBnBycd6nxy.socket"

sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
sock.connect((host))

server = Flask(__name__)

@server.route('/')
def main():
    return "Hello World!"

@server.route('/button')
def read_button():
    result = {}
    return render_template("button.html", result = result)

@server.route('/leds', methods = ['POST', 'GET'])
def set_leds():
    if request.method == 'GET': 
        return render_template('leds.html')
    
    elif request.method == 'POST': 
        # leds
        print("ppp")
        return "post"
    
if __name__ == '__main__':
    server.run()

while 1:
        sock.sendall(bytes('ola!' + "\n", "utf-8"))
        received = str(sock.recv(1024), "utf-8")
        print(received)