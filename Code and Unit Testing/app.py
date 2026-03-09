from flask import Flask, jsonify, redirect, render_template, request, session, url_for
from werkzeug.security import check_password_hash, generate_password_hash
import pymysql
from functools import wraps
import re
import os
from werkzeug.utils import secure_filename
from ReceiptScanner import process_receipt

# configure app 
app = Flask(__name__)
app.secret_key = "stayhere"

UPLOAD_FOLDER = "uploads" #creating an uploads folder to store uploaded receipts
os.makedirs(UPLOAD_FOLDER, exist_ok=True)



# connect to database 
def opendb():
    db = pymysql.connect(
        host = "localhost",
        database = "shop_quick",
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

@app.route('/login')
def login():
    return render_template('login.html')

@app.route('/signup')
def SignUp():
    return render_template('SignUp.html')



"""
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

"""

# scanner TODO 
@app.route("/scan", methods=["POST"])
def scan():
    if "receipt" not in request.files:
        return jsonify({"error": "No file uploaded"}), 400

    file = request.files["receipt"]
    if file.filename == "":
        return jsonify({"error": "Empty filename"}), 400

    filename = secure_filename(file.filename)
    filepath = os.path.join(UPLOAD_FOLDER, filename) #adding  receipt to uploads folder

    try:
        file.save(filepath)
        extracted_data = process_receipt(filepath) #extracted data is a dictionary that stores , store name , address , and item prices and names

        store_name = extracted_data.get("store_name") or ""
        items = extracted_data.get("items") or []
        store_address = extracted_data.get("store_address") or ""

        validated_items = []
        for item in items:
            if "product_name" in item and "product_price" in item:
                try:
                    validated_items.append({
                        "product_name": item["product_name"].strip(),
                        "product_price": float(item["product_price"])
                    })
                except ValueError:
                    continue

        if len(validated_items) == 0:
            return jsonify({
                "is_receipt": False,
            }), 200



        return jsonify({
            "is_receipt": True,
            "store_name": store_name,
            "items": validated_items,
            "store_address": store_address
        })
    
    except Exception as e:
        print("Scan error:", e)
        return jsonify({"error": "Failed to process receipt"}), 500
    

@app.route("/save-receipt", methods=["POST"])
def save_receipt():
    data = request.get_json()
    if not data:
        return jsonify({"error": "No data sent"}), 400

    store_name = data.get("store_name")
    items = data.get("items", [])
    store_address = data.get("store_address", "")

    if not store_name or not items:
        return jsonify({"error": "Invalid data"}), 400

    db = opendb()
    cursor = db.cursor()

    try:
        
        cursor.execute(
            "SELECT store_id FROM stores WHERE store_name = %s AND store_address = %s",
            (store_name, store_address)
        )

        if store := cursor.fetchone():
            store_id = store["store_id"]
        else:
            cursor.execute(
                "INSERT INTO stores (store_name, store_address) VALUES (%s, %s)",
                (store_name, store_address)
            )
            db.commit()
            store_id = cursor.lastrowid

        for item in items:
           
            cursor.execute("""
                INSERT INTO products (product_name, product_price, store_id)
                VALUES (%s, %s, %s)
            """, (
                item["product_name"].strip().title(),
                float(item["product_price"]),
                store_id
            ))
        

        db.commit()
        return jsonify({"message": "Receipt saved successfully!"})
    


    finally:
        db.close()


@app.route("/")
def index():
    return render_template("main.html")
if __name__ == "__main__":
    app.run(debug=True)
