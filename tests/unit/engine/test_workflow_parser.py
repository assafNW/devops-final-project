import yaml
import pytest
from pathlib import Path

ENGINE_ROOT = Path(__file__).resolve().parents[3] / "engine"

@pytest.mark.unit
class TestWorkflowParser:

    def test_hello_world_exists(self):
        assert Path(f"{ENGINE_ROOT}/workflows/default/hello-world.yaml").exists()

    def test_hello_world_valid_yaml(self):
        with open(f"{ENGINE_ROOT}/workflows/default/hello-world.yaml") as f:
            workflow = yaml.safe_load(f)

        assert workflow is not None