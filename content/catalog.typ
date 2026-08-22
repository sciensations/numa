#import "../lib/model.typ": memberships
#import "exercise-registry.typ": exercises
#import "selections/s03.typ": item as s03

#let selections = (s03,)

// Queryable scalar metadata for repository tooling. Statements and other Typst
// content remain in the canonical exercise records above.
#let catalog-data = exercises.map(item => (
  serial: item.serial,
  id: item.id,
  emojis: item.emojis,
  status: item.status,
  topics: item.topics,
  difficulty: item.difficulty,
  figure_path: if item.figure == none { none } else { item.figure.path },
  figure_alt: if item.figure == none { none } else { item.figure.alt },
  organization: item.source.organization,
  source_year: item.source.year,
  tracker_row: item.source.tracker_row,
  selections: memberships(selections, item).map(sel => sel.id),
))

#metadata(catalog-data) <catalog-data>
