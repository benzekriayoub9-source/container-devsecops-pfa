from flask import Flask, jsonify, render_template

from .config import config_by_name


def create_app(config_name: str = "production") -> Flask:
    app = Flask(__name__)
    app.config.from_object(config_by_name.get(config_name, config_by_name["production"]))

    @app.after_request
    def set_security_headers(response):
        """En-têtes HTTP de durcissement (OWASP)."""
        response.headers["X-Content-Type-Options"] = "nosniff"
        response.headers["X-Frame-Options"] = "DENY"
        response.headers["X-XSS-Protection"] = "1; mode=block"
        response.headers["Referrer-Policy"] = "strict-origin-when-cross-origin"
        response.headers["Content-Security-Policy"] = (
            "default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'"
        )
        response.headers.pop("Server", None)
        return response

    @app.route("/")
    def index():
        return render_template("index.html")

    @app.route("/health")
    def health():
        return jsonify({"status": "healthy", "service": "secure-webapp"}), 200

    @app.route("/api/info")
    def info():
        return jsonify({
            "message": "Application sécurisée DevSecOps",
            "version": "1.0.0",
        })

    @app.errorhandler(404)
    def not_found(_error):
        return jsonify({"error": "Ressource introuvable"}), 404

    @app.errorhandler(500)
    def internal_error(_error):
        return jsonify({"error": "Erreur interne du serveur"}), 500

    return app
