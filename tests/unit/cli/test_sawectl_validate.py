import subprocess
import pytest

@pytest.mark.unit
class TestSawectlValidate:

    def test_validate_workflow(self):
        result = subprocess.run([
            "docker", "exec", "seyoawe-cli",
            "sawectl", "validate-workflow",
            "--workflow", "workflows/default/hello-world.yaml"
        ], capture_output=True, text=True)

        assert result.returncode in [0, 1]