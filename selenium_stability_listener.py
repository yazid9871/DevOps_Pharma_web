#!/usr/bin/env python3
"""Apply SeleniumLibrary stability settings without editing test suites."""

from robot.api import logger
from robot.libraries.BuiltIn import BuiltIn

ROBOT_LISTENER_API_VERSION = 3


def start_suite(data, result):
    _run_keyword("Set Selenium Timeout", "30s")
    _run_keyword("Set Selenium Implicit Wait", "2s")
    _run_keyword("Set Selenium Speed", "0.1s")


def end_keyword(data, result):
    keyword_name = getattr(data, "kwname", "") or getattr(data, "name", "")
    if keyword_name.lower().endswith("open browser"):
        _run_keyword("Set Window Size", "1920", "3000")


def _run_keyword(name, *args):
    try:
        BuiltIn().run_keyword(name, *args)
    except Exception as exc:
        logger.debug(f"Skipped stability keyword {name}: {exc}")
