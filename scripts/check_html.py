#!/usr/bin/env python3
"""Check generated HTML links, fragments, and local assets without network access."""

from __future__ import annotations

import argparse
import html.parser
import re
from collections import Counter
from pathlib import Path
from urllib.parse import unquote, urlsplit

from common import DIST, ROOT, SITE_URL, CheckError, fail, read_text, rel
from schema_counts import run as check_schema


class References(html.parser.HTMLParser):
    def __init__(self) -> None:
        super().__init__(convert_charrefs=True)
        self.urls: list[tuple[str, str]] = []
        self.ids: set[str] = set()
        self.html_langs: list[str | None] = []
        self.titles: list[str] = []
        self.metas: list[dict[str, str | None]] = []
        self.stylesheets: list[str] = []
        self.tag_counts: Counter[str] = Counter()
        self.accessible_numa_logos = 0
        self._title_chunks: list[str] | None = None

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        attributes = dict(attrs)
        self.tag_counts[tag] += 1
        classes = str(attributes.get("class", "")).split()
        if (
            "site-logo" in classes
            and attributes.get("role") == "img"
            and attributes.get("aria-label") == "Numa"
        ):
            self.accessible_numa_logos += 1
        if tag == "html":
            self.html_langs.append(attributes.get("lang"))
        if tag == "title":
            self._title_chunks = []
        if tag == "meta":
            self.metas.append(attributes)
        identifier = attributes.get("id")
        if identifier:
            self.ids.add(identifier)
        if tag in {"a", "link"} and attributes.get("href"):
            self.urls.append(("href", str(attributes["href"])))
        if tag == "link" and "stylesheet" in str(attributes.get("rel", "")).split():
            href = attributes.get("href")
            if href:
                self.stylesheets.append(str(href))
        if tag in {"img", "script", "source"} and attributes.get("src"):
            self.urls.append(("src", str(attributes["src"])))
        if tag == "object" and attributes.get("data"):
            self.urls.append(("data", str(attributes["data"])))
        if tag == "video" and attributes.get("poster"):
            self.urls.append(("poster", str(attributes["poster"])))
        if attributes.get("srcset"):
            for candidate in str(attributes["srcset"]).split(","):
                url = candidate.strip().split(maxsplit=1)[0]
                if url:
                    self.urls.append(("srcset", url))

    def handle_data(self, data: str) -> None:
        if self._title_chunks is not None:
            self._title_chunks.append(data)

    def handle_endtag(self, tag: str) -> None:
        if tag == "title" and self._title_chunks is not None:
            self.titles.append("".join(self._title_chunks).strip())
            self._title_chunks = None


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--profile", choices=("pilot", "full"), default="pilot")
    parser.add_argument("--dist", type=Path, default=DIST)
    parser.add_argument("--site-url", default=SITE_URL)
    return parser.parse_args()


def local_reference(
    raw: str, source: Path, dist: Path, site_url: str
) -> tuple[Path, str] | None:
    if raw.startswith(site_url.rstrip("/") + "/"):
        raw = raw[len(site_url.rstrip("/")) :]
    split = urlsplit(raw)
    if (
        split.scheme
        or split.netloc
        or raw.startswith(("mailto:", "tel:", "data:", "javascript:"))
    ):
        return None
    path_text = unquote(split.path)
    if not path_text:
        target = source
    elif path_text.startswith("/"):
        target = dist / path_text.lstrip("/")
    else:
        target = source.parent / path_text
    target = target.resolve()
    if target.is_dir():
        target = target / "index.html"
    return target, unquote(split.fragment)


def has_typst_math(source: str) -> bool:
    return re.search(r"(?<!\\)\$(?:[^$]|\n)+?(?<!\\)\$", source) is not None


def validate_page_metadata(
    source: Path, parser: References, dist: Path, site_url: str
) -> list[str]:
    errors: list[str] = []
    if parser.html_langs != ["fr"]:
        errors.append(f'{rel(source)}: expected exactly one <html lang="fr">')
    if len(parser.titles) != 1 or not parser.titles[0]:
        errors.append(f"{rel(source)}: expected exactly one non-empty <title>")

    descriptions = [
        meta
        for meta in parser.metas
        if str(meta.get("name", "")).lower() == "description"
    ]
    if len(descriptions) != 1 or not str(descriptions[0].get("content", "")).strip():
        errors.append(f"{rel(source)}: expected exactly one non-empty meta description")
    viewports = [
        meta for meta in parser.metas if str(meta.get("name", "")).lower() == "viewport"
    ]
    if len(viewports) != 1 or not str(viewports[0].get("content", "")).strip():
        errors.append(f"{rel(source)}: expected exactly one non-empty viewport meta")

    if len(parser.stylesheets) != 1:
        errors.append(f"{rel(source)}: expected exactly one stylesheet")
    else:
        resolved = local_reference(parser.stylesheets[0], source, dist, site_url)
        if resolved is None:
            errors.append(f"{rel(source)}: stylesheet must be a local site asset")
    return errors


def run(profile: str = "pilot", dist: Path = DIST, site_url: str = SITE_URL) -> None:
    dist = dist.resolve()
    if not (dist / "index.html").is_file():
        raise CheckError("dist/index.html is missing; run a build first")
    html_files = sorted(dist.rglob("*.html"))
    parsed: dict[Path, References] = {}
    errors: list[str] = []
    for required_root_file in ("robots.txt", "sitemap.xml"):
        if not (dist / required_root_file).is_file():
            errors.append(f"dist/{required_root_file}: missing root site file")
    robots = dist / "robots.txt"
    if robots.is_file():
        expected_sitemap = f"Sitemap: {site_url.rstrip('/')}/sitemap.xml"
        sitemap_directives = {
            line.strip()
            for line in robots.read_text(encoding="utf-8").splitlines()
            if line.strip().lower().startswith("sitemap:")
        }
        if sitemap_directives != {expected_sitemap}:
            found = ", ".join(sorted(sitemap_directives)) or "none"
            errors.append(
                "dist/robots.txt: expected root sitemap directive "
                f"{expected_sitemap!r}; found {found}"
            )
    for path in html_files:
        parser = References()
        try:
            parser.feed(path.read_text(encoding="utf-8"))
        except (UnicodeDecodeError, html.parser.HTMLParseError) as exc:
            errors.append(f"{rel(path)}: cannot parse HTML: {exc}")
        parsed[path.resolve()] = parser
        errors.extend(validate_page_metadata(path.resolve(), parser, dist, site_url))
        if parser.accessible_numa_logos != 1:
            errors.append(
                f"{rel(path)}: expected one accessible inline Numa logo, "
                f"found {parser.accessible_numa_logos}"
            )
        if parser.tag_counts["svg"] < 1:
            errors.append(f"{rel(path)}: CeTZ Numa logo did not export as inline SVG")

    _, exercises = check_schema(profile, quiet=True)
    published = [exercise for exercise in exercises if exercise.status == "published"]
    expected_exercise_pages = {
        (dist / "e" / f"{exercise.id}.html").resolve() for exercise in published
    }
    actual_exercise_pages = {path.resolve() for path in (dist / "e").glob("*.html")}
    if actual_exercise_pages != expected_exercise_pages:
        missing = sorted(
            rel(path) for path in expected_exercise_pages - actual_exercise_pages
        )
        extra = sorted(
            rel(path) for path in actual_exercise_pages - expected_exercise_pages
        )
        if missing:
            errors.append(f"missing published exercise pages: {', '.join(missing)}")
        if extra:
            errors.append(f"unexpected exercise pages: {', '.join(extra)}")

    if profile == "pilot":
        for public_print_path in (dist / "print", dist / "sessions"):
            if public_print_path.exists():
                errors.append(
                    f"{rel(public_print_path)}: teacher/selection output must not be public"
                )
        index_source = (dist / "index.html").read_text(encoding="utf-8")
        required_catalog_hooks = (
            'id="catalog-filters"',
            'name="q"',
            'name="topic"',
            'name="min"',
            'name="max"',
            'name="source"',
            'name="selection"',
            'src="assets/site.js"',
            'data-difficulty=',
            'data-selections=',
        )
        for hook in required_catalog_hooks:
            if hook not in index_source:
                errors.append(f"dist/index.html: missing catalog hook {hook!r}")
        if not (dist / "assets" / "site.js").is_file():
            errors.append("dist/assets/site.js: missing catalog interaction script")
        details = sum(
            parsed[path].tag_counts["details"]
            for path in actual_exercise_pages
            if path in parsed
        )
        if details:
            errors.append(
                f"pilot exercises have empty optional content but emitted {details} details elements"
            )

    site_template = read_text(ROOT / "templates" / "site.typ")
    for tag in ("details", "summary"):
        if f'html.elem("{tag}"' not in site_template:
            errors.append(
                f"templates/site.typ: missing native {tag} disclosure element path"
            )

    logo_template = read_text(ROOT / "lib" / "logo.typ")
    if '#import "@preview/cetz:0.5.2"' not in logo_template:
        errors.append("lib/logo.typ: CeTZ version must remain pinned to 0.5.2")
    traced_surface_count = logo_template.count("svg-path(")
    if traced_surface_count < 8:
        errors.append(
            "lib/logo.typ: expected the non-boolean glyphs to remain filled-surface "
            f"traces; found {traced_surface_count} paths"
        )
    boolean_ops = {
        op: logo_template.count(f'op: "{op}"')
        for op in ("union", "intersection", "difference")
    }
    if boolean_ops["union"] < 2 or boolean_ops["intersection"] < 2:
        errors.append(
            "lib/logo.typ: the m must use CeTZ unions and computed intersections"
        )
    if boolean_ops["difference"] < 1 or "circle(" not in logo_template:
        errors.append(
            "lib/logo.typ: the m must subtract true circular counter surfaces"
        )
    stroke_values = set(re.findall(r"stroke:\s*([^,\n\)]+)", logo_template))
    # `stroke` is the m helper's forwarded parameter; every visible caller
    # supplies the literal 0 mm value, while Boolean operands pass `none`.
    invalid_strokes = sorted(stroke_values - {"none", "0mm", "stroke"})
    if invalid_strokes:
        errors.append(
            "lib/logo.typ: every surface must use no stroke or a literal 0 mm "
            f"stroke; found {invalid_strokes}"
        )
    for stroked_primitive in ("line(", "bezier("):
        if stroked_primitive in logo_template:
            errors.append(
                "lib/logo.typ: logo must use closed filled surfaces, not "
                f"{stroked_primitive[:-1]} primitives"
            )

    not_found = (dist / "404.html").resolve()
    not_found_parser = parsed.get(not_found)
    if not_found_parser is None:
        errors.append("dist/404.html: missing generated 404 page")
    else:
        required_absolute = {
            f"{site_url.rstrip('/')}/assets/site.css",
            f"{site_url.rstrip('/')}/index.html",
        }
        found_urls = {url for _, url in not_found_parser.urls}
        missing_absolute = sorted(required_absolute - found_urls)
        if missing_absolute:
            errors.append(
                "dist/404.html: missing absolute base URLs: "
                + ", ".join(missing_absolute)
            )

    legacy_logo = dist / "assets" / "brand" / "numa-logo.png"
    if legacy_logo.exists():
        errors.append(
            "dist/assets/brand/numa-logo.png: legacy raster logo must not be bundled"
        )

    math_exercises = [
        exercise for exercise in published if has_typst_math(exercise.text)
    ]
    for exercise in math_exercises:
        page = (dist / "e" / f"{exercise.id}.html").resolve()
        parser = parsed.get(page)
        if parser is not None and parser.tag_counts["math"] == 0:
            errors.append(
                f"{rel(page)}: source contains Typst math but generated page has no MathML"
            )

    for source, parser in parsed.items():
        for attribute, raw in parser.urls:
            resolved = local_reference(raw, source, dist, site_url)
            if resolved is None:
                continue
            target, fragment = resolved
            if dist != target and dist not in target.parents:
                errors.append(f"{rel(source)}: {attribute} escapes dist/: {raw}")
                continue
            if not target.is_file():
                errors.append(f"{rel(source)}: broken {attribute} {raw!r}")
                continue
            if fragment and target.suffix.lower() == ".html":
                target_parser = parsed.get(target)
                if target_parser is None:
                    target_parser = References()
                    target_parser.feed(target.read_text(encoding="utf-8"))
                    parsed[target] = target_parser
                if fragment not in target_parser.ids:
                    errors.append(
                        f"{rel(source)}: missing fragment #{fragment} in {rel(target)}"
                    )

    css_url_re = re.compile(r"url\(\s*(['\"]?)(.*?)\1\s*\)", re.IGNORECASE)
    css_files = sorted(dist.rglob("*.css"))
    for source in css_files:
        for match in css_url_re.finditer(source.read_text(encoding="utf-8")):
            raw = match.group(2)
            resolved = local_reference(raw, source.resolve(), dist, site_url)
            if resolved is None:
                continue
            target, _ = resolved
            if dist != target and dist not in target.parents:
                errors.append(f"{rel(source)}: CSS url escapes dist/: {raw}")
            elif not target.is_file():
                errors.append(f"{rel(source)}: broken CSS url {raw!r}")

    if errors:
        raise CheckError("HTML link/asset validation failed:\n- " + "\n- ".join(errors))
    print(
        f"html links/assets/metadata: ok ({len(html_files)} HTML files, "
        f"{len(actual_exercise_pages)} published exercises, "
        + (
            f"MathML {len(math_exercises)}/{len(math_exercises)}"
            if math_exercises
            else "MathML not applicable (0 math exercises)"
        )
        + ")"
    )


def main() -> int:
    args = parse_args()
    run(args.profile, args.dist, args.site_url)
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except CheckError as exc:
        fail(str(exc))
