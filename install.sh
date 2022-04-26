#!/bin/bash

test -d "./django-setup-template" || git clone https://github.com/theArtechnology/django-setup-template.git

cp django-setup-template/* .

test -d .venv || python3 -m venv .venv

. .venv/bin/activate

pip install -r requirements.txt

make requirements

test -d core || django-admin startproject core .

mkdir ./core/settings
touch ./core/settings/{__init__.py,defaults.py,prod.py,dev.py,staging.py}

awk 'NR==16 {$0="BASE_DIR = Path(__file__).resolve().parent.parent.parent"} { print }' ./core/settings.py >  ./core/settings/defaults.py 

cat <<EOF > ./core/settings/__init__.py
import os

ENV = os.getenv("ENV", "prod")

if ENV == "dev":
    from app.settings.dev import *
elif ENV == "staging":
    from app.settings.staging import *
else:
    from app.settings.prod import *
EOF


cat <<EOF > ./core/settings/dev.py
from dotenv import load_dotenv
from app.settings.defaults import *
from pathlib import Path
import os

load_dotenv()

DEBUG = True

# SECRET_KEY = os.getenv('SECRET_KEY')

LOGGING = {
    "version": 1,
    "disable_existing_loggers": False,
    "formatters": {"rich": {"datefmt": "[%X]"}},
    "handlers": {
        "console": {
            "class": "rich.logging.RichHandler",
            "formatter": "rich",
            "level": "DEBUG",
        }
    },
    "loggers": {"django": {"handlers": ["console"]}},
}

EOF

cat <<EOF > ./core/settings/prod.py
from dotenv import load_dotenv
from app.settings.defaults import *
from pathlib import Path
import os

load_dotenv()

DEBUG = False

# SECRET_KEY = os.getenv('SECRET_KEY')

EOF

cat <<EOF > ./core/settings/staging.py
from dotenv import load_dotenv
from app.settings.defaults import *
from pathlib import Path
import os

load_dotenv()

DEBUG = False

# SECRET_KEY = os.getenv('SECRET_KEY')

EOF