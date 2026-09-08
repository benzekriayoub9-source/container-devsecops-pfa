import os

from app import create_app

application = create_app(os.environ.get("FLASK_ENV", "production"))

if __name__ == "__main__":
    application.run(host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))
