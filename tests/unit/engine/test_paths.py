import pytest
from pathlib import Path

@pytest.mark.unit
class TestPaths:

    def test_modules_path(self):
        assert Path("modules").exists()

    def test_workflows_path(self):
        assert Path("workflows").exists()

    def test_logs_path(self):
        assert Path("logs").exists()