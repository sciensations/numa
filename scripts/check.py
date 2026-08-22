#!/usr/bin/env python3
"""Run every read-only validation against source and an existing dist/."""

from __future__ import annotations

import argparse

from check_html import run as check_html
from check_pdfs import run as check_pdfs
from check_placeholders import run as check_placeholders
from check_qr import run as check_qr
from check_smoke import run as check_smoke
from common import CheckError, fail
from generate_registry import check_registry
from schema_counts import run as check_schema


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--profile", choices=("pilot", "full"), default="pilot")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    check_registry()
    check_schema(args.profile)
    check_html(args.profile)
    check_pdfs(args.profile)
    check_qr(args.profile)
    check_placeholders(args.profile)
    check_smoke()
    print(f"all checks: ok ({args.profile})")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except CheckError as exc:
        fail(str(exc))
