import yaml
from pathlib import Path
import pytest

@pytest.mark.unit
class TestConfig:

    def test_config_exists(self):
        assert Path("configuration/config.yaml").exists()

    def test_config_loads(self):
        with open("configuration/config.yaml") as f:
            data = yaml.safe_load(f)
        assert isinstance(data, dict)

from pathlib import Path

import yaml

import pytest


@pytest.mark.unit
class TestEngineConfig:

    def test_config_exists(self):
        assert Path("configuration/config.yaml").exists()

    def test_config_loads(self):
        with open("configuration/config.yaml") as f:
            config = yaml.safe_load(f)

        assert config is not None

    def test_modules_path(self):
        with open("configuration/config.yaml") as f:
            config = yaml.safe_load(f)

        assert config["directories"]["modules"] == "./modules"

    def test_workflows_path(self):
        with open("configuration/config.yaml") as f:
            config = yaml.safe_load(f)

        assert config["directories"]["workflows"] == "./workflows"

    def test_logs_path(self):
        with open("configuration/config.yaml") as f:
            config = yaml.safe_load(f)

        assert config["directories"]["logs"] == "./logs"