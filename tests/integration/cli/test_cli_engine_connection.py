import subprocess
import pytest

@pytest.mark.integration
class TestCLIEngineConnection:

    def test_cli_runs_workflow(self, engine_ready):
        result = subprocess.run([
            "docker", "exec", "seyoawe-cli",
            "sawectl", "run",
            "--workflow", "workflows/default/hello-world.yaml",
            "--server", "localhost:8080"
        ], capture_output=True, text=True)

        assert result.returncode == 0