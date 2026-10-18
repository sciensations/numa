#import "../../lib/model.typ": selection
#import "../exercise-registry.typ": exercise-at

// Drive: S26_2027-03-24_problemes_pesees.docx
// https://docs.google.com/document/d/1IH-WZCNDNuvO_fITgwLyWSuGv_DG1H5O/edit
#let serials = (54, 55, 56, 57, 58)

#let item = selection(
  id: "s26",
  title: [Pesées],
  date: "24.03.2027",
  year: 2027,
  purpose: "response",
  listed: true,
  exercises: serials.map(exercise-at),
)
