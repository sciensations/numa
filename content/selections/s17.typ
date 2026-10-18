#import "../../lib/model.typ": selection
#import "../exercise-registry.typ": exercise-at

// Drive: S17_2027-01-13_problemes_quadrillage.docx
// https://docs.google.com/document/d/1cPZ9LlZEE5wGNKWlXYPgyNqqtI7mhoRL/edit
#let serials = (37, 38, 39, 40, 41)

#let item = selection(
  id: "s17",
  title: [Géométrie sur quadrillage],
  date: "13.01.2027",
  year: 2027,
  purpose: "response",
  listed: true,
  exercises: serials.map(exercise-at),
)
