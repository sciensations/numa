#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Drôle de rectangle],
  topics: ("geometrie", "nombres-divisibilite"),
  difficulty: 3.5,
  content: [
    Un rectangle non carré a des dimensions qui sont des nombres entiers de centimètres. Mathilde calcule son aire (en cm²), Mathias son périmètre (en cm).

    Surprise : ils obtiennent le même nombre ! Quelle est la longueur du rectangle ?
  ],
  source: (
    organization: "FSJM",
    competition: "Quarts de finale",
    year: 2013,
    problem: 8,
    coefficient: 8,
    tracker_row: 1371,
    attribution: [FSJM, Quarts de finale 2013, problème n°8, coef. 8 · ligne 1371 de l'index],
  ),
  status: "published",
)
