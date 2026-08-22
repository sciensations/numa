#!/usr/bin/env python3
"""Build the Typst bundle into dist/ without leaving a partial build behind."""

from __future__ import annotations

import argparse
import os
import shutil
import subprocess
import tempfile
from pathlib import Path

from common import BUNDLE, DIST, ROOT, CheckError, fail, require_typst_version
from generate_registry import check_registry


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path, default=DIST)
    parser.add_argument(
        "--profile",
        choices=("pilot", "full"),
        default=os.environ.get("NUMA_PROFILE", "pilot"),
    )
    return parser.parse_args()


def safe_replace_directory(staging: Path, output: Path) -> None:
    output = output.resolve()
    if output == ROOT or ROOT not in output.parents:
        raise CheckError(f"refusing unsafe output path: {output}")

    backup = output.with_name(f".numa-dist-backup-{os.getpid()}")
    if backup.exists():
        shutil.rmtree(backup)
    if output.exists():
        output.rename(backup)
    try:
        staging.rename(output)
    except BaseException:
        if backup.exists() and not output.exists():
            backup.rename(output)
        raise
    else:
        if backup.exists():
            shutil.rmtree(backup)


def main() -> int:
    args = parse_args()
    if not BUNDLE.is_file():
        raise CheckError("bundle.typ is missing")
    check_registry()

    typst = require_typst_version()
    staging = Path(tempfile.mkdtemp(prefix=".numa-dist-", dir=ROOT)).resolve()
    staging.rmdir()  # Typst's bundle output is expected to create this directory.

    command = [
        typst,
        "compile",
        "--features",
        "html,bundle",
        "--format",
        "bundle",
        "--font-path",
        str(ROOT / "assets" / "fonts"),
        "--ignore-system-fonts",
    ]
    command.extend(["--input", f"profile={args.profile}"])
    command.extend(["--root", str(ROOT), str(BUNDLE), str(staging)])

    try:
        subprocess.run(command, cwd=ROOT, check=True)
        if not (staging / "index.html").is_file():
            raise CheckError("Typst completed without producing index.html")
        safe_replace_directory(staging, args.output)
    finally:
        if staging.exists():
            shutil.rmtree(staging)

    print(f"Built exercise catalog into {args.output.resolve()}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except subprocess.CalledProcessError as exc:
        fail(f"Typst build failed with exit status {exc.returncode}")
    except CheckError as exc:
        fail(str(exc))
