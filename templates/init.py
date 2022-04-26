import os

ENV = os.getenv("ENV", "prod")

if ENV == "dev":
    from core.settings.dev import *
elif ENV == "staging":
    from core.settings.staging import *
else:
    from core.settings.prod import *