#!/usr/bin/env python3
"""Scaffold a neutral draft exercise using the next immutable serial."""

from __future__ import annotations

import argparse
import os

from common import CONTENT, ROOT, CheckError, fail, rel
from generate_registry import write_registry


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("serial", nargs="?", type=int)
    return parser.parse_args()


def draft(serial: int) -> str:
    return f'''// Draft scaffold. Replace every marker before publishing.
#import "../../lib/model.typ": exercise

#let item = exercise(
  serial: {serial},
  title: [À compléter],
  topics: ("logique-strategie",),
  difficulty: 1.0,
  statement_parts: (
    [Énoncé à compléter.],
  ),
  figure: none,
  source: (
    organization: "À compléter",
    competition: "À compléter",
    year: 2000,
    problem: 1,
    coefficient: 1,
    tracker_row: 1,
    attribution: [Source à compléter.],
  ),
  hints: (),
  extra: none,
  solution: none,
  status: "draft",
)
'''


def main() -> int:
    args = parse_args()
    existing = sorted((CONTENT / "exercises").glob("[0-9][0-9][0-9][0-9].typ"))
    existing_serials = {int(path.stem) for path in existing}
    next_serial = max(existing_serials, default=0) + 1
    serial = args.serial or next_serial
    if serial < 1:
        raise CheckError("serial must be positive")
    if serial in existing_serials:
        raise CheckError(f"serial {serial} already exists")
    path = CONTENT / "exercises" / f"{serial:04d}.typ"
    if ROOT not in path.resolve().parents:
        raise CheckError("refusing to create a file outside the repository")
    try:
        descriptor = os.open(path, os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o644)
    except FileExistsError as exc:
        raise CheckError(f"refusing to overwrite {rel(path)}") from exc
    with os.fdopen(descriptor, "w", encoding="utf-8") as handle:
        handle.write(draft(serial))
    write_registry()
    print(f"Created {rel(path)} with serial {serial} and draft status.")
    print("Updated the generated registry; teacher/catalog.typ shows its ID.")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except CheckError as exc:
        fail(str(exc))
