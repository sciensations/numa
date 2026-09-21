#import "../../lib/model.typ": exercise
#import "../../lib/authoring.typ": exercise-diagram
#import "@preview/cetz:0.5.2"

#let item = exercise.with(
  title: [L'échiquier tronqué],
  topics: ("geometrie", "logique-strategie",),
  difficulty: 2.75,
  content: [
    On a retiré deux coins opposés d'un échiquier $8 times 8$ (voir figure) : il reste 62 cases. Tu disposes de 31 dominos, chacun couvrant exactement 2 cases voisines.

    Peut-on recouvrir exactement les 62 cases avec les 31 dominos ? Si oui, dessine ; si non, explique pourquoi c'est impossible.

    #exercise-diagram(alt: "Échiquier de huit lignes et huit colonnes alternant cases claires et sombres. La case en haut à droite et celle en bas à gauche sont retirées. À côté, un domino recouvre deux cases voisines.")[
      #cetz.canvas(length: 3.5mm, {
        import cetz.draw: *
        for x in range(8) {
          for y in range(8) {
            if not ((x == 0 and y == 0) or (x == 7 and y == 7)) {
              rect((x, y), (x + 1, y + 1), fill: if calc.even(x + y) { luma(65) } else { white }, stroke: 0.4pt)
            }
          }
        }
        for (x, y) in ((0, 0), (7, 7)) {
          line((x + 0.15, y + 0.15), (x + 0.85, y + 0.85), stroke: 0.8pt + red)
          line((x + 0.15, y + 0.85), (x + 0.85, y + 0.15), stroke: 0.8pt + red)
        }
        rect((9.2, 3.5), (11.2, 4.5), fill: white, stroke: 0.7pt)
        line((10.2, 3.5), (10.2, 4.5), stroke: 0.7pt)
        content((10.2, 2.6), text(size: 7pt)[un domino])
      })
    ]
  ],
  source: (
    organization: "Cercles mathématiques",
    competition: none,
    year: 1946,
    problem: none,
    coefficient: none,
    tracker_row: none,
    attribution: [Problème classique des cercles mathématiques (Max Black, 1946)],
  ),
  status: "published",
)
