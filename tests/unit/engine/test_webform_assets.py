from pathlib import Path

import pytest

ENGINE_ROOT = Path(__file__).resolve().parents[3] / "engine"

@pytest.mark.unit
class TestWebformAssets:

    def test_webform_directory_exists(self):
        assert Path(f"{ENGINE_ROOT}/modules/webform").exists()

    def test_asset_script_exists(self):
        assert Path(f"{ENGINE_ROOT}/modules/webform/link_assets.sh").exists()