import pytest
from pathlib import Path

@pytest.mark.unit
class TestModuleSymlink:

    def test_modules_symlink(self):
        assert Path("modules/modules").exists()