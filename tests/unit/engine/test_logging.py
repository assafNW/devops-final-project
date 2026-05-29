from pathlib import Path

import pytest

APP_DATA_ROOT = Path(__file__).resolve().parents[3] / "app_data"

@pytest.mark.unit
class TestLogging:

    def test_logs_directory_exists(self):
        assert Path(f"{APP_DATA_ROOT}/logs").exists()

    def test_workflow_log_exists(self):
        assert Path(f"{APP_DATA_ROOT}/logs/workflow_engine.log").exists()

    def test_flask_log_exists(self):
        assert Path(f"{APP_DATA_ROOT}/logs/flask_app.log").exists()