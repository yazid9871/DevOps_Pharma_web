#!/usr/bin/env python3
"""Normalize Allure suite labels to account > module > Robot suite."""

import json
import sys
from pathlib import Path


def main() -> None:
    if len(sys.argv) != 4:
        raise SystemExit("Usage: normalize_allure.py <allure-results> <account> <module>")

    results_dir = Path(sys.argv[1])
    account = sys.argv[2]
    module = sys.argv[3]

    for result_file in results_dir.glob("*-result.json"):
        data = json.loads(result_file.read_text(encoding="utf-8"))
        labels = data.setdefault("labels", [])
        original_suite = next(
            (label.get("value") for label in labels if label.get("name") == "suite"),
            None,
        )

        suite_label_names = {"parentSuite", "suite", "subSuite"}
        labels[:] = [label for label in labels if label.get("name") not in suite_label_names]
        labels.extend(
            [
                {"name": "parentSuite", "value": account},
                {"name": "suite", "value": module},
            ]
        )

        if original_suite and original_suite != module:
            labels.append({"name": "subSuite", "value": original_suite})

        result_file.write_text(json.dumps(data, ensure_ascii=False), encoding="utf-8")


if __name__ == "__main__":
    main()
