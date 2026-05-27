import requests
import pytest
import subprocess

@pytest.mark.integration
class TestWorkflowExecution:

    def test_trigger_workflow(self, engine_ready):
        r = requests.post(
            "http://localhost:8080/api/default/hello-world",
            json={}
        )
        assert r.status_code in [200, 201, 202]
    