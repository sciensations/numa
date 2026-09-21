#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Histoire de Peugeot],
  topics: ("nombres-divisibilite", "algebre"),
  difficulty: 3.25,
  content: [
    « Tiens, c'est curieux », rugit Léo. « Cette 305 a un numéro d'immatriculation intéressant : que j'ajoute 304 ou 405 à ce nombre, le résultat est un carré parfait ! »

    Quel est ce nombre ?
  ],
  source: (
    organization: "FSJM",
    competition: "Demi-finale",
    year: 1988,
    problem: 6,
    coefficient: 6,
    tracker_row: 7,
    attribution: [FSJM, Demi-finale 1988, problème n°6, coef. 6 · ligne 7 de l'index],
  ),
  status: "published",
)
