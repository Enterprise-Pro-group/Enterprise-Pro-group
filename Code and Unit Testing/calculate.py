from flask import Flask, jsonify, redirect, render_template, request, session
from flask_session import Session
from werkzeug.security import check_password_hash, generate_password_hash
import pymysql
from functools import wraps

# configure app 
app = Flask(__name__)

# database config
dbhost = ''
dbname = ''
dbuser = ''
dbpassword = ''

# connect to database 
def opendb():
    db = pymysql.connect(
        host=dbhost,
        database=dbname,
        user=dbuser,
        password=dbpassword,
        cursorclass=pymysql.cursors.DictCursor
    )
    return db

# function to calculate TODO
def calculate(): # takes a dictionary 
    # TODO 
    # return list of shops to get items from 
    return