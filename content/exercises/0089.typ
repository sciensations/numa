#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Les allumettes de l’année],
  topics: ("logique-strategie",),
  difficulty: 2,
  content: [
  On a disposé 20 allumettes comme sur le dessin. En enlevant 3 allumettes, on
peut lire les chiffres 2, 0, 1 et 4 — l’année du concours !


Chaque allumette appartient à un seul chiffre et il ne doit pas y avoir
d’allumette à l’intérieur du 0. On peut tourner la feuille pour lire un chiffre.

Quelles sont les trois allumettes à enlever ?
#align(center)[#image("../../assets/exercises/s07/allumettes.png", width:85%,height: 3.2cm,fit: "cover")]
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 1",
    year: 2014,
    problem: 4,
    coefficient: 4,
    tracker_row: 1384,
    attribution: [FSJM, Demi-finale 2014, problème n°4, coef. 4 · ligne 1384 de l’index],
  ),
  status: "published",
)
