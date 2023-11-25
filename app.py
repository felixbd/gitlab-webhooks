#!/usr/bin/env python3.11
#-*- coding: utf-8 -*-

from flask import Flask, request, jsonify
import pyttsx3

app = Flask(__name__)


@app.route('/')
def home():
   return "<h1 style=\"text-align:center\">Hello, World!</h1>"

@app.route('/webhook', methods=['POST'])
def webhook():
    data = request.get_json()

    # match each action
    match data.get("object_kind", "default"):
        case "push" | "tag_push":
            print("-> push")

            commit_message = data.get('message', 'No commit message')
            print(f"\033[36mReceived GitLab webhook. Commit message:\033[0m {commit_message}")
            pyttsx3.speak(f"COMMIT MESSAGE from Git-Lab: {commit_message}")

        case "issue":
            print("-> issue")

        case "note":
            print("-> note")

        case "merge_request":
            print("-> merge request")

        case "build":
            print("-> build")

        case "default" | _ :
            print("-> default")
            return jsonify({'status': 'failure', 'error': 'Invalid input or internal server error.'})

    return jsonify({'status': 'success'})


if __name__ == '__main__':
    # try:

    app.run(port=5000, debug=True)

    # except KeyboardInterrupt as err:
    #     app.aborter()
