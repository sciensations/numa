#import "../../lib/model.typ": selection
#import "../exercise-registry.typ": exercise-at

// Drive: S33_2027-05-26_problemes_grand_melange.docx
// https://docs.google.com/document/d/1JW-HoXvOAp8TMDX2dxZYYbGv_epp9KT7/edit
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
