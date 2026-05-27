import requests
import pytest

@pytest.mark.integration
class TestEngineAPI:

    def test_api_root(self, engine_ready):
        r = requests.get("http://localhost:8080/")
        assert r.status_code in [200, 404]