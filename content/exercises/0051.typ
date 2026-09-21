#import "../../lib/model.typ": exercise
#import "../../lib/authoring.typ": exercise-diagram

#let item = exercise.with(
  title: [Les rectangles cachés],
  topics: ("combinatoire", "geometrie"),
  difficulty: 2.25,
  content: [
    Combien de rectangles (les carrés comptent aussi !) peut-on tracer en suivant les lignes de cette grille de 3 × 4 cases ?

    Attention : il y en a beaucoup plus que 12…

    #exercise-diagram(alt: "Grille de quatre colonnes et trois rangées de cases carrées.")[
      #table(columns: (8mm,) * 4, rows: (8mm,) * 3, inset: 0pt, stroke: 0.6pt, ..range(12).map(_ => []))
    ]
  ],
  source: (
    organization: "Numa",
    year: 2027,
    attribution: [Création Numa],
  ),
  status: "published",
)
