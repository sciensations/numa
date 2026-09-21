#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Dans le noir],
  topics: ("logique-strategie", "combinatoire",),
  difficulty: 1.25,
  content: [
    Lou sait qu'une boîte contient 6 crayons bleus et 3 crayons rouges. Malheureusement, l'éclairage ne permet pas de distinguer les couleurs.

    Combien de crayons doit-elle prendre, au minimum, pour être sûre d'emporter au moins un crayon de chaque couleur ?
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 1",
    year: 2018,
    problem: 1,
    coefficient: 1,
    tracker_row: 1603,
    attribution: [FSJM, Finale internationale 2018, jour 1, problème n°1, coef. 1 · ligne 1603 de l'index],
  ),
  status: "published",
)
