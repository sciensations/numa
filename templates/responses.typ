#import "@preview/zebra:0.1.0": qrcode
#import "../lib/model.typ": published-exercises
#import "../lib/theme.typ": *

#let base-url = "https://lcnbr.github.io/numa"
#let _logo-path = "../assets/brand/numa-logo.png"

#let exercise-url(item) = base-url + "/e/" + item.id + ".html"

#let responses-document(selection) = {
  let exercises = published-exercises(selection.exercises)
  let count = exercises.len()
  let qr-size = if count <= 6 { 25mm } else { 21mm }
  assert(count >= 4 and count <= 8,
    message: "response sheets support four to eight exercises; " + selection.id
      + " has " + str(count))

  set page(width: 210mm, height: 297mm, margin: 10mm, fill: white)
  set text(font: print-fonts, lang: "fr", size: 9.5pt, fill: numa-ink)
  set par(justify: false, leading: 0.6em)

  grid(
    columns: (35mm, 1fr),
    align: (left + horizon, right + horizon),
    image(_logo-path, width: 32mm, alt: "Numa"),
    [
      #set text(size: 17pt, weight: "bold", fill: numa-blue-dark)
      Cherche, teste, explique !
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
    [*Date :* #box(width: 1fr, baseline: 1pt, line(length: 100%, stroke: 0.5pt))],
  )
  v(3mm)

  set table(stroke: 0.45pt + numa-muted.lighten(30%), inset: 2mm)
  table(
    columns: (1fr, 2fr, 1fr, 1fr),
    align: (center + horizon, left + top, center + horizon, center + horizon),
    table.header(
      table.cell(fill: numa-blue.lighten(65%))[*N°*],
      table.cell(fill: numa-blue.lighten(65%))[*Réponse et explication*],
      table.cell(fill: numa-blue.lighten(65%))[*Validation*],
      table.cell(fill: numa-blue.lighten(65%))[*QR*],
    ),
    ..exercises.enumerate().map(((index, item)) => (
      table.cell(fill: accent-for(item.serial).lighten(72%))[
        #box(height: 4mm, baseline: 3mm)[
          #text(font: "Noto Color Emoji", size: 8.5pt)[#item.emojis.join(h(1mm))]
        ]
        #h(1.2mm)
        #set text(size: 6.5pt, weight: "bold", fill: numa-blue-dark)
        #upper(item.id)
      ],
      [],
      [],
      [
        #qrcode(
          exercise-url(item),
          width: qr-size,
          quiet-zone: true,
          background-fill: white,
        )
      ],
      // [
      //   #set text(size: 5.5pt, fill: numa-muted)
      //   #link(exercise-url(item))[
      //     #text("https://lcnbr.github.io/")
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

  context {
    let pages = counter(page).final().first()
    assert(pages == 1,
      message: "response sheet for " + selection.id + " overflowed to " + str(pages) + " pages")
  }
}
