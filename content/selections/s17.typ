#import "../../lib/model.typ": selection
#import "../exercise-registry.typ": exercise-at

#let serials = (37, 38, 39, 40, 41)

#let item = selection(
  id: "s17",
  title: [Géométrie sur quadrillage],
  date: "13.01.2027",
  year: 2027,
  purpose: "response",
  listed: true,
  exercises: serials.map(exercise-at),
)
