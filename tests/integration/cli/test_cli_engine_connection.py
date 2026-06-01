import subprocess
import pytest
import os


ENGINE_URL = os.getenv("ENGINE_URL", "http://seyoawe-engine:8080")

@pytest.mark.integration
class TestCLIEngineConnection:

    def test_cli_runs_workflow(self, engine_ready):
        result = subprocess.run([
            "docker", "exec", "seyoawe-cli",
            "sawectl", "run",
            "--workflow", "workflows/default/hello-world.yaml",
            "--server", f"{ENGINE_URL}"
        ], capture_output=True, text=True)

        assert result.returncode == 0