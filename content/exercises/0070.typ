#import "../../lib/authoring.typ": exercise-diagram
#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Le carré super-magique],
  topics: ("nombres-divisibilite", "algebre"),
  difficulty: 3.75,
  content: [
    Écris un nombre entier dans chaque case du carré $3 times 3$ de façon que : sur chaque ligne et chaque colonne, le produit des trois nombres soit 144 ; et dans chacun des quatre carrés $2 times 2$, le produit des quatre nombres soit 864.

    #exercise-diagram(alt: "Une grille vierge de trois lignes et trois colonnes.")[
      #grid(
        columns: (11mm,) * 3,
        rows: (11mm,) * 3,
        stroke: 0.6pt,
        ..(([],) * 9),
      )
    ]
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 1",
    year: 2012,
    problem: 7,
    coefficient: 7,
    tracker_row: 1282,
    attribution: [FSJM, Finale internationale 2012, jour 1, problème n°7, coef. 7 · ligne 1282 de l'index],
  ),
  status: "published",
)
