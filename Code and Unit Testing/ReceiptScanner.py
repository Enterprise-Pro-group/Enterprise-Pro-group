import cv2
import imutils
import pytesseract
import re
from imutils.perspective import four_point_transform

pytesseract.pytesseract.tesseract_cmd = r"C:\Users\MH103\AppData\Local\Programs\Tesseract-OCR\tesseract.exe"

# Image must be in same folder as this script
IMAGE_PATH = "RECEIPT.png"

# Load image
orig = cv2.imread(IMAGE_PATH)
if orig is None:
    raise Exception("Image not found. Make sure RECEIPT.png is in the same folder.")

image = orig.copy()
image = imutils.resize(image, width=500)
ratio = orig.shape[1] / float(image.shape[1])

# Convert to grayscale and detect edges
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
blurred = cv2.GaussianBlur(gray, (5, 5), 0)
edged = cv2.Canny(blurred, 75, 200)

# Find contours
cnts = cv2.findContours(edged.copy(), cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
cnts = imutils.grab_contours(cnts)
cnts = sorted(cnts, key=cv2.contourArea, reverse=True)

receiptCnt = None

for c in cnts:
    peri = cv2.arcLength(c, True)
    approx = cv2.approxPolyDP(c, 0.02 * peri, True)
    if len(approx) == 4:
        receiptCnt = approx
        break

# Warp perspective if contour found
if receiptCnt is None:
    print("[INFO] No contour detected — using original image.")
    receipt = orig.copy()
else:
    warped = four_point_transform(orig, receiptCnt.reshape(4, 2) * ratio)
    receipt = warped if warped is not None else orig.copy()

# Further preprocessing
gray_receipt = cv2.cvtColor(receipt, cv2.COLOR_BGR2GRAY)
scaled = cv2.resize(gray_receipt, None, fx=2, fy=2, interpolation=cv2.INTER_CUBIC)

thresh = cv2.adaptiveThreshold(
    scaled,
    255,
    cv2.ADAPTIVE_THRESH_GAUSSIAN_C,
    cv2.THRESH_BINARY,
    31,
    2
)

# Show processed image
cv2.imshow("Processed Receipt", thresh)
cv2.destroyAllWindows()

# Try multiple PSM modes
psm_modes = ["6", "4", "11", "7"]
warp_text = ""

for psm in psm_modes:
    config = f"--psm {psm}"
    text = pytesseract.image_to_string(thresh, config=config)
    if len(text.strip()) > 5:
        warp_text = text
        print(f"\n[INFO] OCR Success with PSM {psm}")
        break

# Backup OCR using original image
raw_text = pytesseract.image_to_string(orig)

# Choose best result
final_text = warp_text if len(warp_text.strip()) > len(raw_text.strip()) else raw_text

print("\n[INFO] Final OCR Output")
print("=======================")
print(final_text)

print("\n[INFO] Price Line Items")
print("=======================")

pricePattern = r'([0-9]+\.[0-9]+)'

for row in final_text.split("\n"):
    if re.search(pricePattern, row):
        print(row)