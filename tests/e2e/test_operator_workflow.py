import requests
import pytest

@pytest.mark.e2e
class TestOperatorWorkflow:

    def test_workflow_execution(self, engine_ready):
        r = requests.post(
            "http://localhost:8080/api/default/hello-world",
            json={}
        )
        assert r.status_code in [200, 201, 202]