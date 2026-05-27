from pathlib import Path

import pytest


@pytest.mark.unit
class TestWebformAssets:

    def test_webform_directory_exists(self):
        assert Path("modules/webform").exists()

    def test_asset_script_exists(self):
        assert Path(
            "modules/webform/link_assets.sh"
        ).exists()