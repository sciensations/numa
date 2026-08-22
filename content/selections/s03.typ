#import "../../lib/model.typ": selection
#import "../exercise-registry.typ": exercise-at

#let serials = (1, 2, 3, 4, 5, 6)

#let item = selection(
  id: "s03",
  title: [Fiche 1 : la parité],
  date: "2026-09-09",
  year: 2026,
  purpose: "response",
  listed: true,
  exercises: serials.map(exercise-at),
)
