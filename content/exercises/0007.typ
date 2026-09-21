#import "../../lib/authoring.typ": exercise-diagram
#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Le patron du dé],
  topics: ("geometrie", "logique-strategie"),
  difficulty: 1.0,
  content: [
    Dans un dé « normal », la somme des points situés sur deux faces opposées est toujours égale à 7.

    #let cell = grid.cell.with(
      fill: luma(235),
      stroke: 0.5pt + black,
      inset: 0pt,
      align: center + horizon,
    )
    #let size = 9mm
    #exercise-diagram(
      alt: "Patron de dé formé de quatre cases alignées, avec une case au-dessus de la deuxième et une case sous la troisième ; les trois cases numérotées portent 2, 3 et 1.",
    )[
      #grid(
        columns: (size,) * 4,
        rows: (size,) * 3,
        gutter: 0pt,

        cell(x: 0, y: 1)[2],
        cell(x: 1, y: 1)[3],
        cell(x: 1, y: 0)[1],
        cell(x: 2, y: 1)[],
        cell(x: 3, y: 1)[],
        cell(x: 2, y: 2)[],
      )
    ]

    Complète les faces du patron de ce dé normal.
  ],
  source: (
    organization: "FSJM",
    competition: "Quarts de finale",
    year: 2006,
    problem: 1,
    coefficient: 1,
    tracker_row: 946,
    attribution: [FSJM, Quarts de finale 2006, problème n°1, coef. 1 · ligne 946 de l'index],
  ),
  hints: (),
  extra: none,
  solution: none,
  status: "published",
)
