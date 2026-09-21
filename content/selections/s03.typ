#import "../../lib/model.typ": selection
#import "../exercise-registry.typ": exercise-at

#let serials = (1, 2, 3, 4, 5, 6)

#let item = selection(
  id: "s03",
  title: [Fiche de problèmes ],
  date: "09.09.2026",
  year: 2026,
  purpose: "response",
  listed: true,
  exercises: serials.map(exercise-at),
)
