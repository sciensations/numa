#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Deux menteurs sur trois],
  topics: ("logique-strategie",),
  difficulty: 2,
  content: [
    Abel : « Pendant ces vacances, j'ai lu au moins quatre livres. »

    Béatrice : « Non, tu en as lu moins de quatre ! »

    Camille : « Je dirais qu'Abel en a lu au moins deux. »

    Un seul des trois amis n'a pas menti. Combien Abel a-t-il lu de livres, sachant qu'il en a lu au moins un ?

        #align(center)[#image("../../assets/exercises/s05/livress05.png", width:35%)]
  ],
  source: (
    organization: "FSJM",
    competition: "Quarts de finale",
    year: 2013,
    problem: 3,
    coefficient: 3,
    tracker_row: 1366,
    attribution: [FSJM, Quarts de finale 2013, problème n°3, coef. 3 · ligne 1366 de l'index],
  ),
  status: "published",
)
