#import "../../lib/model.typ": exercise

#let item = exercise(
  serial: 10,
  title: [Devine âge],
  topics: ("arithmetique",),
  difficulty: 1.5,
  content: [
    Il y a deux ans, Alice et Alain avaient 20 ans à eux deux. Aujourd'hui, Alain a 10 ans.

    Quel est l'âge d'Alice ?
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 2",
    year: 2010,
    problem: 3,
    coefficient: 3,
    tracker_row: 1169,
    attribution: [FSJM, Finale internationale 2010, jour 2, problème n°3, coef. 3 · ligne 1169 de l'index],
  ),
  hints: (),
  extra: none,
  solution: none,
  status: "published",
)
