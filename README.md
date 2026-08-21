# Numa exercise library

This repository keeps Numa exercises as independent Typst records and publishes them as a searchable website. Séances are lightweight selections: they can provide a response sheet or a temporary teaching sequence without owning an exercise or changing its permanent URL.

The S03 pilot contains six exercises. The public site is generated entirely by Typst and is designed for browsing by title, topic, difficulty, source, or selection. Teacher print files are compiled separately and are not exposed as public website downloads.

## Published identifiers

Each exercise has a permanent six-character hexadecimal identifier derived from its append-only serial number with the pinned Typst package `@preview/suiji:0.5.1`. The title, topic, difficulty, and selection membership may change without changing the URL:

```text
https://lcnbr.github.io/numa/e/3009ac.html
```

Never change a published serial or reuse one. The short identifier is checked against a golden list, because printed QR codes cannot be recalled.

## Requirements

- [Typst 0.15.1](https://github.com/typst/typst/releases/tag/v0.15.1), exactly;
- [just](https://just.systems/), optional but convenient;
- Python 3.10 or newer;
- the pinned QA packages in `scripts/requirements-qa.txt`.

The project pins Typst because its HTML bundle export is experimental. Builds ignore system fonts and use the committed Atkinson Hyperlegible Next files plus Typst's embedded fonts. `just setup` downloads the exact Typst binary into the ignored `.tools/` directory when needed.

## Teacher workflow

The normal workflow can be run locally or in the Typst web app after importing the repository:

- edit an independent exercise under `content/exercises/`;
- assemble a temporary card batch in `teacher/cards.typ`;
- compile a stored selection's response sheet from `teacher/responses/`;
- inspect serials and permanent IDs in `teacher/catalog.typ`.

The useful local commands are:

```sh
just new-exercise 7
just preview
just build
just print-cards
just print-response s03
just check
```

The direct Python equivalents are `python3 scripts/new_exercise.py 7`, `python3 scripts/preview.py`, `python3 scripts/build.py`, `python3 scripts/compile_print.py cards`, `python3 scripts/compile_print.py response s03`, and `python3 scripts/check.py --profile pilot`.

Generated website files go to the ignored `dist/` directory. Teacher PDFs go to the ignored `output/pdf/` directory.

## Adding an exercise

`just new-exercise <serial>` creates `content/exercises/<serial-padded-to-four-digits>.typ` as a draft and refuses to overwrite an existing file. Register the import in `content/catalog.typ` when it is ready to participate in validation.

An exercise record looks like this:

```typst
#import "../../lib/model.typ": exercise

#let item = exercise(
  serial: 7,
  title: [Titre],
  statement_parts: ([Énoncé.],),
  figure: none,
  source: (
    organization: "FFJM",
    competition: "Championnat",
    year: 2026,
    round: "Qualifications",
    problem: "1",
  ),
  topics: ("logique",),
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

To make an ad hoc card deck, change only the tuple in `teacher/cards.typ`. To preserve a response sheet for later reuse, add a named selection and a small entrypoint under `teacher/responses/`.

Cards are A6 landscape cells imposed four-up on A4 landscape. Front sheets are followed by horizontally mirrored backs for short-edge duplex printing. Print at 100%, test one duplex sheet, cut on the center marks, and laminate.

The response sheet is one-sided A4 portrait. Its QR codes point directly to the independent exercise pages; the visible fallback URL carries the same permanent identifier.

## Validation

`just check` rebuilds the pilot site and both teacher PDFs, then verifies:

- neutral exercise schema, structured sources, controlled topics, difficulty bounds, selections, and golden identifiers;
- generated HTML links, assets, metadata, filtering hooks, and native disclosure semantics;
- A4 page dimensions, four card-imposition pages, and the single response page;
- every QR payload decoded at print resolution and every printed fallback URL;
- smoke fixtures for disclosures and response sheets with four and eight rows;
- missing optional content and accidental published placeholders.

Before a production print, also inspect all rendered pages, print a 100% short-edge duplex proof, check alignment after cutting, and scan the paper with the phones students will use.

## Deployment

`.github/workflows/pages.yml` builds and validates pull requests. A successful push to `main` deploys only the site bundle through GitHub Pages; the private teacher workflow remains source-controlled but its generated PDFs are not uploaded to the public site.

The workflow stays on the `pilot` profile until the remaining exercises have been migrated and reviewed. The `full` profile is the final 77-exercise and 13-selection publication gate.
