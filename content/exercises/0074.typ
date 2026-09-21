#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [L'âge de Mathilde],
  topics: ("arithmetique", "suites-motifs"),
  difficulty: 2.25,
  content: [
    Mathilde écrit son âge : 11. Puis elle répète sans fin la même opération : additionner les chiffres du dernier nombre écrit, multiplier le résultat par 7, écrire le nouveau nombre. Les trois premiers nombres écrits sont 11 ; 14 ; 35.

    Quel sera le 37#super[e] nombre écrit ?
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 1",
    year: 2009,
    problem: 3,
    coefficient: 3,
    tracker_row: 1106,
    attribution: [FSJM, Finale internationale 2009, jour 1, problème n°3, coef. 3 · ligne 1106 de l'index],
  ),
  status: "published",
)
