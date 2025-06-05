import os

from flask import Flask, render_template, request, jsonify
import openai
from dotenv import load_dotenv

load_dotenv()
openai.api_key = os.getenv("OPENAI_API_KEY")

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')


@app.route('/translate', methods=['POST'])
def translate():
    data = request.get_json(force=True)
    text = data.get('text', '')
    direction = data.get('direction', 'kk-ru')
    if direction == 'kk-ru':
        prompt = f"Translate this Kazakh text into Russian: {text}"
    else:
        prompt = f"Translate this Russian text into Kazakh: {text}"

    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=[
            {"role": "system", "content": "You are a helpful translation assistant."},
            {"role": "user", "content": prompt},
        ],
    )

    translated = response["choices"][0]["message"]["content"].strip()
    return jsonify({"translated": translated})

if __name__ == '__main__':
    app.run(debug=True)
