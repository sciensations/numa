#!/usr/bin/env python3
"""Download the pinned official Typst binary as an explicit local fallback."""

from __future__ import annotations

import argparse
import io
import os
import platform
import subprocess
import tarfile
import tempfile
import urllib.error
import urllib.request
import zipfile
from pathlib import Path

from common import ROOT, TYPST_VERSION, CheckError, fail

TARGETS = {
    ("Darwin", "arm64"): ("typst-aarch64-apple-darwin.tar.xz", "typst"),
    ("Darwin", "x86_64"): ("typst-x86_64-apple-darwin.tar.xz", "typst"),
    ("Linux", "aarch64"): ("typst-aarch64-unknown-linux-musl.tar.xz", "typst"),
    ("Linux", "x86_64"): ("typst-x86_64-unknown-linux-musl.tar.xz", "typst"),
    ("Windows", "AMD64"): ("typst-x86_64-pc-windows-msvc.zip", "typst.exe"),
}


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--destination",
        type=Path,
        default=ROOT / ".tools" / f"typst-{TYPST_VERSION}",
    )
    return parser.parse_args()


def binary_from_archive(data: bytes, archive: str, binary_name: str) -> bytes:
    if archive.endswith(".zip"):
        with zipfile.ZipFile(io.BytesIO(data)) as bundle:
            matches = [
                name for name in bundle.namelist() if Path(name).name == binary_name
            ]
            if len(matches) != 1:
                raise CheckError(
                    f"expected one {binary_name} in {archive}, found {len(matches)}"
                )
            return bundle.read(matches[0])
    with tarfile.open(fileobj=io.BytesIO(data), mode="r:xz") as bundle:
        matches = [
            member
            for member in bundle.getmembers()
            if member.isfile() and Path(member.name).name == binary_name
        ]
        if len(matches) != 1:
            raise CheckError(
                f"expected one {binary_name} in {archive}, found {len(matches)}"
            )
        handle = bundle.extractfile(matches[0])
        if handle is None:
            raise CheckError(f"could not read {binary_name} from {archive}")
        return handle.read()


def main() -> int:
    args = parse_args()
    target = TARGETS.get((platform.system(), platform.machine()))
    if target is None:
        raise CheckError(
            f"unsupported platform {platform.system()} {platform.machine()}; "
            "install Typst 0.15.1 manually and set TYPST"
        )
    archive, binary_name = target
    url = f"https://github.com/typst/typst/releases/download/v{TYPST_VERSION}/{archive}"
    destination = args.destination.resolve()
    destination.mkdir(parents=True, exist_ok=True)
    output = destination / binary_name

    print(f"Downloading Typst {TYPST_VERSION} from {url}")
    request = urllib.request.Request(url, headers={"User-Agent": "numa-bootstrap/1"})
    with urllib.request.urlopen(request, timeout=60) as response:
        data = response.read()
    binary = binary_from_archive(data, archive, binary_name)

    descriptor, temporary_name = tempfile.mkstemp(prefix=".typst-", dir=destination)
    temporary = Path(temporary_name)
    try:
        with os.fdopen(descriptor, "wb") as handle:
            handle.write(binary)
        temporary.chmod(0o755)
        temporary.replace(output)
    finally:
        if temporary.exists():
            temporary.unlink()

    result = subprocess.run(
        [str(output), "--version"], check=False, capture_output=True, text=True
    )
    version = (result.stdout or result.stderr).strip()
    if result.returncode != 0 or not version.startswith(f"typst {TYPST_VERSION}"):
        output.unlink(missing_ok=True)
        raise CheckError(f"downloaded binary failed version check: {version!r}")
    print(f"Installed {version} at {output}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (CheckError, OSError, urllib.error.URLError) as exc:
        fail(str(exc))
