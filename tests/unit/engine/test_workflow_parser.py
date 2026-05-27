import yaml
import pytest


@pytest.mark.unit
class TestWorkflowParser:

    def test_hello_world_exists(self):
        assert Path(
            "workflows/default/hello-world.yaml"
        ).exists()

    def test_hello_world_valid_yaml(self):

        with open(
            "workflows/default/hello-world.yaml"
        ) as f:

            workflow = yaml.safe_load(f)

        assert workflow is not None