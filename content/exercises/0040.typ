#import "../../lib/model.typ": exercise
#import "../../lib/authoring.typ": exercise-diagram

#let item = exercise.with(
  title: [Découpage pour un carré],
  topics: ("geometrie", "logique-strategie"),
  difficulty: 3,
  content: [
    Mathias veut découper ce rectangle de 9 carreaux sur 4 en DEUX morceaux, puis les juxtaposer pour former un carré.

    Trace la ligne de découpe (elle suit les lignes du quadrillage).

    #exercise-diagram(alt: "Rectangle composé de neuf colonnes et quatre rangées de carreaux carrés.")[
      #table(columns: (7mm,) * 9, rows: (7mm,) * 4, inset: 0pt, stroke: 0.6pt, ..range(36).map(_ => []))
    ]
  ],
  source: (
    organization: "FSJM",
    competition: "Quarts de finale",
    year: 2017,
    problem: 6,
    coefficient: 6,
    tracker_row: 1574,
    attribution: [FSJM, Quarts de finale 2017, problème n°6, coef. 6 · ligne 1574 de l'index],
  ),
  status: "published",
)
