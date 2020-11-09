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
    print("Py: Button")
    sock.sendall(bytes("10\n", "utf-8"))
    received = str(sock.recv(1024), "utf-8")
    print("Py: {}".format(received))
    return 1 if received else 0

@server.route('/leds', methods = ['POST', 'GET'])
def set_leds():
    if request.method == 'GET': 
        return render_template('leds.html')
    
    elif request.method == 'POST': 
        # leds
        on = 0
        if request.form.get('LED1') == 'on': on = 1

        print('Py: Post led')
        #print(on)
        sock.sendall(bytes(str(on) + "\n", "utf-8"))
        return render_template('leds.html')
    
if __name__ == '__main__':
    server.run(host='0.0.0.0', port=5000)