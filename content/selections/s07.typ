#import "../../lib/model.typ": selection
#import "../exercise-registry.typ": exercise-at

// Drive: S07_2026-10-21_problemes_tiroirs.docx
// https://docs.google.com/document/d/17LNMaA27uuHHZhx9xACozdWbrBLA_uNK/edit
#let serials = (19, 20, 21, 22, 23)

#let item = selection(
  id: "s07",
  title: [Principe des tiroirs],
  date: "21.10.2026",
  year: 2026,
  purpose: "response",
  listed: true,
  exercises: serials.map(exercise-at),
)
