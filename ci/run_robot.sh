#!/usr/bin/env bash
set -e

module_paths="${MODULE_PATH:-/tests/TestSuite/ADMIN_ACCOUNT/Achats}"
IFS='|' read -ra TEST_PATHS <<< "$module_paths"
first_test_path="${TEST_PATHS[0]}"
relative_test_path="${first_test_path#*/TestSuite/}"
account_name="${relative_test_path%%/*}"
module_name="${relative_test_path#*/}"
module_name="${module_name%%/*}"

if [ "$account_name" = "$relative_test_path" ]; then
  module_name=""
fi

if [ "$account_name" = "TestSuite" ]; then
  account_name="$(basename "$first_test_path")"
  module_name=""
fi

if [ "$account_name" = "FREEMIUM_ACCOUNT" ]; then
  account_name="FREEMIUM"
fi

set +e
robot_exit_code=0
for test_path in "${TEST_PATHS[@]}"; do
  xvfb-run -a --server-args="-screen 0 1920x3000x24" \
    robot \
    --listener allure_robotframework:/tests/results/allure-results \
    --listener /close_browsers_listener.py \
    --listener /selenium_stability_listener.py \
    -d /tests/results \
    "$test_path" || robot_exit_code=$?
done

cp /allure-categories.json /tests/results/allure-results/categories.json
python /normalize_allure.py /tests/results/allure-results "$account_name" "$module_name"
exit "$robot_exit_code"
