from flask import Flask, request, jsonify
from flask_cors import CORS
from dotenv import load_dotenv
import os
import pymongo

app = Flask(__name__)
CORS(app)

# Load environment variables from .env file
load_dotenv()

MONGO_URI = os.getenv('MONGO_URI')

# Connect to MongoDB
client = pymongo.MongoClient(MONGO_URI)
# Create or get the database
db = client.test

collection = db["flask_collection"]

app = Flask(__name__)

@app.route("/")
def index():
    return "Welcome to the Flask API! Use /submit to post data and /api to retrieve data."

@app.route("/submit", methods=["POST"])
def submit_form():
    try:
        data = request.json
        collection.insert_one(data)
        return jsonify({"status": "success"}), 200
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500


@app.route('/api')
def get_data():
    # Retrieve all documents from the collection
    data = list(collection.find())
    # Convert ObjectId to string for JSON
    for item in data:
        item['_id'] = str(item['_id'])
    return {"data": data}

if __name__ == '__main__':
    app.run(host="0.0.0.0", port="8000", debug=True)