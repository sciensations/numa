#!/usr/bin/env python3
"""Compile focused HTML and print fixtures for experimental Typst regressions."""

from __future__ import annotations

import subprocess
import tempfile
from pathlib import Path

from check_html import References
from check_pdfs import A4_PORTRAIT, close_size, page_sizes
from common import ROOT, CheckError, fail, require_typst_version


def compile_fixture(typst: str, source: Path, output: Path, *options: str) -> None:
    command = [
        typst,
        "compile",
        *options,
        "--font-path",
        str(ROOT / "assets" / "fonts"),
        "--ignore-system-fonts",
        "--root",
        str(ROOT),
        str(source),
        str(output),
    ]
    result = subprocess.run(
        command, cwd=ROOT, check=False, capture_output=True, text=True
    )
    if result.returncode != 0:
        detail = (
            result.stderr.strip() or result.stdout.strip() or "no diagnostic output"
        )
        raise CheckError(f"Typst smoke compile failed for {source.name}: {detail}")


def run() -> None:
    typst = require_typst_version()
    fixtures = ROOT / "tests" / "fixtures"
    site_source = fixtures / "site-smoke.typ"
    print_source = fixtures / "print-smoke.typ"
    for source in (site_source, print_source):
        if not source.is_file():
            raise CheckError(f"missing smoke fixture: {source.relative_to(ROOT)}")

    with tempfile.TemporaryDirectory(prefix="numa-smoke-") as temporary:
        output = Path(temporary)
        site_html = output / "site.html"
        compile_fixture(
            typst,
            site_source,
            site_html,
            "--features",
            "html",
            "--format",
            "html",
        )
        parser = References()
        parser.feed(site_html.read_text(encoding="utf-8"))
        expected_tags = {"details": 3, "summary": 3, "ul": 1, "li": 2}
        tag_errors = [
            f"{tag}: expected {expected}, found {parser.tag_counts[tag]}"
            for tag, expected in expected_tags.items()
            if parser.tag_counts[tag] != expected
        ]
        if tag_errors:
            raise CheckError(
                "site smoke disclosure structure failed:\n- " + "\n- ".join(tag_errors)
            )

        for rows in (4, 8):
            pdf = output / f"responses-{rows}.pdf"
            compile_fixture(
                typst,
                print_source,
                pdf,
                "--input",
                "document=responses",
                "--input",
                f"rows={rows}",
            )
            sizes = page_sizes(pdf)
            if len(sizes) != 2 or not all(
                close_size(size, A4_PORTRAIT) for size in sizes
            ):
                found = ", ".join(
                    f"{width:.1f}x{height:.1f}pt" for width, height in sizes
                )
                raise CheckError(
                    f"response smoke rows={rows}: expected two A4 portrait pages; "
                    f"found {len(sizes)} page(s): {found}"
                )

    print(
        "Typst smoke fixtures: ok (3 disclosures; response rows 4 and 8 "
        "on an answer page plus a QR page)"
    )


def main() -> int:
    run()
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except CheckError as exc:
        fail(str(exc))
