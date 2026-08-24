# Numa exercise library

This repository keeps Numa exercises as independent Typst records and publishes them as a searchable website. Séances are lightweight selections: they can provide a response sheet or a temporary teaching sequence without owning an exercise or changing its permanent URL.

The current pilot contains twelve exercises drawn from S01 and S03. The public site is generated entirely by Typst and is designed for browsing by title, topic, difficulty, source, or selection. Teacher print files are compiled separately and are not exposed as public website downloads.

## Published identifiers

Each exercise has a permanent six-character hexadecimal identifier derived from its append-only serial number with the pinned Typst package `@preview/suiji:0.5.1`. The title, topic, difficulty, and selection membership may change without changing that identifier:

```text
https://sciensations.github.io/numa/e/3009ac.html
```

Never change a published serial or reuse one. The short identifier is checked against a golden list.

## Requirements

- [Typst 0.15.1](https://github.com/typst/typst/releases/tag/v0.15.1), exactly;
- [CeTZ 0.5.2](https://typst.app/universe/package/cetz/), pinned by the logo import;
- [just](https://just.systems/), optional but convenient;
- Python 3.10 or newer;
- the pinned QA packages in `scripts/requirements-qa.txt`.

The project pins Typst because its HTML bundle export is experimental. Builds ignore system fonts and use the committed Atkinson Hyperlegible Next files plus Typst's embedded fonts. `just setup` downloads the exact Typst binary into the ignored `.tools/` directory when needed.

The Numa wordmark lives in `lib/logo.typ` as closed, filled CeTZ surfaces with zero-width strokes. Print templates draw those surfaces directly; the website wraps the same drawing as accessible inline SVG. The old PNG under `assets/brand/` is retained only as a visual reference and is not bundled or rendered.

## Teacher workflow

The normal workflow can be run locally or in the Typst web app after importing the repository:

- edit an independent exercise under `content/exercises/`;
- assemble a temporary card batch in `teacher/cards.typ`;
- compile a stored selection's response sheet from `teacher/responses/`;
- inspect serials and permanent IDs in `teacher/catalog.typ`.

The useful local commands are:

```sh
just new-exercise 13
just registry
just preview
just build
just print-cards
just print-response s01
just print-response s03
just check
```

The direct Python equivalents are `python3 scripts/new_exercise.py 13`, `python3 scripts/preview.py`, `python3 scripts/build.py`, `python3 scripts/compile_print.py cards`, `python3 scripts/compile_print.py response s01`, `python3 scripts/compile_print.py response s03`, and `python3 scripts/check.py --profile pilot`.

Generated website files go to the ignored `dist/` directory. Teacher PDFs go to the ignored `output/pdf/` directory.

## Adding an exercise

`just new-exercise <serial>` creates `content/exercises/<serial-padded-to-four-digits>.typ` as a draft, refuses to overwrite an existing file, and regenerates `content/exercise-registry.typ`. No manual catalog import is needed.

Typst requires static imports, so `content/exercise-registry.typ` is generated from the numbered files and committed. Run `just registry` after adding or removing a file by hand. Builds and CI reject a stale registry. Selections and teacher card batches refer to serials through `exercise-at`, for example `(1, 4, 9).map(exercise-at)`.

An exercise record looks like this:

```typst
#import "../../lib/model.typ": exercise

#let item = exercise(
  serial: 13,
  title: [Titre],
  statement_parts: ([Énoncé.],),
  figure: none,
  source: (
    organization: "FSJM",
    competition: "Quarts de finale",
    year: 2026,
    problem: 1,
    coefficient: 1,
    tracker_row: 2000,
    attribution: [FSJM, Quarts de finale 2026, problème n°1, coef. 1 · ligne 2000 de l'index],
  ),
  topics: ("logique-strategie",),
  difficulty: 2.5,
  hints: (),
  extra: none,
  solution: none,
  status: "draft",
)
```

`statement_parts` contains one or two content blocks. A one-part exercise gets a branded reverse; a two-part exercise continues on the reverse. The controlled topic vocabulary and all validation rules live in `lib/model.typ`.

Figures use repository-relative paths under `assets/` and require meaningful alternative text. Drafts do not appear on the public site or response sheets. Empty hints, enrichment, and solutions are deliberately omitted from public pages and reported by the checks.

## Selections and response sheets

A selection under `content/selections/` stores a label, optional year/term metadata, and an ordered tuple of exercise records. It does not affect exercise identity or the default catalog order. The same exercise may belong to several selections.

To make an ad hoc card deck, change only the serial tuple in `teacher/cards.typ`. To preserve a response sheet for later reuse, add a named selection with a `serials` tuple and a small entrypoint under `teacher/responses/`.

Cards are A6 landscape cells imposed four-up on A4 landscape. Front sheets are followed by horizontally mirrored backs for short-edge duplex printing. Print at 100%, test one duplex sheet, cut on the center marks, and laminate.

Each response pack has two one-sided A4 portrait pages: an answer sheet and a separate QR sheet. Every code points directly to an independent exercise page and carries the printed hexadecimal identifier.

## Validation

`just check` rebuilds the pilot site and its three teacher PDFs, then verifies:

- neutral exercise schema, structured sources, controlled topics, difficulty bounds, selections, and golden identifiers;
- an exact generated-registry check, so adding a file never requires hand-maintained import aliases;
- generated HTML links, assets, metadata, filtering hooks, and native disclosure semantics;
- A4 page dimensions, six card-imposition pages, and both two-page response packs;
- every QR payload decoded at print resolution and every printed fallback URL;
- smoke fixtures for disclosures and response sheets with four and eight rows;
- missing optional content and accidental published placeholders.

Before a production print, also inspect all rendered pages, print a 100% short-edge duplex proof, check alignment after cutting, and scan the paper with the phones students will use.

## Deployment

`.github/workflows/pages.yml` builds and validates pull requests. A successful push to `main` deploys only the site bundle through GitHub Pages; the private teacher workflow remains source-controlled but its generated PDFs are not uploaded to the public site.

The workflow stays on the `pilot` profile until the remaining exercises have been migrated and reviewed. The `full` profile is the final 83-exercise and 14-selection publication gate.
