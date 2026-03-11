from flask import Flask, jsonify, redirect, render_template, request, session, url_for
from flask_session import Session
from werkzeug.security import check_password_hash, generate_password_hash
import pymysql
from functools import wraps
import re
import spacy
from word2number import w2n
import os
from werkzeug.utils import secure_filename
from ReceiptScanner import process_receipt
from datetime import datetime

# configure app 
app = Flask(__name__)
app.secret_key = "stayhere"

# configure session to use filesystem instead of signed cookies 
app.config["SESSION_PERMANENT"] = False
app.config["SESSION_TYPE"] = "filesystem"
Session(app)

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

# load the nlp for extracting function 
nlp = spacy.load('en_core_web_lg')
ruler = nlp.add_pipe("entity_ruler", before="ner")
patterns = [
    {"label": "GPE", "pattern": [{"LOWER": "shipley"}]},
    {"label": "DIET", "pattern": [{"LOWER": "halal"}]},
    {"label": "DIET", "pattern": [{"LOWER": "vegan"}]},
    {"label": "DIET", "pattern": [{"LOWER": "vegetarian"}]}
]
ruler.add_patterns(patterns)

# folder for receipt uploads
UPLOAD_FOLDER = "uploads"
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

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
            cursor.execute('INSERT INTO users (email, password) VALUES (%s, %s)', (email, passwordhash))
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
        cursor.execute('SELECT * FROM users WHERE email = %s', (email,))
        account = cursor.fetchone()
        db.close() 

        if account and check_password_hash(account['password'], password):
            session['loggedin'] = True
            session['user_id'] = account['user_id']
            session['email'] = account['email']
            return redirect(url_for("process"))
            #return render_template('chat.html', msg='Logged in successfully!')
        else:
            msg = 'Incorrect username/password!'
    return render_template('login.html', msg=msg)
    

# logout 
@app.route("/logout")
def logout():
    session.pop('loggedin', None)
    session.pop('user_id', None)
    session.pop('username', None)
    session.clear()
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


# save message to db 
def save_msg(role, content):
    try:
        user_id = session.get("user_id")
        created_at = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        db = opendb()

        try:
            with db.cursor() as cursor:
                query = """
                INSERT INTO messages (user_id, role, content, created_at) 
                VALUES (%s, %s, %s, %s)
                """
                values = (user_id, role, content, created_at)
                cursor.execute(query, values)
            db.commit()
        finally:
            db.close()
            
    except Exception as e:
        # catch error
        print(f"DATABASE ERROR: {e}") 


# main chatbot page 
@app.route("/", methods=["GET", "POST"])
@app.route("/chat", methods=["GET", "POST"])
@login_required
def process():
    if request.method == "POST":
        # get the user's message 
        message = request.json["message"] 
        save_msg("user", message)

        # session variables 
        if "stage" not in session:
            session["stage"] = "extract"
        
        if "data" not in session:
            session["data"] = {
                "budget": None,
                "shopping_list": [],
                "city": None,
                "postcode": None,
                "dietary_requirement": None
            }

        # pass message to nlp to make doc variable
        doc = nlp(message)

        # STAGE 1 - EXTRACT
        if session["stage"] == "extract":
            # call extract function on doc. it will directly update the session data dictionary 
            extract(doc, message) 

            # if session dictionary has everything filled
            has_budget   = bool(session["data"].get("budget"))
            has_city     = bool(session["data"].get("city"))
            has_postcode = bool(session["data"].get("postcode"))
            has_items    = bool(session["data"].get("shopping_list"))   

            if all([has_budget, has_city, has_postcode, has_items]):
                # format 
                items = ", ".join(session["data"].get("shopping_list", []))
                diet = f" (Diet: {session['data']['dietary_requirement']})" if session['data']['dietary_requirement'] else ""
        
                # make summary message 
                summary = f"Okay! To confirm, you are in {session['data']['city'].title()} ({session['data']['postcode']}) with a budget of £{session['data']['budget']} for: {items}. {diet} Is this correct?"
                
                save_msg("quick", summary) # add message to db 
                session["stage"] = "confirm"   
                return jsonify({"reply": summary})
            
            else:
                mandatory = ["budget", "shopping_list", "city", "postcode"]
                missing = [k for k in mandatory if not session["data"].get(k)]
                if missing:
                    missing_reply = ", ".join(missing).replace('_', ' ')
                    reply = f"I still need to know your: {missing_reply}."
                    save_msg("quick", reply)
                    return jsonify({"reply": reply}) 
                
                reply = "I've got that. What else can you tell me?"
                save_msg("quick", summary)
                return jsonify({"reply": reply})

        # STAGE 2 - CONFIRM  
        elif session["stage"] == "confirm":           
            # detect if answer is confirmation or negation 
            affirmation = ["yes", "yeah", "correct", "right", "yh", "ok", "confirm"]
            affirmed = any(word in message.lower() for word in affirmation)

            # if answer is a confirmation 
            if affirmed:
                # call calculate function and pass in the dictionary from session data 
                result = calculate(session["data"])
                if not isinstance(result, dict):
                    return jsonify({"reply": f"Sorry, I encountered an error trying to connect to the server."})

                # intro 
                reply = "Okay! I've found the best prices for you:\n\n"

                # loop through items in result and add to the reply
                for item_name, info in result["items"].items():
                    # check if info is a dictionary (meaning a product was found)
                    if isinstance(info, dict) and info.get('product_price', 0) > 0:
                        price = info.get('product_price', 0)
                        store = info.get('store_name', 'Unknown Store')
                        address = info.get('store_address', 'No Address Provided') 
        
                        reply += f"• **{item_name.capitalize()}**: £{price:.2f} at {store} ({address})\n"
                    else:
                        reply += f"• **{item_name.capitalize()}**: ❌ Not available in your current search area.\n"

                # add total cost summary
                reply += f"\n**Total Estimated Cost**: £{result['total_cost']:.2f}"

                if result["within_budget"]:
                    reply += "\n✅ This is within your budget!"
                else:
                    reply += "\n⚠️ This is slightly over your budget."

                # reset the session data and set stage back to extract for the next conversation 
                session.pop("data", None)
                session["stage"] = "extract"
                save_msg("quick", reply)
                return jsonify({"reply": reply, "popup": True, "savings": 2})

            # else if answer is a negation  
            else:
                session["stage"] = "extract" # set stage to extract 
                extract(doc, message) # call extract function on this message and update data

                # format summary 
                items = ", ".join(session["data"].get("shopping_list", []))
                diet = f" (Diet: {session['data']['dietary_requirement']})" if session['data']['dietary_requirement'] else ""

                # make summary message
                summary = f"Thanks! To confirm, you are in {session['data']['city'].title()} ({session['data']['postcode']}) with a budget of £{session['data']['budget']} for: {items}. {diet} Is this correct now?"
                save_msg("quick", summary)
                return jsonify({"reply": summary})  

        reply = "I'm listening! Please tell me your budget, city, postcode, and items."
        save_msg("quick", reply)
        return jsonify({"reply": reply})      
    
    return render_template("main.html")


# extract data from message and directly update the session variable 
def extract(doc, message): 
    # pull session dictionary 
    data = session["data"]
    numbers = []

    # extract full and partial postcodes  
    postcode_pattern = r'([A-Z]{1,2}[0-9][A-Z0-9]?)(?: ?([0-9][A-Z]{2}))?'
    match = re.search(postcode_pattern, message.upper())
    if match:
        if match.group(2):
            pc = f"{match.group(1)} {match.group(2)}" # join postcode parts
        else:
            pc = match.group(1) # only first part of postcode 
        data["postcode"] = pc
    
    # extract locations and requirements with ner 
    for ent in doc.ents:
        if ent.label_ == "GPE":
            if re.match(postcode_pattern, ent.text.upper()): # ignore postcodes 
                continue
            data["city"] = ent.text.lower()

        elif ent.label_ == "DIET":
            data["dietary_requirement"] = ent.text.lower()
            #data["dietary_requirements"].append(ent.text.lower())

    # extract all numbers
    for token in doc:
        if token.like_num:
            try:
                number = w2n.word_to_num(token.text)
                numbers.append(number)
            except ValueError:
                    continue 
            
    # from numbers add the highest one to data[budget] 
    if numbers:
        data["budget"] = max(numbers)

    # extract nouns for shopping list items 
    current_list = data.get("shopping_list", [])

    for chunk in doc.noun_chunks:
        # get the root (main noun in the chunk - one token) 
        # get the head of that root (usually verb it belongs to - eg want in i dont want cake)
  
        # check if the verb is negated (i dont want cake)
        # check the verb for any neg child 
        verb_negated = any(t.dep_ == "neg" for t in chunk.root.head.children)

        # check if the noun itself is negated (i want no cake)
        # just check if any word in the chunk has a neg label bc the noun chunk already only includes the nouns children 
        chunk_negated = any(t.dep_ == "neg" for t in chunk)

        # exclude common words 
        exclude = [
            "budget", "price", "money", "cost", "limit", "amount", "product", "pound",
            "location", "area", "city", "town", "postcode", "house",
            "list", "item", "thing", "stuff", "food", "shopping",
            "store", "shop", "supermarket", "grocer",
            "requirement", "restriction", "diet", "preference", "vegetarian", "vegan"
        ]

        # add to list if not in negated or excluded 
        # lemmatise to deal w plurals 
        item = chunk.root.lemma_.lower().strip()

        if chunk.root.pos_ == "PRON" or chunk.root.ent_type_ in ("PERSON", "GPE", "NORP", "ORG"):
            continue

        if re.match(postcode_pattern, chunk.text.upper()): 
            continue

        if item in exclude or any(word in chunk.text.lower() for word in exclude):
            continue # exit this iteration and go to the next noun chunk 
        
        if verb_negated or chunk_negated: # if on negated list, remove it 
            if item in current_list:
                current_list.remove(item)
                print(f"REMOVED: {item}")
        else: 
            if item not in current_list:
                current_list.append(item)
                print(f"ADDED: {item}")

        # check children for nummod (number modifier) to get quantity of each item? 

    # Save to session  
    data["shopping_list"] = current_list # add modofied shopping list to dictionary 
    session["data"] = data # put dictionary back in session dictionary 

    # print(f"city: {session['data']['city']}")
    # print(f"budget: {session['data']['budget']}")
    # print(f"postcode: {session['data']['postcode']}")
    # print(f"diet: {session['data']['dietary_requirement']}")
    # print(f"shopping: {session['data']['shopping_list']}")


# function to calculate 
def calculate(user_request): # takes a dictionary 
    # return list of shops to get items from 
    try:
        conn = opendb()
    except Exception as e:
        print(f"Connection Error: {e}")
        return "Database Error"
    cursor = conn.cursor()  # Creating a cursor

    clean_postcode = "".join(user_request["postcode"].split()).upper()
    prefix = clean_postcode
    #print(prefix)
    while len(prefix) > 2:
        test_query = f"""
            SELECT COUNT(*) AS store_count
            FROM stores
            WHERE UPPER(REPLACE(store_postcode, ' ', '')) LIKE '{prefix}%'
        """
        cursor.execute(test_query)
        query_res = cursor.fetchone()

        count = query_res["store_count"]
        if count > 0:
            break  # Found a usable prefix

        prefix = prefix[:-1]  # Remove last character

    final_products = {}
    total_cost = 0

    for product in user_request["shopping_list"]:
        query = f"""
            SELECT p.product_id, p.product_name, p.product_price, 
                s.store_id, s.store_name, s.store_address, 
                s.store_postcode, s.store_city
            FROM products p
            JOIN stores s ON p.store_id = s.store_id
            WHERE s.store_city LIKE %s 
            AND UPPER(REPLACE(s.store_postcode, ' ', '')) LIKE %s
            AND p.product_name LIKE %s
            ORDER BY p.product_price ASC
            LIMIT 1
        """
        cursor.execute(query, (f"%{user_request['city']}%", f"{prefix}%", f"%{product}%")) # Execute query
        cheapest_product = cursor.fetchone() # Get the first row of query

        if cheapest_product:
            final_products[product] = cheapest_product
            total_cost += cheapest_product["product_price"]
        else:
            final_products[product] = {"product_name": product, "product_price": 0, "store_name": "Not Found", "store_address": "N/A"}

    conn.close()

    result = {
        "items": final_products,
        "total_cost": total_cost,
        "within_budget": total_cost <= user_request["budget"],
    }

    # for item in result["items"]:
    #     info = result["items"][item]
    #     print(
    #         "You can buy",
    #         info["product_name"],
    #         "from",
    #         info["store_name"],
    #         info["address"],
    #         info["postcode"],
    #         "for £",
    #         info["price"],
    #     )
    # print("Total Cost: £", result["total_cost"])

    return result
    #return "go to the shop"


# load chat history TODO
@app.route("/chathistory", methods=["GET"])
@login_required
def chat_history():
    # TODO 
    # method will always be get 
    # when user goes to this page, show all the prev messages from the db 
    # it will use render template thing to reload that same page 
    return 


# scanner
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
    
# save receipt data
@app.route("/save-receipt", methods=["POST"])
def save_receipt():
    data = request.get_json()
    if not data:
        return jsonify({"error": "No data sent"}), 400

    store_name = data.get("store_name")
    items = data.get("items", [])
    store_address = data.get("store_address", "")
    store_postcode = data.get("store_postcode", "")
    store_city = data.get("store_city", "")

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
                "INSERT INTO stores (store_name, store_address ,store_postcode, store_city) VALUES (%s, %s, %s, %s)",
                (store_name, store_address, store_postcode ,store_city )
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


if __name__ == "__main__":
    app.run(debug=True)

