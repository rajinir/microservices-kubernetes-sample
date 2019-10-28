import os
from flask import Flask, redirect, url_for, request, render_template
from pymongo import MongoClient

app = Flask(__name__)

client = MongoClient(host=['192.168.99.100:32463'])
db = client["mydatabase"]
taskscol = db["tasks"]
userscol = db["users"]

@app.route('/')
def tasks():

    _items = taskscol.find()
    items = [item for item in _items]

    return render_template('tasks.html', items=items)


@app.route('/new', methods=['POST'])
def new():
    
    userid = request.form['userid']
    user = userscol.find_one({'userid': userid})
    

    item_doc = {
        'name': request.form['name'],
        'description': request.form['description'],
        'user': user["name"]
    }
    taskscol.insert_one(item_doc)

    return redirect(url_for('tasks'))

if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=True)
