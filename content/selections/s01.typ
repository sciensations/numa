#import "../../lib/model.typ": selection
#import "../exercise-registry.typ": exercise-at

#let serials = (7, 8, 9, 10, 11, 12)

#let item = selection(
  id: "s01",
  title: [Bienvenue au cercle ! - énigmes de rentrée],
  date: "26.08.2026",
  year: 2026,
  purpose: "response",
  listed: true,
  exercises: serials.map(exercise-at),
)
