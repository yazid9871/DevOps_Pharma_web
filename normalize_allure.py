#!/usr/bin/env python3
"""Normalize Allure identities and suite labels for merged account reports."""

import hashlib
import json
import sys
from pathlib import Path


def stable_id(*parts):
    value = "|".join(part for part in parts if part)
    return hashlib.sha256(value.encode("utf-8")).hexdigest()


def main() -> None:
    if len(sys.argv) != 4:
        raise SystemExit("Usage: normalize_allure.py <allure-results> <account> <module>")

    results_dir = Path(sys.argv[1])
    account = sys.argv[2]
    module = sys.argv[3]

    for result_file in results_dir.glob("*-result.json"):
        data = json.loads(result_file.read_text(encoding="utf-8"))
        original_full_name = data.get("fullName") or data.get("name") or ""
        original_history_id = data.get("historyId") or original_full_name
        data["fullName"] = ".".join(
            part for part in [account, module, original_full_name] if part
        )
        data["historyId"] = stable_id(account, module, original_history_id)
        data["testCaseId"] = stable_id(account, module, data.get("testCaseId") or original_full_name)

        labels = data.setdefault("labels", [])
        original_suite = next(
            (label.get("value") for label in labels if label.get("name") == "suite"),
            None,
        )
        full_name_parts = original_full_name.split(".")
        inferred_sub_suite = (
            full_name_parts[1]
            if len(full_name_parts) > 1 and full_name_parts[0] == module
            else None
        )
        sub_suite = (
            original_suite
            if original_suite and original_suite != module
            else inferred_sub_suite
        )

        suite_label_names = {"parentSuite", "suite", "subSuite"}
        labels[:] = [label for label in labels if label.get("name") not in suite_label_names]
        labels.extend(
            [
                {"name": "parentSuite", "value": account},
                {"name": "suite", "value": module},
            ]
        )

        if sub_suite:
            labels.append({"name": "subSuite", "value": sub_suite})

        result_file.write_text(json.dumps(data, ensure_ascii=False), encoding="utf-8")


if __name__ == "__main__":
    main()
