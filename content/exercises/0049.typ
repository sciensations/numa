#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Les trois nombres],
  topics: ("combinatoire", "arithmetique"),
  difficulty: 3.5,
  content: [
    Marion cherche tous les nombres de quatre chiffres TOUS DIFFÉRENTS que l'on peut composer avec les chiffres 1, 2, 4 et 7. Elle en choisit trois différents, les additionne, et obtient 13 983.

    Quels sont ces trois nombres, du plus petit au plus grand ? (Indique aussi combien de réponses différentes existent !)
  ],
  source: (
    organization: "FSJM",
    competition: "Demi-finale",
    year: 2007,
    problem: 7,
    coefficient: 7,
    tracker_row: 965,
    attribution: [FSJM, Demi-finale 2007, problème n°7, coef. 7 · ligne 965 de l'index],
  ),
  status: "published",
)
