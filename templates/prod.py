from dotenv import load_dotenv
from core.settings.defaults import *
from pathlib import Path
import os

load_dotenv()

DEBUG = False

# SECRET_KEY = os.getenv('SECRET_KEY')