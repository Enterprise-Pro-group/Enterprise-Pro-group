#https://pyimagesearch.com/2021/10/27/automatically-ocring-receipts-and-scans/
import cv2
import imutils
import pytesseract #an interface to the Tesseract OCR engine
import re #regular expressions for pattern matching
from imutils.perspective import four_point_transform # applies a birds-eye view of an input image

pytesseract.pytesseract.tesseract_cmd = r"C:\Users\MH103\AppData\Local\Programs\Tesseract-OCR\tesseract.exe"




# Load image
orig = cv2.imread(r"C:\Users\MH103\Desktop\OneDrive - University of Bradford\University year 2\sem 2\GitHub\Enterprise-Pro-group\Code and Unit Testing\RECEIPT.png")


image = orig.copy() #Make a clone of the image, image processing is done on clone
image = imutils.resize(image, width=500)
ratio = orig.shape[1] / float(image.shape[1])

# Convert to grayscale , blur it and detect edges
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
blurred = cv2.GaussianBlur(gray, (5, 5), 0)
edged = cv2.Canny(blurred, 75, 200)

# Find contours in edge map and sort them by  size in descending order
cnts = cv2.findContours(edged.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
cnts = imutils.grab_contours(cnts)
cnts = sorted(cnts, key=cv2.contourArea, reverse=True)
#assume largest contour is receipt
receiptCnt = None

for c in cnts:
    peri = cv2.arcLength(c, True)
    approx = cv2.approxPolyDP(c, 0.02 * peri, True)
    if len(approx) == 4: #if there are 4 points ,assume that is the receipt
        receiptCnt = approx
        break

# if no countour found , use the orginal image
if receiptCnt is None:
    print("[INFO] No contour detected — using original image.")
    receipt = orig.copy()
else:
    warped = four_point_transform(orig, receiptCnt.reshape(4, 2) * ratio)
    receipt = warped if warped is not None else orig.copy()



# Show processed image
cv2.imshow("Processed Receipt" ,receipt)
cv2.destroyAllWindows()


options = "--psm 6"
text = pytesseract.image_to_string(
	cv2.cvtColor(receipt, cv2.COLOR_BGR2RGB),
	config=options)



# Backup OCR using original image
raw_text = pytesseract.image_to_string(orig)

# Choose best result
final_text = text if len(text.strip()) > len(raw_text.strip()) else raw_text

print("\n[INFO] Final OCR Output")
print("=======================")
print(final_text)
"""
print("\n[INFO] Price Line Items")
print("=======================")

pricePattern = r'([0-9]+\.[0-9]+)'

for row in final_text.split("\n"):
    if re.search(pricePattern, row):
        print(row)
"""
print("\n[INFO] Clean Price Line Items")
print("==============================")

pricePattern = r'([0-9]+\.[0-9]+)'

ignore_words = [
    "SUBTOTAL", "TOTAL", "TAX",
    "AMOUNT DUE", "CREDIT", "DEBIT",
    "CARD", "CASH", "CHANGE" , "VISA"
]

for row in final_text.split("\n"):
    row = row.strip()
    if not row:
        continue

    # Must contain a price
    if not re.search(pricePattern, row):
        continue

    # IF WORD IS IN IGNORE LIST - MANUALLY MADE THIS
    if any(word in row.upper() for word in ignore_words):
        continue

    print(row)

print("\n[INFO] Detected Store")
print("=======================")

lines = [line.strip() for line in final_text.split("\n") if line.strip()]

store_name = None

for line in lines[:5]:  # Only check first few lines
    # Ignore lines with numbers (likely address or phone)
    if not re.search(r'\d', line):
        store_name = line
        break

print("Store:", store_name if store_name else "Not detected")