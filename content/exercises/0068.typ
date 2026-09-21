#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Devine nombres],
  topics: ("arithmetique", "algebre"),
  difficulty: 3,
  content: [
    Dans une liste de cinq nombres, le premier est 20 et le dernier 12. Le produit des trois premiers est 360, le produit des trois du milieu est 90, le produit des trois derniers est 180.

    Trouve les trois nombres manquants.
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 2",
    year: 2012,
    problem: 6,
    coefficient: 6,
    tracker_row: 1299,
    attribution: [FSJM, Finale internationale 2012, jour 2, problème n°6, coef. 6 · ligne 1299 de l'index],
  ),
  status: "published",
)
