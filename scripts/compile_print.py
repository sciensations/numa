#!/usr/bin/env python3
"""Compile teacher-only card batches and response selections."""

from __future__ import annotations

import argparse
import subprocess

from common import OUTPUT, ROOT, CheckError, fail, require_typst_version


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("kind", choices=("cards", "response"))
    parser.add_argument("selection", nargs="?", default="s03")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    typst = require_typst_version()
    OUTPUT.mkdir(parents=True, exist_ok=True)
    if args.kind == "cards":
        source = ROOT / "teacher" / "cards.typ"
        output = OUTPUT / "card-batch.pdf"
    else:
        source = ROOT / "teacher" / "responses" / f"{args.selection}.typ"
        output = OUTPUT / f"{args.selection}-responses.pdf"
    if not source.is_file():
        raise CheckError(f"missing teacher entrypoint: {source.relative_to(ROOT)}")
    command = [
        typst,
        "compile",
        "--root",
        str(ROOT),
        "--font-path",
        str(ROOT / "assets" / "fonts"),
        "--ignore-system-fonts",
        str(source),
        str(output),
    ]
    subprocess.run(command, cwd=ROOT, check=True)
    print(f"Built {output.relative_to(ROOT)}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except subprocess.CalledProcessError as exc:
        fail(f"Typst print build failed with exit status {exc.returncode}")
    except CheckError as exc:
        fail(str(exc))
