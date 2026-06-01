import subprocess
import pytest

@pytest.mark.integration
class TestCLIWorkflowExecution:

    def test_cli_executes_workflow(self, engine_ready):
        result = subprocess.run([
            "docker", "exec", "seyoawe-cli",
            "sawectl", "run",
            "--workflow", "workflows/default/hello_logger.yaml",
            "--server", "ENGINE_URL:8080"
        ])

        assert result.returncode == 0