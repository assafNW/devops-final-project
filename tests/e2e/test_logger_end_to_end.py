import pytest
import subprocess
import requests

@pytest.mark.e2e
class TestLoggerE2E:

    def test_logger_flow(self, engine_ready):

        # run workflow via CLI
        result = subprocess.run([
            "docker", "exec", "seyoawe-cli",
            "sawectl", "run",
            "--workflow", "workflows/default/hello-logger.yaml",
            "--server", "localhost:8080"
        ])

        assert result.returncode == 0

        # confirm engine processed request
        r = requests.get("http://localhost:9000")
        assert r.status_code == 200