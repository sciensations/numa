#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Les palindromes],
  topics: ("nombres-divisibilite", "logique-strategie",),
  difficulty: 2,
  content: [
    Un palindrome est un nombre qui se lit pareil dans les deux sens (par exemple 33).

    Le Mage Hic demande à Paul de choisir, entre 10 et 99, des entiers qui se suivent sans interruption.

    Combien de nombres doit-il lui demander, au minimum, pour être sûr qu'il y ait au moins un palindrome parmi eux ?
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 2",
    year: 2018,
    problem: 3,
    coefficient: 3,
    tracker_row: 1623,
    attribution: [FSJM, Finale internationale 2018, jour 2, problème n°3, coef. 3 · ligne 1623 de l'index],
  ),
  status: "published",
)
