#!/usr/bin/env python3
"""Close Selenium browsers after each Robot suite in CI."""

from robot.libraries.BuiltIn import BuiltIn


class CloseBrowsersListener:
    ROBOT_LISTENER_API_VERSION = 3

    def end_suite(self, data, result):
        try:
            BuiltIn().run_keyword("Close All Browsers")
        except Exception:
            pass


ROBOT_LISTENER_API_VERSION = 3


def end_suite(data, result):
    CloseBrowsersListener().end_suite(data, result)
