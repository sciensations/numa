#import "../../lib/model.typ": selection
#import "../exercise-registry.typ": exercise-at

// Drive: S01_2026-08-26_speciale_ouverture.docx
// https://docs.google.com/document/d/1WWZr2iahahgIOtrZLlL0S_WYvFLRvAGv/edit
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
