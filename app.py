#!/usr/bin/env python3
#-*- coding: utf-8 -*-

from flask import Flask, request, jsonify
# import subprocess
import pyttsx3

app = Flask(__name__)


@app.route('/')
def home():
   return "Hello, World!"

@app.route('/webhook', methods=['POST'])
def webhook():
    data = request.get_json()

    # Assuming the GitLab webhook payload includes a 'message' field
    commit_message = data.get('message', 'No commit message')

    # Print the commit message to stdout
    print(f"\033[36mReceived GitLab webhook. Commit message:\033[0m {commit_message}")
    # subprocess.run(["espeak", commit_message])
    pyttsx3.speak(f"COMMIT MESSAGE: {commit_message}")

    return jsonify({'status': 'success'})


if __name__ == '__main__':
    app.run(port=5000, debug=True)
