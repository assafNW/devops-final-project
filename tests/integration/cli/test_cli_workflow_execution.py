import subprocess
import pytest
import os

ENGINE_URL = os.getenv("ENGINE_URL", "seyoawe-engine:8080")

@pytest.mark.integration
class TestCLIWorkflowExecution:

    def test_cli_executes_workflow(self, engine_ready):
        result = subprocess.run([
            "docker", "exec", "seyoawe-cli",
            "sawectl", "run",
            "--workflow", "workflows/default/hello_logger",
            "--server", f"{ENGINE_URL}"
        ])

        assert result.returncode == 0