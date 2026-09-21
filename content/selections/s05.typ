#import "../../lib/model.typ": selection
#import "../exercise-registry.typ": exercise-at

#let serials = (14, 15, 16, 17, 18)

#let item = selection(
  id: "s05",
  title: [Logique],
  date: "23.09.2026",
  year: 2026,
  purpose: "response",
  listed: true,
  exercises: serials.map(exercise-at),
)
