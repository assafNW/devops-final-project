import subprocess
import pytest

@pytest.mark.unit
class TestCLICommands:

    def test_prompt(self):
        result = subprocess.run([
            "docker", "exec", "seyoawe-cli",
            "sawectl"
        ], capture_output=True, text=True)

        assert result.returncode == 0
    
    def test_version(self):
        result = subprocess.run([
            "docker", "exec", "seyoawe-cli",
            "sawectl", "--version"
        ], capture_output=True, text=True)

        assert result.returncode == 0
    
    def test_help(self):
        result = subprocess.run([
            "docker", "exec", "seyoawe-cli",
            "sawectl", "--help"
        ])
        assert result.returncode == 0