#import "../../lib/model.typ": selection
#import "../exercise-registry.typ": exercise-at

// Drive: S34_2027-06-02_battle_4_finale.docx
// https://docs.google.com/document/d/1s8zfshGC7xDDm_rR1cYqybUbU3I2jcI6/edit
#let serials = (77, 78, 79, 80, 81, 82, 83, 84)

#let item = selection(
  id: "s34",
  title: [Battle 4, finale],
  date: "02.06.2027",
  year: 2027,
  purpose: "response",
  listed: true,
  exercises: serials.map(exercise-at),
)
