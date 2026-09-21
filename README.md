# Numa exercise library

This repository keeps Numa exercises as independent Typst records and publishes them as a searchable website. Séances are lightweight selections: they can provide a response sheet or a temporary teaching sequence without owning an exercise or changing its permanent URL.

The public site is generated entirely by Typst and supports browsing by title, topic, difficulty, source, or selection. Teacher print files are compiled separately and are not exposed as public website downloads.

## Published identifiers

Each exercise has a permanent six-character hexadecimal identifier derived from its append-only serial number with the pinned Typst package `@preview/suiji:0.5.1`. The title, topic, difficulty, and selection membership may change without changing that identifier:

```text
https://sciensations.github.io/numa/e/3009ac.html
```

The serial comes from the exercise filename. Never rename a published file to another serial or reuse one.

## Requirements

- [Typst 0.15.1](https://github.com/typst/typst/releases/tag/v0.15.1), exactly;
- [CeTZ 0.5.2](https://typst.app/universe/package/cetz/), pinned by the logo import;
- [just](https://just.systems/), optional but convenient.

The project pins Typst because its HTML bundle export is experimental. Builds ignore system fonts and use the committed Atkinson Hyperlegible Next files plus Typst's embedded fonts. The repository has no Python dependency; CI downloads the pinned Typst binary, while local commands use `typst` from `PATH` or the binary named by `TYPST`.

The Numa wordmark lives in `lib/logo.typ` as closed, filled CeTZ surfaces with zero-width strokes. Print templates draw those surfaces directly; the website wraps the same drawing as accessible inline SVG. The old PNG under `assets/brand/` is retained only as a visual reference and is not bundled or rendered.

## Teacher workflow

The normal workflow can be run locally or in the Typst web app after importing the repository:

- edit an independent exercise under `content/exercises/`;
- assemble a temporary card batch in `teacher/cards.typ`;
- compile a stored selection's response sheet from `teacher/responses/`;
- inspect serials and permanent IDs in `teacher/catalog.typ`.

The useful local commands are:

```sh
just preview
just build
just print-cards
just print-response s01
just print-response s03
just check
```

Without `just`, use the direct Typst commands shown in the `justfile`. Exercise loading runs entirely in Typst and also works in the Typst web app.

Generated website files go to the ignored `dist/` directory. Teacher PDFs go to the ignored `output/pdf/` directory.

## Adding an exercise

To add the next exercise:

1. Copy `templates/exercise-draft.typ` to `content/exercises/0014.typ` in your editor or the Typst web app.
2. Set `last-serial` to `14` in `content/exercise-registry.typ`.
3. Edit the title, content, topics, difficulty, and source. Set `status: "published"` when it is ready.

The registry imports files from `0001.typ` through `last-serial` and supplies each record's serial from its filename. Keep this numbering contiguous. A missing file in that range causes an import error; files beyond `last-serial` are not loaded.

Typst supports computed import paths, but [cannot list a directory's contents](https://typst.app/docs/reference/foundations/path/#further-operations). The last serial is the only registration setting to update. There is no generated import list or helper script.

An exercise record looks like this:

```typst
#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Titre],
  content: [Énoncé.],
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
)
```

`exercise.with(...)` leaves the serial for the registry to supply. The default status is `"draft"`; hints, enrichment, and solution are optional and empty by default.

`content` is the complete author-controlled body of one card side. Text, diagrams, images, spacing, columns, and local layout all belong in that single Typst block. The shared template adds only the title frame and the branded reverse, and compilation rejects a body that exceeds the front's safe area. The controlled topic vocabulary and validation rules live in `lib/model.typ`.

For visuals that must work in print and experimental HTML export, import the needed helpers from `lib/authoring.typ` inside the exercise file. `exercise-image` places an image, `exercise-diagram` preserves a code-drawn layout, `exercise-center` keeps a semantic table centered, and `exercise-columns` provides responsive side-by-side content. They are called exactly where the author wants the visual; there is no separate figure field or template-selected layout. Image paths start at `/assets/` and every visual requires meaningful alternative text.

Drafts do not appear on the public site or response sheets. Empty hints, enrichment, and solutions are omitted from public pages; the generated `content-status.json` records their presence without blocking publication.

## Selections and response sheets

A selection under `content/selections/` stores a label, optional year/term metadata, and an ordered tuple of exercise records. It does not affect exercise identity or the default catalog order. The same exercise may belong to several selections.

To make an ad hoc card deck, change only the serial tuple in `teacher/cards.typ`. Selections and teacher card batches look up serials through `exercise-at`, for example `(1, 4, 9).map(exercise-at)`. To preserve a response sheet for later reuse, add a named selection with a `serials` tuple and a small entrypoint under `teacher/responses/`.

Cards are A6 cells imposed four-up on A4, both in horizontal orientation. Front sheets are followed by horizontally mirrored backs for short-edge duplex printing. Print at 100%, test one duplex sheet, cut on the center marks, and laminate.

Each response pack has one A4 answer sheet followed by printable QR sheets. Every exercise code is repeated 12 times for cutting and distribution; every copy points directly to the independent exercise page and carries the printed hexadecimal identifier. The current six-exercise selections produce one answer page and two QR pages.

## Validation

`just check` asks Typst to compile the website, card batch, and every stored response selection. Typst validates:

- required exercise and source fields;
- controlled topics, difficulty bounds, stable identifiers, and unique ordered records;
- valid published selection membership;
- Typst syntax, imports, referenced assets, and template assertions.

Publication has no fixed exercise or selection totals. Output review is a human print and browser check.

Before a production print, also inspect all rendered pages, print a 100% short-edge duplex proof, check alignment after cutting, and scan the paper with the phones students will use.

## Deployment

`.github/workflows/pages.yml` compiles pull requests. A successful push to `main` deploys only the site bundle through GitHub Pages; the private teacher workflow remains source-controlled but its generated PDFs are not uploaded to the public site.
