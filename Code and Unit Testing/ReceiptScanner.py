#https://pyimagesearch.com/2021/10/27/automatically-ocring-receipts-and-scans/
import cv2
import imutils
import pytesseract #an interface to the Tesseract OCR engine
import re #regular expressions for pattern matching
from imutils.perspective import four_point_transform # applies a birds-eye view of an input image

#pytesseract.pytesseract.tesseract_cmd = r"C:\Users\MH103\AppData\Local\Programs\Tesseract-OCR\tesseract.exe"


def process_receipt(image_path):

    # Load image
    orig = cv2.imread(image_path)
    image = orig.copy() #Make a clone of the image, image processing is done on clone
    image = imutils.resize(image, width=500)
    ratio = orig.shape[1] / float(image.shape[1])

   # Convert to grayscale , blur it and detect edges
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    blurred = cv2.GaussianBlur(gray, (5, 5), 0)
    edged = cv2.Canny(blurred, 75, 200)


  #  Find contours in edge map and sort them by  size in descending order
    cnts = cv2.findContours(edged.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    cnts = imutils.grab_contours(cnts)
    cnts = sorted(cnts, key=cv2.contourArea, reverse=True)
    #assume largest contour is receipt


   # if no countour found , use the orginal image
    receiptCnt = None
    for c in cnts:
        peri = cv2.arcLength(c, True)
        approx = cv2.approxPolyDP(c, 0.02 * peri, True)
        if len(approx) == 4:#if there are 4 points ,assume that is the receipt
            receiptCnt = approx
            break

    # if no countour found , use the orginal image
    if receiptCnt is None:
        receipt = orig.copy()
    else:
        warped = four_point_transform(orig, receiptCnt.reshape(4, 2) * ratio)
        receipt = warped if warped is not None else orig.copy()

    # OCR
    options = "--psm 6" #PSm 6 assumes a single uniform block of test , used for receipts
    text = pytesseract.image_to_string(
        cv2.cvtColor(receipt, cv2.COLOR_BGR2RGB),
        config=options
    )

    raw_text = pytesseract.image_to_string(orig)
     # Choose best result raw or transformed 
    final_text = text if len(text.strip()) > len(raw_text.strip()) else raw_text

   
    # EXTRACT ITEMS
    

    price_pattern = r'(\d+\.\d{2})'

    ignore_words = [
        "SUBTOTAL", "TOTAL", "TAX",
        "AMOUNT DUE", "CREDIT", "DEBIT",
        "CARD", "CASH", "CHANGE", "VISA"
    ]

    items = []

    for row in final_text.split("\n"):
        row = row.strip()
        if not row:
            continue

        # Must contain price
        price_match = re.search(price_pattern, row)
        if not price_match:
            continue

        # Ignore totals/tax/etc
        if any(word in row.upper() for word in ignore_words):
            continue

        price = price_match.group(1)

        # Remove price from row to get name
        name = re.sub(price_pattern, "", row).strip()
        name = re.sub(r'\s{2,}', ' ', name)

        if len(name) < 2:
            continue

        items.append({
            "name": name,
            "price": price
        })

   
    #extract the store name from the receipt , we are checking first 5 lines
    lines = [line.strip() for line in final_text.split("\n") if line.strip()]
    store_name = "Unknown Store"
    location = "Unknown Location"

    for line in lines[:5]:

        # 1. Store name: first line without digits
        if not re.search(r'\d', line):
            if store_name == "Unknown Store":  # only take the first valid one
                store_name = line
            continue

        # 2. Location: simple pattern like "123 High Street"
        if re.search(r'\d{1,3}\s\w+\s\w+', line):
            location = line
            continue

    return {
        "store_name": store_name,
        "items": items,
        "location": location
    }

        
            
    