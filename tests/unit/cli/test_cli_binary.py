import subprocess
import pytest

@pytest.mark.unit
class TestCLIBinary:

    def test_cli_help(self):
        result = subprocess.run([
            "docker", "exec", "seyoawe-cli",
            "sawectl", "--help"
        ], capture_output=True, text=True)

        assert result.returncode == 0