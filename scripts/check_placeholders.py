#!/usr/bin/env python3
"""Count intentional content gaps and reject raw markers in published material."""

from __future__ import annotations

import argparse
import re
from collections import Counter
from pathlib import Path

from common import DIST, ROOT, CheckError, Exercise, fail
from schema_counts import run as check_schema

RAW_MARKER_RE = re.compile(
    r"\b(?:TODO|TBD|FIXME|CHANGEME)\b|lorem\s+ipsum|example\.(?:com|invalid)|\bProblem\s+[0-9]+\b",
    re.IGNORECASE,
)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--profile", choices=("pilot", "full"), default="pilot")
    parser.add_argument("--dist", type=Path, default=DIST)
    parser.add_argument("--max-solution-none", type=int)
    parser.add_argument("--max-hints-empty", type=int)
    return parser.parse_args()


def has_none(exercise: Exercise, field: str) -> bool:
    return re.search(rf"(?m)^\s*{field}\s*:\s*none\s*,", exercise.text) is not None


def has_empty_tuple(exercise: Exercise, field: str) -> bool:
    return re.search(rf"(?m)^\s*{field}\s*:\s*\(\s*\)\s*,", exercise.text) is not None


def run(
    profile: str,
    dist: Path = DIST,
    max_solution_none: int | None = None,
    max_hints_empty: int | None = None,
) -> Counter[str]:
    _, exercises = check_schema(profile, quiet=True)
    published = [exercise for exercise in exercises if exercise.status == "published"]
    counts: Counter[str] = Counter()
    raw_locations: list[str] = []
    for exercise in published:
        counts["solution_none"] += has_none(exercise, "solution")
        counts["hints_empty"] += has_empty_tuple(exercise, "hints")
        counts["extra_none"] += has_none(exercise, "extra")
        counts["figure_none"] += has_none(exercise, "figure")
        if RAW_MARKER_RE.search(exercise.text):
            raw_locations.append(exercise.path.relative_to(ROOT).as_posix())

    for path in sorted(dist.rglob("*.html")):
        if RAW_MARKER_RE.search(path.read_text(encoding="utf-8")):
            raw_locations.append(path.relative_to(ROOT).as_posix())
    counts["raw_markers"] = len(raw_locations)

    errors: list[str] = []
    if raw_locations:
        errors.append("raw placeholder text in " + ", ".join(raw_locations))
    if max_solution_none is not None and counts["solution_none"] > max_solution_none:
        errors.append(
            f"solution_none={counts['solution_none']} exceeds {max_solution_none}"
        )
    if max_hints_empty is not None and counts["hints_empty"] > max_hints_empty:
        errors.append(f"hints_empty={counts['hints_empty']} exceeds {max_hints_empty}")
    if errors:
        raise CheckError("placeholder validation failed:\n- " + "\n- ".join(errors))

    print(
        "placeholder counts: "
        + ", ".join(
            f"{key}={counts[key]}"
            for key in (
                "solution_none",
                "hints_empty",
                "extra_none",
                "figure_none",
                "raw_markers",
            )
        )
    )
    return counts


def main() -> int:
    args = parse_args()
    run(
        args.profile,
        args.dist,
        max_solution_none=args.max_solution_none,
        max_hints_empty=args.max_hints_empty,
    )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except CheckError as exc:
        fail(str(exc))
