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

# no cache 
@app.after_request
def after_request(response):
    """Ensure responses aren't cached"""
    response.headers["Cache-Control"] = "no-cache, no-store, must-revalidate"
    response.headers["Expires"] = 0
    response.headers["Pragma"] = "no-cache"
    return response

# decorarte routes to require login  
def login_required(f):
    """
    @wraps(f) # pass functions to this function first to require login 
    def logged_in(*args, **kwargs): # decorated functions can have any parameters 
        if session.get("user_id") is None:
            return redirect("/login")
        return f(*args, **kwargs) # if logged in call original function 
    return logged_in

    """



# sign up TODO
@app.route("/signup", methods=["GET", "POST"])
def signup():
    if request.method == "POST":
        # TODO - get email and password, hash password, store in db 
        return redirect("chat.html")
    
    return render_template("register.html")

# login TODO
@app.route("/login", methods=["GET", "POST"])
def login():
    # forget any user id
    session.clear()

    if request.method == "POST":
        # TODO - authenticate email and password, set session variable  
        return redirect("chat.html")

    return render_template("login.html")
    
# logout 
@app.route("/logout")
def logout():
    # forget any user id
    session.clear()
    return redirect("/")

# change password TODO
@app.route("/changepassword", methods=["GET", "POST"])
@login_required
def changePassword():
    if request.method == "POST":
        # TODO 
        return redirect("settings.html")

    return render_template("settings.html")

# change email TODO
@app.route("/changeemail", methods=["GET", "POST"])
@login_required
def changeEmail():
    if request.method == "POST":
        # TODO 
        return redirect("settings.html")

    return render_template("settings.html")

# delete account TODO
@app.route("/delete", methods=["GET", "POST"])
@login_required
def delete():
    if request.method == "POST":
        # TODO
        return render_template("settings.html")
    
    return render_template("settings.html")


# main page - send a message to quick TODO
@app.route("/", methods=["GET", "POST"])
@app.route("/chat", methods=["GET", "POST"])
@login_required
def process():
    if request.method == "POST":
        # TODO 
        message = request.form["message"] # get the user's message 
        # add to db 

        # extract the data from user input and store in dictionary 

        # ask user if its correct 
        # understand that and amend dictionary 

        # when validated call calculate on the dictionary 
        # calculate will return the shops to go to 

        # write the shops into a nice message 
        # add to db 

        # dynamically render the result into the right area of the page 
        # redirect 
        return "you should go to the shop"
    
    return render_template("chat.html")

# function to calculate TODO
def calculate(): # takes a dictionary 
    # TODO 
    # return list of shops to get items from 
    return 

# load chat history TODO
@app.route("/chathistory", methods=["GET", "POST"])
@login_required
def loadHistory():
    if request.method == "POST":
        # TODO - use messages table from database 
        return redirect("")

    return render_template("")
    
# scanner TODO 
@app.route("/scan", methods=["GET", "POST"])
@login_required
def scan():
    if request.method == "POST":
        # TODO - 
        return render_template("index.html")

    return render_template("")



