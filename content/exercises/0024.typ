#import "../../lib/model.typ": exercise
#import "../../lib/authoring.typ": exercise-diagram
#import "@preview/cetz:0.5.2"

#let item = exercise.with(
  title: [Carrés blancs],
  topics: ("geometrie", "combinatoire",),
  difficulty: 2.5,
  content: [
    Combien la figure compte-t-elle de carrés entièrement dessinés ne contenant pas de gris ?

    Note : un carré peut être constitué d'un seul petit carré ou de plusieurs petits carrés réunis.

    #exercise-diagram(alt: "Grille carrée de six lignes et six colonnes, avec un petit losange gris recouvrant la partie centrale des quatre cases du milieu.")[
      #cetz.canvas(length: 5mm, {
        import cetz.draw: *
        for i in range(7) {
          line((i, 0), (i, 6), stroke: (if i == 1 { 0.7pt } else { 0.4pt }))
          line((0, i), (6, i), stroke: (if i == 3 { 0.7pt } else { 0.4pt }))
        }
        line((3, 3.75), (3.75, 3), (3, 2.25), (2.25, 3), close: true, fill: luma(140), stroke: 0.6pt)
      })
    ]
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 2",
    year: 2009,
    problem: 4,
    coefficient: 4,
    tracker_row: 1123,
    attribution: [FSJM, Finale internationale 2009, jour 2, problème n°4, coef. 4 · ligne 1123 de l'index],
  ),
  status: "published",
)
