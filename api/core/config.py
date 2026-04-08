import os

DEFAULT = dict(
    APP_NAME="Sambhota",
    DATABASE_URL="postgresql://admin:agentAdmin@localhost:5434/agent"
)

def get(key: str) -> str:
    if key in os.environ:
        return os.environ[key]
    else:
        return str(DEFAULT[key])