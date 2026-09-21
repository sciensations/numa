#import "@preview/cetz:0.5.2"
#import "../../lib/model.typ": exercise
#import "../../lib/authoring.typ": exercise-diagram

#let item = exercise.with(
  title: [Les chemins de la ville],
  topics: ("combinatoire", "geometrie"),
  difficulty: 1.75,
  content: [
    Dans cette petite ville, les rues forment un quadrillage. On part de A (en haut à gauche) et on va vers B (en bas à droite), en marchant seulement vers la droite ou vers le bas.

    Combien y a-t-il de chemins différents ?

    #exercise-diagram(alt: "Rues dessinant une grille de deux colonnes et deux rangées de cases. A est au coin supérieur gauche ; B au coin inférieur droit.")[
      #cetz.canvas(length: 12mm, {
        import cetz.draw: *
        for k in range(3) {
          line((0, k), (2, k), stroke: 0.8pt)
          line((k, 0), (k, 2), stroke: 0.8pt)
        }
        circle((0, 2), radius: 0.08, fill: rgb("2c8aa5"), stroke: none)
        circle((2, 0), radius: 0.08, fill: rgb("f26d50"), stroke: none)
        content((-0.2, 2.15), text(size: 9pt)[A])
        content((2.2, -0.15), text(size: 9pt)[B])
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
