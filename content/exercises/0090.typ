#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Les sept pièces],
  topics: ("logique-strategie",),
  difficulty: 3,
  content: [
  Sept pièces de monnaie sont alignées, toutes tournées côté pile. À chaque
coup, on retourne en même temps trois pièces, choisies comme on veut.

Combien de coups faut-il, au minimum, pour que les sept pièces soient toutes
côté face ?

#align(center)[#image("../../assets/exercises/s07/pieces.png", width:90%,height: 3cm,fit: "cover")]
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 1",
    year: 1998,
    problem: 5,
    coefficient: 5,
    tracker_row: 463,
    attribution: [FSJM, Demi-finale 1998, problème n°5, coef. 5 · ligne 463 de l’index ],
  ),
  status: "published",
)
