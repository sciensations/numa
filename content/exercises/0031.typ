#import "../../lib/model.typ": exercise
#import "../../lib/authoring.typ": exercise-diagram
#import "@preview/cetz:0.5.2"

#let item = exercise.with(
  title: [Le pentagone magique],
  topics: ("combinatoire", "optimisation",),
  difficulty: 3.75,
  content: [
    Écrivez dans les cercles les nombres de 1 à 10 de façon que, sur chacun des cinq côtés de la figure, la somme des trois nombres écrits dans les cercles soit toujours la même — et la plus petite possible.

    Quelle est cette somme, et comment placer les nombres ?

    #exercise-diagram(alt: "Pentagone avec dix cercles vides, un à chaque sommet et un au milieu de chaque côté. Le cercle du sommet supérieur est repéré a, ceux des côtés adjacents b à gauche et c à droite.")[
      #cetz.canvas(length: 5mm, {
        import cetz.draw: *
        let vertices = range(5).map(i => (
          2.7 * calc.cos(90deg + i * 72deg),
          2.7 * calc.sin(90deg + i * 72deg),
        ))
        line(..vertices, close: true, stroke: 0.6pt)
        for i in range(5) {
          let a = vertices.at(i)
          let b = vertices.at(calc.rem(i + 1, 5))
          circle(a, radius: 0.3, fill: white, stroke: 0.6pt)
          circle(((a.at(0) + b.at(0)) / 2, (a.at(1) + b.at(1)) / 2), radius: 0.3, fill: white, stroke: 0.6pt)
        }
        content((0, 3.35), [a])
        content((-1.45, 2.4), [b])
        content((1.45, 2.4), [c])
      })
    ]
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 1",
    year: 2012,
    problem: 8,
    coefficient: 8,
    tracker_row: 1283,
    attribution: [FSJM, Finale internationale 2012, jour 1, problème n°8, coef. 8 · ligne 1283 de l'index],
  ),
  status: "published",
)
