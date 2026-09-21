#import "../../lib/model.typ": selection
#import "../exercise-registry.typ": exercise-at

#let serials = (50, 51, 52, 53)

#let item = selection(
  id: "s22",
  title: [Dénombrement],
  date: "17.02.2027",
  year: 2027,
  purpose: "response",
  listed: true,
  exercises: serials.map(exercise-at),
)
