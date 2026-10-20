#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Les piles],
  topics: ("logique-strategie",),
  difficulty: 2,
  content: [
  Six piles sont alignées comme sur le dessin.
  
Tant que deux piles voisines ont leurs bouts « + » face à face, elles font toutes
les deux demi-tour en même temps. Ce double demi-tour compte pour une opération.

Quand plus aucune opération n’est possible, combien d’opérations a-t-on
comptées ?

#align(center)[#image("../../assets/exercises/s07/piles.png", width:100%,height: 1cm,fit: "cover")]
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 1",
    year: 2018,
    problem: 3,
    coefficient: 3,
    tracker_row: 1605,
    attribution: [FSJM, Finale internationale 2018, jour 1, problème n°3, coef. 3 · ligne 1605 de l’index],
  ),
  status: "published",
)

