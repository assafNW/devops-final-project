import yaml
from pathlib import Path
import pytest

ENGINE_ROOT = Path(__file__).resolve().parents[3] / "engine"

@pytest.mark.unit
class TestEngineConfig:

    def test_config_exists(self):
        assert Path(f"{ENGINE_ROOT}/configuration/config.yaml").exists()

    def test_config_loads(self):
        with open(f"{ENGINE_ROOT}/configuration/config.yaml") as f:
            config = yaml.safe_load(f)

        assert config is not None
        assert isinstance(config, dict)

    def test_modules_path(self):
        with open(f"{ENGINE_ROOT}/configuration/config.yaml") as f:
            config = yaml.safe_load(f)

        assert config["directories"]["modules"] == "./modules"

    def test_workflows_path(self):
        with open(f"{ENGINE_ROOT}/configuration/config.yaml") as f:
            config = yaml.safe_load(f)

        assert config["directories"]["workflows"] == "./workflows"

    def test_logs_path(self):
        with open(f"{ENGINE_ROOT}/configuration/config.yaml") as f:
            config = yaml.safe_load(f)

        assert config["directories"]["logs"] == "./logs"