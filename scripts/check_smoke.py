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


def expect_compile_failure(
    typst: str, source: Path, output: Path, expected: str
) -> None:
    command = [
        typst,
        "compile",
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
    diagnostic = result.stderr or result.stdout
    if result.returncode == 0 or expected not in diagnostic:
        raise CheckError(
            f"{source.name}: expected compile failure containing {expected!r}"
        )


def run() -> None:
    typst = require_typst_version()
    fixtures = ROOT / "tests" / "fixtures"
    site_source = fixtures / "site-smoke.typ"
    print_source = fixtures / "print-smoke.typ"
    collision_source = fixtures / "emoji-collision.typ"
    for source in (site_source, print_source, collision_source):
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
            if len(sizes) != 1 or not close_size(sizes[0], A4_PORTRAIT):
                found = ", ".join(
                    f"{width:.1f}x{height:.1f}pt" for width, height in sizes
                )
                raise CheckError(
                    f"response smoke rows={rows}: expected one A4 portrait page; "
                    f"found {len(sizes)} page(s): {found}"
                )

        expect_compile_failure(
            typst,
            collision_source,
            output / "emoji-collision.pdf",
            "emoji signature collision",
        )

    print(
        "Typst smoke fixtures: ok (emoji collision rejected; 3 disclosures; "
        "response rows 4 and 8 on one A4 page)"
    )


def main() -> int:
    run()
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except CheckError as exc:
        fail(str(exc))
