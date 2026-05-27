import subprocess
import pytest

@pytest.mark.integration
class TestSawectlWorkflowValidation:

    def test_validate_logger_workflow(self):
        result = subprocess.run([
            "docker", "exec", "seyoawe-cli",
            "sawectl", "validate-workflow",
            "--workflow", "workflows/default/hello_logger.yaml"
        ])

        assert result.returncode == 0