#import "../../lib/model.typ": selection
#import "../exercise-registry.typ": exercise-at

#let serials = (19, 20, 21, 22, 23)

#let item = selection(
  id: "s09",
  title: [Principe des tiroirs],
  date: "04.11.2026",
  year: 2026,
  purpose: "response",
  listed: true,
  exercises: serials.map(exercise-at),
)
