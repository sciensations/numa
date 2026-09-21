#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Devine-pièce],
  topics: ("logique-strategie", "optimisation"),
  difficulty: 3,
  content: [
    Pif joue avec quatre pièces dont les huit faces sont numérotées de 1 à 8 (un chiffre par face). Il les jette trois fois et lit : 6, 1, 4, 3 (total 14) ; puis 1, 3, 5, 7 (total 16) ; puis 3, 7, 2, 6 (total 18).

    S'il les jette une quatrième fois, quel sera, au maximum, le total des quatre nombres lus ?
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 1",
    year: 2011,
    problem: 5,
    coefficient: 5,
    tracker_row: 1207,
    attribution: [FSJM, Finale internationale 2011, jour 1, problème n°5, coef. 5 · ligne 1207 de l'index],
  ),
  status: "published",
)
