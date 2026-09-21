#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [La liste de Mathias],
  topics: ("arithmetique", "suites-motifs",),
  difficulty: 2.75,
  content: [
    Mathias écrit les numéros des années à partir de 2009, à la suite les uns des autres : 20092010201120122013…

    Il s'arrête lorsqu'il a écrit le 2012#super[e] chiffre. Quels sont les 4 derniers chiffres écrits ?
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 2",
    year: 2009,
    problem: 5,
    coefficient: 5,
    tracker_row: 1124,
    attribution: [FSJM, Finale internationale 2009, jour 2, problème n°5, coef. 5 · ligne 1124 de l'index],
  ),
  status: "published",
)
