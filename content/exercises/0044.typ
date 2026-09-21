#import "../../lib/model.typ": exercise
#import "../../lib/authoring.typ": exercise-diagram

#let item = exercise.with(
  title: [En diagonale],
  topics: ("geometrie", "optimisation"),
  difficulty: 2.5,
  content: [
    On divise un rectangle 3 × 4 en 12 petits carrés.

    Combien de diagonales de petits carrés peut-on dessiner, au maximum, de sorte que deux diagonales ne se croisent jamais et ne se touchent jamais, même par une extrémité ?

    #exercise-diagram(alt: "Rectangle quadrillé de quatre colonnes et trois rangées de petits carrés.")[
      #table(columns: (8mm,) * 4, rows: (8mm,) * 3, inset: 0pt, stroke: 0.6pt, ..range(12).map(_ => []))
    ]
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 2",
    year: 2008,
    problem: 3,
    coefficient: 3,
    tracker_row: 1060,
    attribution: [FSJM, Finale internationale 2008, jour 2, problème n°3, coef. 3 · ligne 1060 de l'index],
  ),
  status: "published",
)
