#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Une suite incertaine],
  topics: ("combinatoire", "optimisation"),
  difficulty: 4,
  content: [
    Un jeu de 52 cartes : 4 couleurs, 13 valeurs (2, 3, …, 10, valet, dame, roi, as ; l'as suit le roi mais n'est pas suivi par le 2).

    Combien de cartes peut-on tirer, au maximum, sans jamais avoir 5 cartes dont les valeurs se suivent ?
  ],
  source: (
    organization: "FSJM",
    competition: "Quarts de finale",
    year: 2021,
    problem: 9,
    coefficient: 9,
    tracker_row: 1766,
    attribution: [FSJM, Quarts de finale 2021, problème n°9, coef. 9 · ligne 1766 de l'index],
  ),
  status: "published",
)
