#import "../../lib/model.typ": exercise
#let pyramid-table(size: 21pt, levels: 5) = {
  let columns = 2 * levels - 1

  let cell = grid.cell.with(
    fill: luma(235),
    stroke: 0.5pt + black,
    inset: 0pt,
    align: center + horizon,
  )

  // Generate all positioned cells.
  let cells = for y in range(levels) {
    let count = 2 * y + 1
    let x0 = levels - y - 1

    for i in range(count) {
      let number = y * y + i + 1

      let body = if y == levels - 1 and i >= 2 {
        [....]
      } else {
        [#number]
      }

      // Return a one-element array on each iteration.
      (
        cell(
          body,
          x: x0 + i,
          y: y,
        ),
      )
    }
  }

  grid(
    columns: (size,) * columns,
    rows: (size,) * levels,
    gutter: 0pt,
    ..cells,
  )
}


#let item = exercise(
  serial: 4,
  title: [La pyramide de Mathilde],
  topics: ("nombres-divisibilite", "suites-motifs"),
  difficulty: 3.25,
  statement_parts: (
    [
      Mathilde a construit une pyramide de nombres. Les nombres entiers à partir de 1 se succèdent comme le montre le dessin, qui représente les cinq étages du haut. La pyramide de Mathilde compte 22 étages.

      #align(center)[
        #pyramid-table()
      ]

      Combien de nombres impairs compte l'étage du bas ?


      
    ],
  ),
  source: (
    organization: "FSJM",
    competition: "Demi-finale",
    year: 2022,
    problem: 6,
    coefficient: 6,
    tracker_row: 1781,
    attribution: [FSJM, Demi-finale 2022, problème n°6, coef. 6 · ligne 1781 de l'index],
  ),
  hints: (),
  extra: none,
  solution: none,
  status: "published",
)
