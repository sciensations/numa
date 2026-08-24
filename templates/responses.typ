#import "@preview/zebra:0.1.0": qrcode
#import "../lib/logo.typ": numa-logo
#import "../lib/model.typ": published-exercises
#import "../lib/theme.typ": *

#let base-url = "https://sciensations.github.io/numa"

#let exercise-url(item) = base-url + "/e/" + item.id + ".html"

#let exercise-qrid(item)={
  grid(
    align: center,
    
  qrcode(
          exercise-url(item),
          width: 20mm,
          quiet-zone: true,
          background-fill: none,
        ),
        [ #set text(size: 8pt, weight: "regular", fill: numa-muted)
        ID #upper(item.id)])
}

#let responses-document(selection, expected-pages: 2) = {
  let exercises = published-exercises(selection.exercises)
  let count = exercises.len()
  let answer-row-height = if count <= 6 { 28mm } else { 21mm }
  assert(count >= 4 and count <= 8,
    message: "response sheets support four to eight exercises; " + selection.id
      + " has " + str(count))

  set page(width: 210mm, height: 297mm, margin: 10mm, fill: white)
  set text(font: print-fonts, lang: "fr", size: 9.5pt, fill: numa-ink)
  set par(justify: false, leading: 0.6em)

  grid(
    columns: (35mm, 1fr),
    align: (left + horizon, right + horizon),
    numa-logo(width: 32mm),
    [
      #set text(size: 17pt, weight: "bold", fill: numa-blue-dark)
      Feuille de réponses
      #linebreak()
      #set text(size: 9pt, weight: "regular", fill: numa-muted)
      #upper(selection.id) · #selection.title · #selection.date
    ],
  )
  v(4mm)

  grid(
    columns: (1fr, 1fr),
    gutter: 12mm,
    [*Prénom et nom :* #box(width: 1fr, baseline: 1pt, line(length: 100%, stroke: 0.5pt))],
    //[*Date :* #box(width: 1fr, baseline: 1pt, line(length: 100%, stroke: 0.5pt))],
  )
  v(3mm)

  set table(stroke: 0.45pt + numa-muted.lighten(30%), inset: 2mm)
  table(
    columns: (1fr, 2fr, 1fr),
    align: (center + horizon, left + top, center + horizon, center + horizon),
    table.header(
      table.cell(fill: numa-blue.lighten(65%))[*Problème*],
      table.cell(fill: numa-blue.lighten(65%))[*Réponse et explication*],
      table.cell(fill: numa-blue.lighten(65%))[*Validation*],
    ),
    ..exercises.enumerate().map(((index, item)) => (
      table.cell(fill: accent-for(item.serial).lighten(72%))[
        #block(height: answer-row-height)[
          #set text(weight: "bold", fill: numa-blue-dark)
          #(index + 1) · #item.title
          #linebreak()
          #text(size: 6.5pt, weight: "regular")[ID #upper(item.id)]
        ]
      ],
      [],
      [],
      // [
      //   #set text(size: 5.5pt, fill: numa-muted)
      //   #link(exercise-url(item))[
      //     #text("https://sciensations.github.io/")
      //     #linebreak()
      //     #text("numa/e/" + item.id + ".html")
      //   ]
      // ],
    )).flatten(),
  )

  v(2mm)
  align(right)[
    #set text(size: 7pt, fill: numa-muted)
    Scanne le code après la séance pour retrouver l’énoncé et les compléments.
  ]

  

  pagebreak()

  table(
    columns: (1fr,1fr,1fr,1fr),
    align: center,
    ..exercises.map(item => (table.cell(breakable: false)[
        #set text(weight: "bold", fill: numa-blue-dark)
        #item.title
        #v(-3mm)
        #exercise-qrid(item)
      ],)).flatten(),
  )

  if expected-pages != none {
    context {
      let pages = counter(page).final().first()
      assert(pages == expected-pages,
        message: "response pack for " + selection.id + " must have " + str(expected-pages) + " pages; found " + str(pages))
    }
  }
}
