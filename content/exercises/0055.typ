#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Le poids des mots, le choc des plateaux],
  topics: ("mesures", "nombres-divisibilite"),
  difficulty: 3,
  content: [
    Avec sept masses marquées de 1 g, 3 g, 9 g, 27 g, 81 g, 243 g et 729 g, on peut peser n'importe quel objet de 1 à 1093 g, gramme par gramme — à condition d'avoir le droit de poser des masses des DEUX côtés de la balance. Par exemple, pour 15 g : l'objet et les masses 9 + 3 d'un côté, la masse 27 de l'autre ($15 = 27 - 9 - 3$).

    Donne la composition de chaque plateau pour peser un objet de 418 g (posé sur le plateau de droite).
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 2",
    year: 1993,
    problem: 4,
    coefficient: 4,
    tracker_row: 214,
    attribution: [FSJM, Finale internationale 1993, jour 2, problème n°4, coef. 4 · ligne 214 de l'index],
  ),
  status: "published",
)
