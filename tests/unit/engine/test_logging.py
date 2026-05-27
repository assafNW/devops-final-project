from pathlib import Path

import pytest


@pytest.mark.unit
class TestLogging:

    def test_logs_directory_exists(self):
        assert Path("logs").exists()

    def test_workflow_log_exists(self):
        assert Path(
            "logs/workflow_engine.log"
        ).exists()

    def test_flask_log_exists(self):
        assert Path(
            "logs/flask_app.log"
        ).exists()