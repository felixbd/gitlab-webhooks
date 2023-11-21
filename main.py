#!/usr/bin/env python3
#-*- coding: utf-8 -*-

from flask import Flask, request, jsonify
import subprocess

app = Flask(__name__)

@app.route('/webhook', methods=['POST'])
def webhook():
    data = request.get_json()

    # Assuming the GitLab webhook payload includes a 'message' field
    commit_message = data.get('message', 'No commit message')

    # Print the commit message to stdout
    print(f"Received GitLab webhook. Commit message: {commit_message}")
    subprocess.run(["espeak", commit_message])

    return jsonify({'status': 'success'})


if __name__ == '__main__':
    app.run(port=5000, debug=True)
