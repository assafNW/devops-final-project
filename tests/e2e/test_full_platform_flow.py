import requests
import pytest

@pytest.mark.e2e
class TestFullPlatformFlow:

    def test_system_health(self, engine_ready, ttyd_ready):
        assert requests.get("http://localhost:9000").status_code == 200
        assert requests.get("http://localhost:8081").status_code == 200