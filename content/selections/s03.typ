#import "../../lib/model.typ": selection
#import "../exercise-registry.typ": exercise-at

// Drive: S03_2026-09-09_problemes_parite.docx
// https://docs.google.com/document/d/1HcsZBwn9ACaIZU592snrg3l-e0g5h_0U/edit
#let serials = (1, 2, 3, 4, 5, 6)

#let item = selection(
  id: "s03",
  title: [Fiche de problèmes ],
  date: "09.09.2026",
  year: 2026,
  purpose: "response",
  listed: true,
  exercises: serials.map(exercise-at),
)
