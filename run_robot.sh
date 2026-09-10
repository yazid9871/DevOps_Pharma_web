#!/usr/bin/env bash
set -e

test_path="${MODULE_PATH:-/tests/TestSuite/ADMIN_ACCOUNT/Achats}"
account_name="$(basename "$(dirname "$test_path")")"
module_name="$(basename "$test_path")"

if [ "$account_name" = "TestSuite" ]; then
  account_name="$module_name"
  module_name=""
fi

if [ "$account_name" = "FREEMIUM_ACCOUNT" ]; then
  account_name="FREEMIUM"
fi

set +e
xvfb-run -a --server-args="-screen 0 1920x1080x24" \
  robot \
  --listener allure_robotframework:/tests/results/allure-results \
  --listener /close_browsers_listener.py \
  --listener /selenium_stability_listener.py \
  -d /tests/results \
  "$test_path"
robot_exit_code=$?

cp /allure-categories.json /tests/results/allure-results/categories.json
python /normalize_allure.py /tests/results/allure-results "$account_name" "$module_name"
exit "$robot_exit_code"
