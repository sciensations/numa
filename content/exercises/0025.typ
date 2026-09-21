#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Palindrome],
  topics: ("nombres-divisibilite", "logique-strategie",),
  difficulty: 2.5,
  content: [
    On écrit les dates sous la forme « jjmmaaaa » : le 1#super[er] février 2010 s'écrit 01022010. Ce nombre, qui se lit pareil de gauche à droite et de droite à gauche, est un palindrome.

    Quelle sera la prochaine date palindrome (après le 1#super[er] février 2010) ?
  ],
  source: (
    organization: "FSJM",
    competition: "Quarts de finale",
    year: 2011,
    problem: 4,
    coefficient: 4,
    tracker_row: 1265,
    attribution: [FSJM, Quarts de finale 2011, problème n°4, coef. 4 · ligne 1265 de l'index],
  ),
  status: "published",
)
