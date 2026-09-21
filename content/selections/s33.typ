#import "../../lib/model.typ": selection
#import "../exercise-registry.typ": exercise-at

#let serials = (72, 73, 74, 75, 76)

#let item = selection(
  id: "s33",
  title: [Grand mélange],
  date: "26.05.2027",
  year: 2027,
  purpose: "response",
  listed: true,
  exercises: serials.map(exercise-at),
)
