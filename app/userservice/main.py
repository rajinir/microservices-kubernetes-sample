import os
from flask import Flask, redirect, url_for, request, render_template
from pymongo import MongoClient

app = Flask(__name__)

client = MongoClient(host=['192.168.99.100:32463'])
db = client["mydatabase"]
userscol = db["users"]


@app.route('/')
def users():

    _items = userscol.find()
    items = [item for item in _items]

    return render_template('users.html', items=items)


@app.route('/new', methods=['POST'])
def new():

    item_doc = {
        'userid': request.form['userid'],
        'name': request.form['name'],
        'title': request.form['title'],
        'department': request.form['department']
    }
    userscol.insert_one(item_doc)

    return redirect(url_for('users'))

if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=True)
