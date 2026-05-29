import pytest
from pathlib import Path

ENGINE_ROOT = Path(__file__).resolve().parents[3] / "engine"

@pytest.mark.unit
class TestModuleSymlink:

    def test_modules_symlink(self):
        assert Path(f"{ENGINE_ROOT}/modules/modules").exists()