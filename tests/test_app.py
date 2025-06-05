import os
import sys

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from app import app


def test_main_page():
    client = app.test_client()
    response = client.get('/')
    assert response.status_code == 200
    assert b'Hello, world!' in response.data
