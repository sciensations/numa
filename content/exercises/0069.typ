#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Le nombre mystérieux],
  topics: ("nombres-divisibilite", "logique-strategie"),
  difficulty: 3,
  content: [
    Mathilde a choisi un nombre. Elle lui a ajouté la somme de ses chiffres et a obtenu un deuxième nombre. Elle a ajouté à ce deuxième nombre la somme de SES chiffres, et a obtenu 60.

    Quel était le nombre choisi par Mathilde ?
  ],
  source: (
    organization: "FSJM",
    competition: "Quarts de finale",
    year: 2019,
    problem: 6,
    coefficient: 6,
    tracker_row: 1679,
    attribution: [FSJM, Quarts de finale 2019, problème n°6, coef. 6 · ligne 1679 de l'index],
  ),
  status: "published",
)
