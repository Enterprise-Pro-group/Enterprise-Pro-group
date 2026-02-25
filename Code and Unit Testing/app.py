from flask import Flask, redirect, render_template, request, session, url_for
from werkzeug.security import check_password_hash, generate_password_hash
import pymysql
from functools import wraps
import re

# configure app 
app = Flask(__name__)
app.secret_key = "stayhere"

# connect to database 
def opendb():
    db = pymysql.connect(
        host = "localhost",
        database = "shopquick",
        user = "root",
        password = "",
        port= 3306,
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
    @wraps(f) # pass functions to this function first to require login 
    def wrapper(*args, **kwargs): # decorated functions can have any parameters 
        if 'loggedin' not in session:
            return redirect("/login")
        return f(*args, **kwargs) # if logged in call original function 
    return wrapper


# sign up
@app.route("/signup", methods=["GET", "POST"])
def signup():
    msg = ''
    if request.method == 'POST' and 'email' in request.form and 'password' in request.form :
        email = request.form.get('email')
        password = request.form.get('password')
        db = opendb()
        cursor = db.cursor()
        cursor.execute('SELECT * FROM users WHERE email = %s', (email,))
        account = cursor.fetchone()
        
        if account:
            msg = 'Account already exists!'
        elif not re.match(r'[^@]+@[^@]+\.[^@]+', email):
            msg = 'Invalid email address!'

        elif  not password or not email:
            msg = 'Please fill out the form!'
        else:
            passwordhash = generate_password_hash(password)
            cursor.execute('INSERT INTO users (email, password_hash) VALUES (%s, %s)', (email, passwordhash))
            db.commit()
            msg = 'You have successfully registered!'
            db.close()
            return redirect(url_for('login'))
        
    return render_template('signup.html', msg=msg)


# login
@app.route("/login", methods=["GET", "POST"])
def login():
    msg = ''
    if request.method == 'POST' and 'email' in request.form and 'password' in request.form:
        email = request.form['email']
        password = request.form['password']
        db = opendb() 
        cursor = db.cursor()
        cursor.execute('SELECT * FROM users WHERE email = %s', (email))
        account = cursor.fetchone()
        db.close() 

        if account and check_password_hash(account['password_hash'], password):
            session['loggedin'] = True
            session['user_id'] = account['user_id']
            session['email'] = account['email']
            return render_template('chat.html', msg='Logged in successfully!')
        else:
            msg = 'Incorrect username/password!'
    return render_template('login.html', msg=msg)
    

# logout 
@app.route("/logout")
def logout():
    session.pop('loggedin', None)
    session.pop('user_id', None)
    session.pop('username', None)
    return redirect(url_for('login'))

@app.route("/settings")
def settings():
    return render_template("settings.html")

# change password TODO
@app.route("/changepassword", methods=["GET", "POST"])
@login_required
def change_password():
    if request.method == "POST":
        # TODO 
        return redirect("settings.html")

    return render_template("settings.html")

# change email TODO
@app.route("/changeemail", methods=["GET", "POST"])
@login_required
def change_email():
    if request.method == "POST":
        # TODO 
        return redirect("settings.html")

    return render_template("settings.html")

# delete account TODO
@app.route("/deleteaccount", methods=["GET", "POST"])
@login_required
def delete_account():
    if request.method == "POST":
        # TODO
        return render_template("settings.html")
    
    return render_template("settings.html")

# delete data TODO
@app.route("/deletehistory", methods=["GET", "POST"])
@login_required
def delete_history():
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
        # it needs to add more messages not just replace that one. so not render? 
        return render_template("chat.html", reply=message)
    
    return render_template("chat.html")

# function to calculate TODO
def calculate(): # takes a dictionary 
    # TODO 
    # return list of shops to get items from 
    return 

# load chat history TODO
@app.route("/chathistory", methods=["GET"])
@login_required
def chat_history():
    # TODO 
    # method will always be get 
    # when user goes to this page, show all the prev messages from the db 
    # it will use render template thing to reload that same page 
    return 
    
# scanner TODO 
@app.route("/scan", methods=["GET", "POST"])
@login_required
def scan():
    if request.method == "POST":
        # TODO - 
        return render_template("index.html")

    return render_template("")

if __name__ == "__main__":
    app.run(debug=True)

