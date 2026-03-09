# Enterprise-Pro-group 

- install python 3.12.10: https://www.python.org/ftp/python/3.12.10/python-3.12.10-amd64.exe

- install tesseract engine: https://github.com/tesseract-ocr/tesseract/releases/download/5.5.0/tesseract-ocr-w64-setup-5.5.0.20241111.exe

## Set up environment 
- cd 'code and unit testing' 

- install dependencies 
  - (windows): python -m venv venv && venv\Scripts\activate && pip install -r requirements.txt

  - (linux/mac): python3 -m venv venv && source venv/bin/activate && pip install -r requirements.txt

- install spacy nlp
  - pip install https://github.com/explosion/spacy-models/releases/download/en_core_web_lg-3.7.0/en_core_web_lg-3.7.0-py3-none-any.whl

## Run app 
- cd 'code and unit testing' 
- activate venv
  - (windows): venv\Scripts\activate 
  - (linux/mac): source venv/bin/activate

- run app 
  - (windows): python app.py
  - (linux/mac): python3 app.py 

- follow url

- stop app 
  - ctrl+c

- deactivate venv 
  - deactivate
