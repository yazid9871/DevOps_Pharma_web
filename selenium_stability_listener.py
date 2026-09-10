#!/usr/bin/env python3
"""Apply SeleniumLibrary stability settings without editing test suites."""

from robot.api import logger
from robot.libraries.BuiltIn import BuiltIn


class SeleniumStabilityListener:
    ROBOT_LISTENER_API_VERSION = 3

    def start_suite(self, data, result):
        self._run_keyword("Set Selenium Timeout", "30s")
        self._run_keyword("Set Selenium Implicit Wait", "2s")
        self._run_keyword("Set Selenium Speed", "0.1s")

    def end_keyword(self, data, result):
        keyword_name = getattr(data, "kwname", "") or getattr(data, "name", "")
        if keyword_name.lower() == "open browser":
            self._run_keyword("Set Window Size", "1920", "1080")

    def _run_keyword(self, name, *args):
        try:
            BuiltIn().run_keyword(name, *args)
        except Exception as exc:
            logger.debug(f"Skipped stability keyword {name}: {exc}")


ROBOT_LIBRARY_LISTENER = SeleniumStabilityListener()
