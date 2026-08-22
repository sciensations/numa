#!/usr/bin/env python3
"""Watch the Typst bundle and serve dist/ with Python's static HTTP server."""

from __future__ import annotations

import argparse
import functools
import http.server
import os
import subprocess

from common import BUNDLE, DIST, ROOT, CheckError, fail, require_typst_version
from generate_registry import check_registry


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--host", default="127.0.0.1")
    parser.add_argument("--port", type=int, default=8000)
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    profile = os.environ.get("NUMA_PROFILE", "pilot")
    if profile not in ("pilot", "full"):
        raise CheckError("NUMA_PROFILE must be pilot or full")
    if not (1 <= args.port <= 65535):
        raise CheckError("port must be between 1 and 65535")
    if not BUNDLE.is_file():
        raise CheckError("bundle.typ is missing")
    check_registry()
    DIST.mkdir(parents=True, exist_ok=True)

    typst = require_typst_version()
    command = [
        typst,
        "watch",
        "--features",
        "html,bundle",
        "--format",
        "bundle",
        "--font-path",
        str(ROOT / "assets" / "fonts"),
        "--ignore-system-fonts",
        "--input",
        f"profile={profile}",
        "--no-serve",
        "--no-reload",
        "--root",
        str(ROOT),
        str(BUNDLE),
        str(DIST),
    ]
    watcher = subprocess.Popen(command, cwd=ROOT)
    handler = functools.partial(http.server.SimpleHTTPRequestHandler, directory=DIST)
    server = http.server.ThreadingHTTPServer((args.host, args.port), handler)
    print(f"Preview: http://{args.host}:{args.port}/")
    print("Typst is watching imported source files; press Ctrl-C to stop.")
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nStopping preview.")
    finally:
        server.server_close()
        watcher.terminate()
        try:
            watcher.wait(timeout=5)
        except subprocess.TimeoutExpired:
            watcher.kill()
            watcher.wait()
    return 0 if watcher.returncode in (0, -15) else watcher.returncode


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except CheckError as exc:
        fail(str(exc))
