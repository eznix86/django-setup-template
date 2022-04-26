from dotenv import load_dotenv
from core.settings.defaults import *
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