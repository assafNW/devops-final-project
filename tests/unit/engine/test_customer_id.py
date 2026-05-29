import yaml
import pytest

ENGINE_ROOT = Path(__file__).resolve().parents[3] / "engine"

@pytest.mark.unit
class TestCustomerID:

    def test_customer_id_exists(self):
        with open(f"{ENGINE_ROOT}/configuration/config.yaml") as f:
            data = yaml.safe_load(f)
        assert "app" in data
        assert "customer_id" in data["app"]