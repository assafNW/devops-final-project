import yaml
import pytest

@pytest.mark.unit
class TestCustomerID:

    def test_customer_id_exists(self):
        with open("configuration/config.yaml") as f:
            data = yaml.safe_load(f)
        assert "app" in data
        assert "customer_id" in data["app"]