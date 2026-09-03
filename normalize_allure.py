#!/usr/bin/env python3
"""Add the account as the top-level Allure suite label."""

import json
import sys
from pathlib import Path


def main() -> None:
    if len(sys.argv) != 3:
        raise SystemExit("Usage: normalize_allure.py <allure-results> <account>")

    results_dir = Path(sys.argv[1])
    account = sys.argv[2]

    for result_file in results_dir.glob("*-result.json"):
        data = json.loads(result_file.read_text(encoding="utf-8"))
        labels = data.setdefault("labels", [])
        labels[:] = [label for label in labels if label.get("name") != "parentSuite"]
        labels.append({"name": "parentSuite", "value": account})
        result_file.write_text(json.dumps(data, ensure_ascii=False), encoding="utf-8")


if __name__ == "__main__":
    main()
