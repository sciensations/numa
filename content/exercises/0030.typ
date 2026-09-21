#import "../../lib/model.typ": exercise
#import "../../lib/authoring.typ": exercise-diagram

#let item = exercise.with(
  title: [Les timbres],
  topics: ("combinatoire", "arithmetique",),
  difficulty: 3.5,
  content: [
    Mathilde dispose des six timbres représentés ci-dessous (3 ludos, 3 ludos, 5 ludos, 5 ludos, 9 ludos et 9 ludos).

    En utilisant au maximum quatre de ces timbres, elle peut réaliser toutes les sommes de 8 ludos à 26 ludos, sauf une. Laquelle ?

    #exercise-diagram(alt: "Six timbres : deux de 3 ludos, deux de 5 ludos et deux de 9 ludos.")[
      #grid(
        columns: (15mm,) * 6,
        gutter: 2mm,
        ..(3, 3, 5, 5, 9, 9).map(value => box(
          width: 15mm, height: 18mm, inset: 1.5mm,
          stroke: (paint: black, thickness: 0.5pt, dash: "dotted"),
        )[
          #block(width: 100%, height: 100%, stroke: 0.4pt, inset: 1mm)[
            #align(center + horizon)[#text(size: 15pt)[#value] #linebreak() #text(size: 7pt)[ludos]]
          ]
        ]),
      )
    ]
  ],
  source: (
    organization: "FSJM",
    competition: "Quarts de finale",
    year: 2011,
    problem: 7,
    coefficient: 7,
    tracker_row: 1267,
    attribution: [FSJM, Quarts de finale 2011, problème n°7, coef. 7 · ligne 1267 de l'index],
  ),
  status: "published",
)
