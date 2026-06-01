import pytest
import requests
from pathlib import Path

@pytest.mark.integration
class TestLogsRuntime:

    def test_logs_written(self, engine_ready):
        # trigger any request
        requests.post(
            "http://localhost:8080/api/default/hello-world",
            json={}
        )
        log_dir = Path("logs")
        assert log_dir.exists()
        assert any(log_dir.iterdir())