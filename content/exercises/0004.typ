#import "../../lib/model.typ": exercise

#let item = exercise(
  serial: 4,
  title: [La pyramide de Mathilde],
  topics: ("nombres-divisibilite", "suites-motifs"),
  difficulty: 3.25,
  statement_parts: (
    [
      Mathilde a construit une pyramide de nombres. Les nombres entiers à partir de 1 se succèdent comme le montre le dessin, qui représente les cinq étages du haut. La pyramide de Mathilde compte 22 étages.

      Combien de nombres impairs compte l'étage du bas ?
    ],
  ),
  figure: (
    path: "assets/exercises/s03/pyramid.png",
    alt: "Pyramide de nombres : 1 au sommet, puis les entiers successifs disposés en rangées de longueur impaire jusqu'à la cinquième rangée.",
    caption: none,
  ),
  source: (
    organization: "FSJM",
    competition: "Demi-finale",
    year: 2022,
    problem: 6,
    coefficient: 6,
    tracker_row: 1781,
    attribution: [FSJM, Demi-finale 2022, problème n°6, coef. 6 · ligne 1781 de l'index],
  ),
  hints: (),
  extra: none,
  solution: none,
  status: "published",
)
