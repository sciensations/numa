#!/usr/bin/env python3
"""Shared, dependency-free helpers for Numa developer tooling."""

from __future__ import annotations

import dataclasses
import json
import os
import re
import shutil
import subprocess
import sys
from collections.abc import Iterable
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CONTENT = ROOT / "content"
DIST = ROOT / "dist"
OUTPUT = ROOT / "output" / "pdf"
BUNDLE = ROOT / "bundle.typ"
TYPST_VERSION = "0.15.1"
SITE_URL = "https://lcnbr.github.io/numa"

REQUIRED_EXERCISE_FIELDS = (
    "serial",
    "title",
    "statement_parts",
    "topics",
    "difficulty",
    "figure",
    "source",
    "hints",
    "extra",
    "solution",
    "status",
)
VALID_STATUSES = {"draft", "published"}
GOLDEN_IDS = {
    1: "3009ac",
    2: "e09805",
    3: "9df8b0",
    4: "402f01",
    5: "25ecd7",
    6: "bb6cb4",
    7: "d72deb",
    8: "b26606",
    9: "0e41af",
    10: "4b5936",
    11: "bf18c0",
    12: "765d0c",
}
PILOT_SELECTION_IDS = {"s01", "s03"}


class CheckError(RuntimeError):
    """A user-facing validation failure."""


@dataclasses.dataclass(frozen=True)
class Exercise:
    path: Path
    serial: int
    id: str
    status: str
    topics: tuple[str, ...]
    difficulty: float
    selections: tuple[str, ...]
    text: str


@dataclasses.dataclass(frozen=True)
class Selection:
    path: Path
    id: str
    serials: tuple[int, ...]
    text: str


def rel(path: Path) -> str:
    try:
        return path.resolve().relative_to(ROOT).as_posix()
    except ValueError:
        return str(path)


def read_text(path: Path) -> str:
    try:
        return path.read_text(encoding="utf-8")
    except FileNotFoundError as exc:
        raise CheckError(f"missing required file: {rel(path)}") from exc


def extract_string(text: str, field: str) -> str | None:
    match = re.search(rf'(?m)^\s*{re.escape(field)}\s*:\s*"([^"]*)"', text)
    return match.group(1) if match else None


def extract_int(text: str, field: str) -> int | None:
    match = re.search(rf"(?m)^\s*{re.escape(field)}\s*:\s*(\d+)\b", text)
    return int(match.group(1)) if match else None


def extract_float(text: str, field: str) -> float | None:
    match = re.search(rf"(?m)^\s*{re.escape(field)}\s*:\s*(\d+(?:\.\d+)?)\b", text)
    return float(match.group(1)) if match else None


def has_field(text: str, field: str) -> bool:
    return re.search(rf"(?m)^\s*{re.escape(field)}\s*:", text) is not None


def _catalog_metadata() -> dict[int, dict[str, object]]:
    typst = require_typst_version()
    command = [
        typst,
        "query",
        "--root",
        str(ROOT),
        "--font-path",
        str(ROOT / "assets" / "fonts"),
        "--ignore-system-fonts",
        str(CONTENT / "catalog.typ"),
        "<catalog-data>",
        "--field",
        "value",
        "--one",
    ]
    result = subprocess.run(
        command, cwd=ROOT, capture_output=True, text=True, check=False
    )
    if result.returncode != 0:
        detail = result.stderr.strip() or result.stdout.strip()
        raise CheckError(f"cannot query Typst catalog metadata: {detail}")
    try:
        data = json.loads(result.stdout)
    except json.JSONDecodeError as exc:
        raise CheckError("Typst catalog metadata is not valid JSON") from exc
    if not isinstance(data, list):
        raise CheckError("Typst catalog metadata must be an array")
    return {int(item["serial"]): item for item in data}


def load_exercises() -> list[Exercise]:
    directory = CONTENT / "exercises"
    if not directory.is_dir():
        raise CheckError(f"missing exercise directory: {rel(directory)}")
    metadata = _catalog_metadata()
    exercises: list[Exercise] = []
    for path in sorted(directory.glob("[0-9][0-9][0-9][0-9].typ")):
        text = read_text(path)
        serial = extract_int(text, "serial")
        status = extract_string(text, "status")
        if serial is None or status is None:
            raise CheckError(f"{rel(path)}: cannot parse serial or status")
        item = metadata.get(serial)
        if item is None:
            raise CheckError(f"{rel(path)}: serial {serial} is not registered in catalog")
        exercises.append(
            Exercise(
                path=path,
                serial=serial,
                id=str(item["id"]),
                status=status,
                topics=tuple(str(value) for value in item["topics"]),
                difficulty=float(item["difficulty"]),
                selections=tuple(str(value) for value in item["selections"]),
                text=text,
            )
        )
    extra = sorted(set(metadata) - {exercise.serial for exercise in exercises})
    if extra:
        raise CheckError(f"catalog metadata has no matching exercise files: {extra}")
    return exercises


def load_selections() -> list[Selection]:
    directory = CONTENT / "selections"
    if not directory.is_dir():
        raise CheckError(f"missing selection directory: {rel(directory)}")
    selections: list[Selection] = []
    for path in sorted(directory.glob("*.typ")):
        text = read_text(path)
        identifier = extract_string(text, "id")
        if identifier is None:
            raise CheckError(f"{rel(path)}: cannot parse selection id")
        serials_match = re.search(r"#let\s+serials\s*=\s*\(([^)]*)\)", text)
        if serials_match is None:
            raise CheckError(f"{rel(path)}: cannot parse serials tuple")
        serials = tuple(int(value) for value in re.findall(r"\d+", serials_match.group(1)))
        selections.append(Selection(path=path, id=identifier, serials=serials, text=text))
    return selections


def selected_selections(profile: str, selections: Iterable[Selection]) -> list[Selection]:
    selections = list(selections)
    if profile == "pilot":
        selected = [selection for selection in selections if selection.id in PILOT_SELECTION_IDS]
        missing = PILOT_SELECTION_IDS - {selection.id for selection in selected}
        if missing:
            raise CheckError(f"pilot profile requires selections {sorted(missing)}")
        return selected
    if profile == "full":
        return selections
    raise CheckError(f"unknown validation profile {profile!r}; use pilot or full")


def selected_exercises(profile: str, exercises: Iterable[Exercise]) -> list[Exercise]:
    exercises = list(exercises)
    if profile == "pilot":
        return [
            exercise
            for exercise in exercises
            if PILOT_SELECTION_IDS.intersection(exercise.selections)
        ]
    if profile == "full":
        return exercises
    raise CheckError(f"unknown validation profile {profile!r}; use pilot or full")


def _typst_version(executable: str) -> tuple[str | None, str]:
    result = subprocess.run([executable, "--version"], check=False, capture_output=True, text=True)
    output = (result.stdout or result.stderr).strip()
    match = re.search(r"\btypst\s+(\d+\.\d+\.\d+)\b", output)
    return (match.group(1) if result.returncode == 0 and match else None), output


def require_typst_version() -> str:
    explicit = os.environ.get("TYPST")
    local_name = "typst.exe" if os.name == "nt" else "typst"
    local = ROOT / ".tools" / f"typst-{TYPST_VERSION}" / local_name
    candidates: list[str] = []
    if explicit:
        candidates.append(shutil.which(explicit) or explicit)
    else:
        system = shutil.which("typst")
        if system:
            candidates.append(system)
        if local.is_file():
            candidates.append(str(local))
    observations: list[str] = []
    for executable in dict.fromkeys(candidates):
        try:
            version, output = _typst_version(executable)
        except OSError as exc:
            observations.append(f"{executable}: {exc}")
            continue
        if version == TYPST_VERSION:
            return executable
        observations.append(f"{executable}: {version or output or 'unknown version'}")
    detail = "; ".join(observations) if observations else "no Typst executable found"
    raise CheckError(
        f"Typst {TYPST_VERSION} is required ({detail}). "
        "Run `python3 scripts/install_typst.py` or set TYPST to an exact-version binary."
    )


def fail(message: str) -> None:
    print(f"error: {message}", file=sys.stderr)
    raise SystemExit(1)
