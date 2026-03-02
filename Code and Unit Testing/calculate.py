from flask import Flask, jsonify, redirect, render_template, request, session
from flask_session import Session
from werkzeug.security import check_password_hash, generate_password_hash
import pymysql
from functools import wraps
import db

budget = float(input("Enter budget: "))
shopping_list = input("Enter shopping: ").split(",")
city = input("Enter city: ")
postcode = input("Enter postcode: ")
dietary_req = input("Enter dietary requirement: ")

user_request = {
    "budget": budget,
    "shopping_list": shopping_list,
    "city": city,
    "postcode": postcode.replace(" ", ""),
    "dietary_requirement": dietary_req,
}


# function to calculate TODO
def calculate(user_request):  # takes a dictionary
    conn = db.opendb()  # Creating a connection
    if conn is None:
        return "Database Error"
    cursor = conn.cursor()  # Creating a cursor

    clean_postcode = "".join(user_request["postcode"].split()).upper()
    prefix = clean_postcode
    while len(prefix) > 2:
        # Try the full prefix first
        test_query = f"""
            SELECT COUNT(*) FROM stores
            WHERE UPPER(REPLACE(postcode, ' ', '')) LIKE '{prefix}%'
        """
        cursor.execute(test_query)
        count = cursor.fetchone()[0]

        if count > 0:
            break  # Found a usable prefix

        prefix = prefix[:-1]  # Remove last character

    final_products = {}
    total_cost = 0

    for product in user_request["shopping_list"]:
        query = f"""
                    SELECT p.id, p.product_name, p.price, s.id, s.store_name, s.address, s.postcode, s.city
                    FROM products p
                    JOIN stores s on p.store_id = s.id
                    WHERE s.city LIKE '%{user_request["city"]}%'
                    AND REPLACE(s.postcode, ' ', '') LIKE '%{prefix}%'
                    AND p.product_name LIKE '%{product}%'
                    ORDER BY p.price ASC
                    LIMIT 1
                """

        cursor.execute(query)  # Execute query
        cheapest_product = cursor.fetchone()  # Get the first row of query

        final_products[product] = cheapest_product
        total_cost += cheapest_product["price"]

    conn.close()

    result = {
        "items": final_products,
        "total_cost": total_cost,
        "within_budget": total_cost <= budget,
    }

    for item in result["items"]:
        info = result["items"][item]
        print(
            "You can buy",
            info["product_name"],
            "from",
            info["store_name"],
            info["address"],
            info["postcode"],
            "for £",
            info["price"],
        )
    print("Total Cost: £", result["total_cost"])

    return result


calculate(user_request)
