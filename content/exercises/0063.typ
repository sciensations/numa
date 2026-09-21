#import "@preview/cetz:0.5.2"
#import "../../lib/authoring.typ": exercise-diagram
#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Le cube d'un seul trait],
  topics: ("geometrie", "logique-strategie"),
  difficulty: 3.75,
  content: [
    Voici le squelette d'un cube : 8 sommets, 12 arêtes.

    Une fourmi peut-elle parcourir TOUTES les arêtes une et une seule fois ? Prouve ta réponse. Et si elle a le droit d'en sauter une ?

    #exercise-diagram(alt: "Squelette d'un cube avec ses huit sommets marqués et ses douze arêtes, toutes tracées en trait plein.")[
      #cetz.canvas(length: 8mm, {
        import cetz.draw: *
        let front = ((0, 0), (2.8, 0), (2.8, 2.8), (0, 2.8))
        let back = ((1, 1.2), (3.8, 1.2), (3.8, 4), (1, 4))
        set-style(stroke: 0.8pt)
        line(..front, close: true)
        line(..back, close: true)
        for i in range(4) { line(front.at(i), back.at(i)) }
        for point in front + back {
          circle(point, radius: 0.12, fill: rgb("#1b4f66"), stroke: none)
        }
      })
    ]
  ],
  source: (
    organization: "Numa",
    competition: none,
    year: none,
    problem: none,
    coefficient: none,
    tracker_row: none,
    attribution: [Création Numa],
  ),
  status: "published",
)
