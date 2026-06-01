import pytest
import requests

@pytest.fixture(scope="session")
def engine_ready():
    assert requests.get("http://localhost:9000").status_code == 200
    return True


@pytest.fixture(scope="session")
def ttyd_ready():
    assert requests.get("http://localhost:8081").status_code == 200
    return True


@pytest.fixture(scope="session")
def webform_ready():
    assert requests.get("http://localhost:9000/webform_bundle.js").status_code == 200
    return True