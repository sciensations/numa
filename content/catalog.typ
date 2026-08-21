#import "../lib/model.typ": memberships
#import "exercises/0001.typ": item as ex01
#import "exercises/0002.typ": item as ex02
#import "exercises/0003.typ": item as ex03
#import "exercises/0004.typ": item as ex04
#import "exercises/0005.typ": item as ex05
#import "exercises/0006.typ": item as ex06
#import "selections/s03.typ": item as s03

#let exercises = (ex01, ex02, ex03, ex04, ex05, ex06)
#let selections = (s03,)

// Queryable scalar metadata for repository tooling. Statements and other Typst
// content remain in the canonical exercise records above.
#let catalog-data = exercises.map(item => (
  serial: item.serial,
  id: item.id,
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
