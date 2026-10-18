#import "../../lib/model.typ": selection
#import "../exercise-registry.typ": exercise-at

// Drive: S28_2027-04-21_problemes_graphes.docx
// https://docs.google.com/document/d/1-I6Gs2q1Ir-GUX-BfWGgURAfxmikoB-K/edit
#let serials = (59, 60, 61, 62, 63)

#let item = selection(
  id: "s28",
  title: [Graphes],
  date: "21.04.2027",
  year: 2027,
  purpose: "response",
  listed: true,
  exercises: serials.map(exercise-at),
)
