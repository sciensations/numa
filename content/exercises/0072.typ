#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Le nombre du jour],
  topics: ("arithmetique", "optimisation"),
  difficulty: 1.5,
  content: [
    Chaque jour de l'année 2009, Mathilde additionne les chiffres de la date. Par exemple le 1#super[er] janvier 2009 (1-1-2009) : $1 + 1 + 2 + 0 + 0 + 9 = 13$.

    Quel est le plus grand total que Mathilde puisse atteindre dans l'année ?
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 2",
    year: 2009,
    problem: 1,
    coefficient: 1,
    tracker_row: 1121,
    attribution: [FSJM, Finale internationale 2009, jour 2, problème n°1, coef. 1 · ligne 1121 de l'index],
  ),
  status: "published",
)
