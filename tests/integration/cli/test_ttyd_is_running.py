import requests
import pytest

@pytest.mark.integration
class TestTtydIsRunning:

    def test_ttyd_is_running(self):
        r = requests.get("http://localhost:8081")
        assert r.status_code in (200, 101)