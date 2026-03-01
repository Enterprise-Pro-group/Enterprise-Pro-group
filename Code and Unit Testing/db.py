import pymysql

# database config
dbhost = 'localhost'
dbname = 'shopquick'
dbuser = 'root'
dbpassword = 'root123'

# connect to database 
def opendb():
    try:
        db = pymysql.connect(
            host=dbhost,
            database=dbname,
            user=dbuser,
            password=dbpassword,
            cursorclass=pymysql.cursors.DictCursor
        )
        print("Database connected successfully!")
        return db
    except pymysql.MySQLError as e:
        print("Database connection failed:", e)
        return None