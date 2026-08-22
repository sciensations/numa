#!/usr/bin/env python3
"""Decode response-sheet QR codes and verify their exact exercise URLs."""

from __future__ import annotations

import argparse
from collections import Counter
from pathlib import Path

from common import OUTPUT, SITE_URL, CheckError, fail, rel
from schema_counts import run as check_schema


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--profile", choices=("pilot", "full"), default="pilot")
    parser.add_argument("--output", type=Path, default=OUTPUT)
    parser.add_argument("--dpi", type=int, default=300)
    return parser.parse_args()


def load_qa_dependencies():
    try:
        import pypdfium2
        import zxingcpp
    except ImportError as exc:
        raise CheckError(
            "QR validation dependencies are missing; install them with "
            "`python3 -m pip install -r scripts/requirements-qa.txt`"
        ) from exc
    return pypdfium2, zxingcpp


def expected_urls(profile: str) -> dict[str, list[str]]:
    selections, exercises = check_schema(profile, quiet=True)
    by_serial = {item.serial: item for item in exercises}
    expected: dict[str, list[str]] = {}
    for selection in selections:
        expected[selection.id] = [
            f"{SITE_URL}/e/{by_serial[serial].id}.html" for serial in selection.serials
        ]
    return expected


def decode_pdf(pdf: Path, dpi: int, pypdfium2, zxingcpp) -> list[str]:
    document = pypdfium2.PdfDocument(pdf)
    decoded: list[str] = []
    try:
        for page in document:
            bitmap = page.render(scale=dpi / 72)
            try:
                image = bitmap.to_pil()
                try:
                    barcodes = zxingcpp.read_barcodes(image, formats=zxingcpp.BarcodeFormat.QRCode)
                finally:
                    image.close()
            finally:
                bitmap.close()
                page.close()
            decoded.extend(barcode.text for barcode in barcodes)
    finally:
        document.close()
    return decoded


def run(profile: str, output: Path = OUTPUT, dpi: int = 300) -> None:
    if not 72 <= dpi <= 1200:
        raise CheckError("QR render dpi must be between 72 and 1200")
    pypdfium2, zxingcpp = load_qa_dependencies()
    urls = expected_urls(profile)
    count = 0
    for selection_id, expected in urls.items():
        pdf = output / f"{selection_id}-responses.pdf"
        if not pdf.is_file():
            raise CheckError(f"missing response sheet: {rel(pdf)}")
        decoded = decode_pdf(pdf, dpi, pypdfium2, zxingcpp)
        if Counter(decoded) != Counter(expected):
            raise CheckError(f"{rel(pdf)} decoded QR mismatch: expected {expected}, found {decoded}")
        count += len(decoded)
    print(f"qr payloads: ok ({count} codes across {len(urls)} response sheets)")


def main() -> int:
    args = parse_args()
    run(args.profile, args.output, args.dpi)
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except CheckError as exc:
        fail(str(exc))
