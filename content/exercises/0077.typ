#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Le poids des nombres],
  topics: ("nombres-divisibilite", "optimisation"),
  difficulty: 2.5,
  content: [
    Le « poids » d'un nombre est la somme de ses chiffres.

    Quels sont les DEUX PREMIERS chiffres (à gauche) du plus petit nombre qui pèse 1992 ?
  ],
  source: (
    organization: "FSJM",
    competition: "Demi-finale",
    year: 1992,
    problem: 3,
    coefficient: 3,
    tracker_row: 160,
    attribution: [FSJM, Demi-finale 1992, problème n°3, coef. 3 · ligne 160 de l'index],
  ),
  status: "published",
)
