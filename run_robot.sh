#!/usr/bin/env bash
set -e

test_path="${MODULE_PATH:-/tests/TestSuite/ADMIN_ACCOUNT/Achats}"
xvfb-run -a --server-args="-screen 0 1920x1080x24" \
  robot \
  --listener allure_robotframework:/tests/results/allure-results \
  -d /tests/results \
  "$test_path"
