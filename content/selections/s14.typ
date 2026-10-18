#import "../../lib/model.typ": selection
#import "../exercise-registry.typ": exercise-at

// Drive: S14_2026-12-09_problemes_invariants.docx
// https://docs.google.com/document/d/1nYOhjyW-Ez1ml7ICnb1Ng87de51hiZYl/edit
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
