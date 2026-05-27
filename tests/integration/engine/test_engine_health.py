import requests
import pytest

@pytest.mark.integration
class TestEngineHealth:

    def test_health(self, engine_ready):
        r = requests.get("http://localhost:8080/health")
        assert r.status_code == 200