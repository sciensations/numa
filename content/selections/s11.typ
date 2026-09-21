#import "../../lib/model.typ": selection
#import "../exercise-registry.typ": exercise-at

#let serials = (24, 25, 26, 27, 28, 29, 30, 31)

#let item = selection(
  id: "s11",
  title: [Battle 1],
  date: "18.11.2026",
  year: 2026,
  purpose: "response",
  listed: true,
  exercises: serials.map(exercise-at),
)
