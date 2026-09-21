#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Le code],
  topics: ("nombres-divisibilite", "logique-strategie"),
  difficulty: 4.0,
  content: [
    Chacun des chiffres de 1 à 6 est utilisé une fois pour former le code du coffre-fort de Picsou. Ce nombre de 6 chiffres est pair. Pour chaque paire de chiffres voisins, l'un est multiple de l'autre.

    Quel est le code du coffre-fort ?
  ],
  source: (
    organization: "FSJM",
    competition: "Quarts de finale",
    year: 2010,
    problem: 7,
    coefficient: 7,
    tracker_row: 1189,
    attribution: [FSJM, Quarts de finale 2010, problème n°7, coef. 7 · ligne 1189 de l'index],
  ),
  hints: (),
  extra: none,
  solution: none,
  status: "published",
)
