import pytest
import requests
from pathlib import Path

APP_DATA_ROOT = Path(__file__).resolve().parents[3] / "app_data"

@pytest.mark.integration
class TestLogsRuntime:

    def test_logs_written(self, engine_ready):
        # trigger any request
        requests.post(
            "http://localhost:8080/api/default/hello-world",
            json={}
        )
        log_dir = Path(f"{APP_DATA_ROOT}/logs")
        assert log_dir.exists()
        assert any(log_dir.iterdir())