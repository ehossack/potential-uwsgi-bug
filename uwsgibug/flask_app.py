from flask import Flask
import time

app = Flask(__name__)

@app.route('/hello')
def hello_world():
    return 'Hello, World!'

@app.route('/')
def reproduce():
    time.sleep(120)
    return 'Reproduced!'

print(app.url_map)