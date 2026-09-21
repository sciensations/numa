#import "../../lib/model.typ": selection
#import "../exercise-registry.typ": exercise-at

#let serials = (32, 33, 34, 35, 36)

#let item = selection(
  id: "s14",
  title: [Invariants],
  date: "09.12.2026",
  year: 2026,
  purpose: "response",
  listed: true,
  exercises: serials.map(exercise-at),
)
