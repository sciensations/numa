#!/usr/bin/env python3
"""Validate the neutral exercise catalog, selections, and pilot/full counts."""

from __future__ import annotations

import argparse
import re
from collections import Counter

from common import (
    CONTENT,
    GOLDEN_IDS,
    REQUIRED_EXERCISE_FIELDS,
    ROOT,
    VALID_STATUSES,
    CheckError,
    Exercise,
    Selection,
    fail,
    has_field,
    load_exercises,
    load_selections,
    read_text,
    rel,
    selected_exercises,
    selected_selections,
)

PROFILES = {"pilot": (2, 12, 12), "full": (14, 83, 83)}
ID_RE = re.compile(r"[0-9a-f]{6}")
SELECTION_RE = re.compile(r"[a-z][a-z0-9-]*")
DATE_RE = re.compile(r"(?:\d{4}-\d{2}-\d{2}|\d{2}\.\d{2}\.\d{4})")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--profile", choices=sorted(PROFILES), default="pilot")
    return parser.parse_args()


def top_level_content_blocks(body: str) -> int:
    count = square_depth = paren_depth = 0
    in_string = escaped = False
    index = 0
    while index < len(body):
        char = body[index]
        if in_string:
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == '"':
                in_string = False
            index += 1
            continue
        if char == '"':
            in_string = True
        elif body.startswith("//", index):
            newline = body.find("\n", index + 2)
            index = len(body) if newline == -1 else newline
            continue
        elif char == "(":
            paren_depth += 1
        elif char == ")" and paren_depth:
            paren_depth -= 1
        elif char == "[":
            if square_depth == 0 and paren_depth == 0:
                count += 1
            square_depth += 1
        elif char == "]" and square_depth:
            square_depth -= 1
        index += 1
    return count


def validate_exercises(exercises: list[Exercise]) -> list[str]:
    errors: list[str] = []
    serials = Counter(item.serial for item in exercises)
    ids = Counter(item.id for item in exercises)
    for serial, count in serials.items():
        if count > 1:
            errors.append(f"duplicate exercise serial {serial}")
    for identifier, count in ids.items():
        if count > 1:
            errors.append(f"duplicate exercise id {identifier!r}")
    for item in exercises:
        location = rel(item.path)
        missing = [field for field in REQUIRED_EXERCISE_FIELDS if not has_field(item.text, field)]
        if missing:
            errors.append(f"{location}: missing fields {', '.join(missing)}")
        if item.path.stem != f"{item.serial:04d}":
            errors.append(f"{location}: filename must be {item.serial:04d}.typ")
        if ID_RE.fullmatch(item.id) is None:
            errors.append(f"{location}: invalid derived id {item.id!r}")
        if item.status not in VALID_STATUSES:
            errors.append(f"{location}: status must be draft or published")
        if not 1 <= item.difficulty <= 5 or item.difficulty * 4 != round(item.difficulty * 4):
            errors.append(f"{location}: difficulty must be 1–5 in quarter increments")
        if not item.topics:
            errors.append(f"{location}: at least one topic is required")
        parts_match = re.search(
            r"statement_parts\s*:\s*\((.*?)\),\s*(?:topics|figure)\s*:",
            item.text,
            re.DOTALL,
        )
        if parts_match is None:
            errors.append(f"{location}: cannot parse statement_parts tuple")
        else:
            count = top_level_content_blocks(parts_match.group(1))
            if count not in (1, 2):
                errors.append(f"{location}: statement_parts must contain one or two blocks; found {count}")
        for field in (
            "organization",
            "competition",
            "year",
            "problem",
            "coefficient",
            "tracker_row",
            "attribution",
        ):
            if not has_field(item.text, field):
                errors.append(f"{location}: source is missing {field}")
        figure_match = re.search(r"figure\s*:\s*(.*?),\s*source\s*:", item.text, re.DOTALL)
        if figure_match and not re.fullmatch(r"\s*none\s*", figure_match.group(1)):
            figure = figure_match.group(1)
            path_match = re.search(r'path\s*:\s*"([^"]+)"', figure)
            alt_match = re.search(r'alt\s*:\s*"([^"]+)"', figure)
            if path_match is None or alt_match is None:
                errors.append(f"{location}: figure requires path and alt")
            elif not (ROOT / path_match.group(1)).is_file():
                errors.append(f"{location}: missing figure asset {path_match.group(1)}")

    for serial, expected in GOLDEN_IDS.items():
        matches = [item.id for item in exercises if item.serial == serial]
        if matches and matches != [expected]:
            errors.append(f"serial {serial} changed id: expected {expected}, found {matches[0]}")
    return errors


def validate_selections(selections: list[Selection], exercises: list[Exercise]) -> list[str]:
    errors: list[str] = []
    ids = {item.id for item in exercises}
    serials = {item.serial for item in exercises}
    selection_ids = Counter(item.id for item in selections)
    for identifier, count in selection_ids.items():
        if count > 1:
            errors.append(f"duplicate selection {identifier!r}")
    for selection in selections:
        location = rel(selection.path)
        if SELECTION_RE.fullmatch(selection.id) is None:
            errors.append(f"{location}: invalid selection id")
        if selection.path.stem != selection.id:
            errors.append(f"{location}: filename must be {selection.id}.typ")
        for field in ("id", "title", "date", "year", "purpose", "listed", "exercises"):
            if not has_field(selection.text, field):
                errors.append(f"{location}: missing field {field}")
        date_match = re.search(r'(?m)^\s*date\s*:\s*"([^"]+)"', selection.text)
        if date_match and DATE_RE.fullmatch(date_match.group(1)) is None:
            errors.append(f"{location}: date must use YYYY-MM-DD or DD.MM.YYYY")
        if '#import "../exercise-registry.typ": exercise-at' not in selection.text:
            errors.append(f"{location}: must import exercise-at from the generated registry")
        unknown = sorted(set(selection.serials) - serials)
        if unknown:
            errors.append(f"{location}: references unknown exercise serials {unknown}")
        if len(set(selection.serials)) != len(selection.serials):
            errors.append(f"{location}: repeats an exercise serial")
        if 'purpose: "response"' in selection.text and not 4 <= len(selection.serials) <= 8:
            errors.append(f"{location}: response selection must import four to eight exercises")

    catalog_text = read_text(CONTENT / "catalog.typ")
    if '#import "exercise-registry.typ": exercises' not in catalog_text:
        errors.append("content/catalog.typ: must import the generated exercise registry")
    for selection in selections:
        if f'selections/{selection.id}.typ' not in catalog_text:
            errors.append(f"content/catalog.typ: selection {selection.id} is not imported")
    if not ids:
        errors.append("catalog has no exercise IDs")
    return errors


def run(profile: str, quiet: bool = False) -> tuple[list[Selection], list[Exercise]]:
    exercises = load_exercises()
    selections = load_selections()
    errors = validate_exercises(exercises) + validate_selections(selections, exercises)
    chosen_selections = selected_selections(profile, selections)
    chosen_exercises = selected_exercises(profile, exercises)
    published = [item for item in chosen_exercises if item.status == "published"]
    expected = PROFILES[profile]
    actual = (len(chosen_selections), len(chosen_exercises), len(published))
    if actual != expected:
        errors.append(f"{profile} counts must be selections/exercises/published {expected}; found {actual}")
    if errors:
        raise CheckError("schema/count validation failed:\n- " + "\n- ".join(errors))
    if not quiet:
        print(
            f"schema/counts: ok ({profile}: {actual[0]} selection, "
            f"{actual[1]} exercises, {actual[2]} published)"
        )
    return chosen_selections, chosen_exercises


def main() -> int:
    args = parse_args()
    run(args.profile)
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except CheckError as exc:
        fail(str(exc))
