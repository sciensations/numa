#import "../../lib/model.typ": selection
#import "../exercise-registry.typ": exercise-at

// Drive: S20_2027-02-03_battle_2.docx
// https://docs.google.com/document/d/1OH3MQTg4wvWgZjM0TkkBl4ePdEHH_xz2/edit
#let serials = (42, 43, 44, 45, 46, 47, 48, 49)

#let item = selection(
  id: "s20",
  title: [Battle 2],
  date: "03.02.2027",
  year: 2027,
  purpose: "response",
  listed: true,
  exercises: serials.map(exercise-at),
)
