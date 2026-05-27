import pytest
import requests

@pytest.mark.integration
class TestWebformAssets:

    def test_webform_bundle(self, webform_ready):
        r = requests.get("http://localhost:9000/webform_bundle.js")
        assert r.status_code == 200