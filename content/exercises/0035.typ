#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [En partant de 2008],
  topics: ("arithmetique", "suites-motifs",),
  difficulty: 3.25,
  content: [
    Noémie joue au jeu suivant : un nombre est écrit. S'il est pair, elle le divise par 2 et écrit le résultat. S'il est impair, elle lui ajoute 9, divise le tout par 2, et écrit le résultat. Elle recommence jusqu'à obtenir 1 pour la première fois.

    Aujourd'hui, le premier nombre écrit était 2008. Combien de nombres sont écrits en tout ?
  ],
  source: (
    organization: "FSJM",
    competition: "Quarts de finale",
    year: 2008,
    problem: 7,
    coefficient: 7,
    tracker_row: 1080,
    attribution: [FSJM, Quarts de finale 2008, problème n°7, coef. 7 · ligne 1080 de l'index],
  ),
  status: "published",
)
