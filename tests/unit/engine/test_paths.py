import pytest
from pathlib import Path

ENGINE_ROOT = Path(__file__).resolve().parents[3] / "engine"
APP_DATA_ROOT = Path(__file__).resolve().parents[3] / "app_data"

@pytest.mark.unit
class TestPaths:

    def test_modules_path(self):
        assert Path(f"{ENGINE_ROOT}/modules").exists()

    def test_workflows_path(self):
        assert Path(f"{ENGINE_ROOT}/workflows").exists()

    def test_logs_path(self):
        assert Path(f"{APP_DATA_ROOT}/logs").exists()