#!/usr/bin/env python3
"""Validate teacher print PDF page counts and A4 orientation."""

from __future__ import annotations

import argparse
import re
from pathlib import Path

from common import OUTPUT, CheckError, fail
from schema_counts import run as check_schema

OBJECT_RE = re.compile(rb"\b\d+\s+\d+\s+obj\b(.*?)\bendobj\b", re.DOTALL)
PAGE_TYPE_RE = re.compile(rb"/Type\s*/Page(?!s)\b")
MEDIABOX_RE = re.compile(
    rb"/MediaBox\s*\[\s*([-+\d.]+)\s+([-+\d.]+)\s+([-+\d.]+)\s+([-+\d.]+)\s*\]"
)
A4_PORTRAIT = (595.276, 841.890)
A4_LANDSCAPE = (841.890, 595.276)
POINT_TOLERANCE = 1.0


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--profile", choices=("pilot", "full"), default="pilot")
    parser.add_argument("--output", type=Path, default=OUTPUT)
    return parser.parse_args()


def page_sizes(path: Path) -> list[tuple[float, float]]:
    data = path.read_bytes()
    sizes: list[tuple[float, float]] = []
    for body in OBJECT_RE.findall(data):
        if PAGE_TYPE_RE.search(body) is None:
            continue
        match = MEDIABOX_RE.search(body)
        if match is None:
            raise CheckError(f"{path}: page has no explicit MediaBox")
        x0, y0, x1, y1 = (float(value) for value in match.groups())
        sizes.append((abs(x1 - x0), abs(y1 - y0)))
    if not sizes:
        raise CheckError(f"{path}: no uncompressed PDF page objects found")
    return sizes


def close_size(actual: tuple[float, float], expected: tuple[float, float]) -> bool:
    return all(abs(left - right) <= POINT_TOLERANCE for left, right in zip(actual, expected))


def run(profile: str, output: Path = OUTPUT) -> None:
    selections, _exercises = check_schema(profile, quiet=True)
    files: list[tuple[Path, int, tuple[float, float]]] = []
    if profile == "pilot":
        files.append((output / "card-batch.pdf", 4, A4_LANDSCAPE))
    for selection in selections:
        files.append((output / f"{selection.id}-responses.pdf", 1, A4_PORTRAIT))

    errors: list[str] = []
    checked_pages = 0
    for path, expected_pages, expected_size in files:
        if not path.is_file():
            errors.append(f"missing {path}")
            continue
        try:
            sizes = page_sizes(path)
        except CheckError as exc:
            errors.append(str(exc))
            continue
        checked_pages += len(sizes)
        if len(sizes) != expected_pages:
            errors.append(f"{path}: expected {expected_pages} pages, found {len(sizes)}")
        for number, size in enumerate(sizes, start=1):
            if not close_size(size, expected_size):
                errors.append(
                    f"{path} page {number}: expected A4 {expected_size[0]:.1f}x{expected_size[1]:.1f}pt, "
                    f"found {size[0]:.1f}x{size[1]:.1f}pt"
                )
    if errors:
        raise CheckError("PDF size/count validation failed:\n- " + "\n- ".join(errors))
    print(f"pdf sizes/counts: ok ({checked_pages} pages across {len(files)} teacher files)")


def main() -> int:
    args = parse_args()
    run(args.profile, args.output)
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except CheckError as exc:
        fail(str(exc))
