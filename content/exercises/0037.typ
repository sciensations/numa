#import "@preview/cetz:0.5.2"
#import "../../lib/model.typ": exercise
#import "../../lib/authoring.typ": exercise-diagram

#let item = exercise.with(
  title: [Trois figures, trois aires ?],
  topics: ("geometrie", "mesures"),
  difficulty: 1.5,
  content: [
    Sur le quadrillage, trois figures : un rectangle A, un triangle B et un parallélogramme C.

    Classe-les de la plus petite aire à la plus grande. Attention aux apparences !

    #exercise-diagram(alt: "Sur un même quadrillage : A est un rectangle de trois carreaux sur deux ; B un triangle rectangle de base quatre carreaux et de hauteur trois ; C un parallélogramme de base trois carreaux et de hauteur deux.")[
      #cetz.canvas(length: 6mm, {
        import cetz.draw: *
        for x in range(16) { line((x, 0), (x, 6), stroke: 0.3pt + luma(75%)) }
        for y in range(7) { line((0, y), (15, y), stroke: 0.3pt + luma(75%)) }
        line((1, 3), (4, 3), (4, 5), (1, 5), close: true, stroke: 1pt)
        line((5, 2), (9, 2), (5, 5), close: true, stroke: 1pt)
        line((10, 3), (13, 3), (14, 5), (11, 5), close: true, stroke: 1pt)
        content((2.5, 2.55), text(size: 9pt)[A])
        content((6.5, 1.55), text(size: 9pt)[B])
        content((12, 2.55), text(size: 9pt)[C])
      })
    ]
  ],
  source: (
    organization: "Numa",
    year: 2027,
    attribution: [Création Numa (échauffement)],
  ),
  status: "published",
)
