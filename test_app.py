import openai
from app import app


def fake_chat_completion_create(*args, **kwargs):
    prompt = kwargs['messages'][1]['content']
    if 'Kazakh text' in prompt:
        return {'choices': [{'message': {'content': 'Привет'}}]}
    return {'choices': [{'message': {'content': 'С\u04d9лем'}}]}


def test_index():
    client = app.test_client()
    resp = client.get('/')
    assert resp.status_code == 200
    assert b'Translator' in resp.data


def test_translate(monkeypatch):
    monkeypatch.setattr(openai.ChatCompletion, 'create', fake_chat_completion_create)
    client = app.test_client()
    resp = client.post('/translate', json={'text': 'S\u0259lem', 'direction': 'kk-ru'})
    assert resp.status_code == 200
    assert resp.get_json()['translated'] == 'Привет'
    resp = client.post('/translate', json={'text': 'Privet', 'direction': 'ru-kk'})
    assert resp.get_json()['translated'] == '\u0421\u04d9\u043b\u0435\u043c'
