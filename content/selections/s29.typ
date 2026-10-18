#import "../../lib/model.typ": selection
#import "../exercise-registry.typ": exercise-at

// Drive: S29_2027-04-28_battle_3.docx
// https://docs.google.com/document/d/1NwL97VBUYYFd-xRcZdo05w0jM_FU0H8M/edit
#let serials = (64, 65, 66, 67, 68, 69, 70, 71)

#let item = selection(
  id: "s29",
  title: [Battle 3],
  date: "28.04.2027",
  year: 2027,
  purpose: "response",
  listed: true,
  exercises: serials.map(exercise-at),
)
