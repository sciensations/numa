// Copy to content/exercises/NNNN.typ and increase last-serial in the registry.
// The filename supplies the serial. Fill in the source before publishing.
#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [À compléter],
  topics: ("logique-strategie",),
  difficulty: 1.0,
  content: [Énoncé à compléter.],
  source: (
    organization: "À compléter",
    competition: "À compléter",
    year: 2000,
    problem: 1,
    coefficient: 1,
    tracker_row: 1,
    attribution: [Source à compléter.],
  ),
  status: "draft",
)
