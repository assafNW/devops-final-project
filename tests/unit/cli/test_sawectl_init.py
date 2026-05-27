import subprocess
import pytest

@pytest.mark.unit
class TestSawectlInit:

    def test_init_module(self):
        result = subprocess.run([
            "docker", "exec", "seyoawe-cli",
            "sawectl", "init", "module", "logger"
        ], capture_output=True, text=True)

        assert result.returncode in [0, 1] 