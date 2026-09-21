#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Le partage de la tablette],
  topics: ("geometrie", "combinatoire"),
  difficulty: 3.25,
  content: [
    Mathias a une tablette de chocolat de 4 carrés sur 5. Il la partage entre lui et ses trois copains : chacun reçoit un morceau d'un seul tenant, tous les morceaux ont la même forme et sont faits de carrés entiers.

    Combien de formes différentes le morceau peut-il avoir ? (On peut retourner un morceau pour comparer les formes.)
  ],
  source: (
    organization: "FSJM",
    competition: "Demi-finale",
    year: 2021,
    problem: 5,
    coefficient: 5,
    tracker_row: 1730,
    attribution: [FSJM, Demi-finale 2021, problème n°5, coef. 5 · ligne 1730 de l'index],
  ),
  status: "published",
)
