import pytest
from playwright.sync_api import sync_playwright

@pytest.mark.e2e
class TestWebformUI:

    def test_webform_loads(self, webform_ready):
        with sync_playwright() as p:
            browser = p.chromium.launch()
            page = browser.new_page()

            page.goto("http://localhost:8080")
            assert page.is_visible("body")

            browser.close()