#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Les amis d'Antoine],
  topics: ("combinatoire", "logique-strategie",),
  difficulty: 1,
  content: [
    Antoine a beaucoup d'amis. 15 de ses amis aiment résoudre des sudokus, et 18 aiment les opérations codées.

    Si on sait que 3 de ses amis aiment les deux types de jeux, combien Antoine a-t-il d'amis qui aiment les jeux (sudokus ou opérations codées) ?
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 1",
    year: 2025,
    problem: 1,
    coefficient: 1,
    tracker_row: 2017,
    attribution: [FSJM, Finale internationale 2025, jour 1, problème n°1, coef. 1 · ligne 2017 de l'index],
  ),
  status: "published",
)
