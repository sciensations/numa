#import "../../lib/model.typ": selection
#import "../exercise-registry.typ": exercise-at

#let serials = (14, 15, 16, 17, 18, 85,86,87)

#let item = selection(
  id: "s05",
  title: [Fiche de problèmes],
  date: "23.09.2026",
  year: 2026,
  purpose: "response",
  listed: true,
  exercises: serials.map(exercise-at),
)
