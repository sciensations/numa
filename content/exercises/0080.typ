#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Devine nombre],
  topics: ("nombres-divisibilite", "logique-strategie"),
  difficulty: 3.75,
  content: [
    Utilise les chiffres de 1 à 9 pour former un nombre de 9 chiffres tous différents, tel que chaque paire de chiffres voisins forme un nombre de 2 chiffres égal au produit de deux nombres à un chiffre (éventuellement égaux).

    Quel est ce nombre ?
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 2",
    year: 2011,
    problem: 8,
    coefficient: 8,
    tracker_row: 1244,
    attribution: [FSJM, Finale internationale 2011, jour 2, problème n°8, coef. 8 · ligne 1244 de l'index],
  ),
  status: "published",
)
