from pathlib import Path
import pytest

ENGINE_ROOT = Path(__file__).resolve().parents[3] / "engine"

@pytest.mark.unit
class TestModules:

    def test_modules_directory_exists(self):
        assert Path(f"{ENGINE_ROOT}/modules").exists()

    def test_logger_module_exists(self):
        assert Path(f"{ENGINE_ROOT}/modules/logger").exists()

    def test_command_module_exists(self):
        assert Path(f"{ENGINE_ROOT}/modules/command_module").exists()

    def test_module_yaml_exists(self):
        assert Path(f"{ENGINE_ROOT}/modules/logger/module.yaml").exists()