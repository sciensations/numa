#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Le jardin],
  topics: ("geometrie", "mesures"),
  difficulty: 2.5,
  content: [
    Un jardin de largeur constante entoure une maison rectangulaire.

    Le périmètre extérieur (maison plus jardin) mesure 32 mètres de plus que le périmètre de la maison.

    Quelle est, en mètres, la largeur du jardin ?
  ],
  source: (
    organization: "FSJM",
    competition: "Demi-finale",
    year: 2016,
    problem: 6,
    coefficient: 6,
    tracker_row: 1489,
    attribution: [FSJM, Demi-finale 2016, problème n°6, coef. 6 · ligne 1489 de l'index],
  ),
  status: "published",
)
