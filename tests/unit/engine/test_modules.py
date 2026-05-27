from pathlib import Path
import pytest


@pytest.mark.unit
class TestModules:

    def test_modules_directory_exists(self):
        assert Path("modules").exists()

    def test_logger_module_exists(self):
        assert Path(
            "modules/logger"
        ).exists()

    def test_command_module_exists(self):
        assert Path(
            "modules/command_module"
        ).exists()

    def test_module_yaml_exists(self):
        assert Path(
            "modules/logger/module.yaml"
        ).exists()