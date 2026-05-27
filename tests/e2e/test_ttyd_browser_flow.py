import pytest
from playwright.sync_api import sync_playwright

@pytest.mark.e2e
class TestTTYDBrowserFlow:

    def test_terminal_load(self, ttyd_ready):
        with sync_playwright() as p:
            browser = p.chromium.launch()
            page = browser.new_page()
            page.goto("http://localhost:8081")
            assert page.is_visible("body")
            browser.close()