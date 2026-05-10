from flask import Flask, request

app = Flask(__name__)

@app.route('/')
def index():
    ua = request.headers.get("User-Agent")

    if ua == "KingHacker/1.0":
        return "FLAG{CURL_UA_BYPASS_SUCCESS}"
    else:
        return "Access Denied: Your browser is not allowed."

app.run(host="0.0.0.0", port=5000)
