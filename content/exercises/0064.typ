#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Le cadenas à chiffres],
  topics: ("nombres-divisibilite", "logique-strategie"),
  difficulty: 1.5,
  content: [
    Le numéro d'un cadenas s'écrit avec trois chiffres rangés, de gauche à droite, dans un ordre strictement décroissant. Le produit des trois chiffres est impair, et leur somme est un carré parfait.

    Quel est le numéro ?
  ],
  source: (
    organization: "FSJM",
    competition: "Demi-finale",
    year: 1992,
    problem: 1,
    coefficient: 1,
    tracker_row: 158,
    attribution: [FSJM, Demi-finale 1992, problème n°1, coef. 1 · ligne 158 de l'index],
  ),
  status: "published",
)
