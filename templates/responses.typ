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
          width: 14mm,
          quiet-zone: true,
          background-fill: none,
        ),
        [ #set text(size: 8pt, weight: "regular", fill: numa-muted)
        ID #upper(item.id)])
}

#let qr-copies-per-exercise = 12

#let responses-document(selection) = {
  let exercises = published-exercises(selection.exercises)
  let count = exercises.len()
  let answer-row-height = if count <= 6 { 28mm } else { 21mm }
  assert(count >= 4 and count <= 8,
    message: "response sheets support four to eight exercises; " + selection.id
      + " has " + str(count))

  set page(height: 210mm, width: 297mm, margin: 20mm, fill: white)
  set text(font: print-fonts, lang: "fr", size: 9.5pt, fill: numa-ink)
  set par(justify: false, leading: 0.6em)

  
  let rep-fields = {
  
  grid(
    columns: (35mm, 1fr),
    align: (left + horizon, right + horizon),
    numa-logo(width: 26mm),
    [
      #set text(size: 16pt, weight: "bold", fill: numa-blue-dark)
      Feuille de réponses #upper(selection.id)\
      #set text(size: 7.3pt, weight: "regular", fill: numa-muted)
       #selection.title · #selection.date
    ],
  )
  v(0mm)

  grid(
    columns: (1fr, 1fr),
    gutter: 12mm,
    [*Prénom et nom :* #box(width: 1fr, baseline: 1pt, line(length: 100%, stroke: 0.5pt))],
    //[*Date :* #box(width: 1fr, baseline: 1pt, line(length: 100%, stroke: 0.5pt))],
  )

  set table(stroke: 0.45pt + numa-muted.lighten(30%), inset: 2mm)
  table(
    columns: (35mm, 3fr, 1fr),
    align: (center + horizon, left + top, center + horizon, center + horizon),
    table.header(
      table.cell(fill: numa-blue.lighten(65%))[*Problème*],
      table.cell(fill: numa-blue.lighten(65%))[*Réponse et explication*],
      table.cell(fill: numa-blue.lighten(65%))[*Validation*],
    ),
    ..exercises.enumerate().map(((index, item)) =>((table.cell(breakable: false,
    // inset: 4mm
  )[
        #set text(weight: "bold", fill: numa-blue-dark)
        #item.title
        #v(-3mm)
        #exercise-qrid(item)
      ],[],[]))).flatten(),
  )
  v(-2mm)
  align(right)[
    #set text(size: 7pt, fill: numa-muted)
    Scanne le code après la séance pour retrouver l’énoncé et les compléments.
  ]}

  grid(
    columns: 2,
    gutter: 40mm,
    rep-fields,
    rep-fields
  )

  

  pagebreak()

  table(
    columns: (35mm,35mm,35mm,35mm,35mm,35mm),
    // gutter: 4mm,
    align: center,
    ..exercises.map(item => ((table.cell(breakable: false,stroke: black.lighten(90%)
    // inset: 4mm
  )[
        #set text(weight: "bold", fill: numa-blue-dark)
        #item.title
        #v(-3mm)
        #exercise-qrid(item)
      ],) * qr-copies-per-exercise)).flatten(),
  )
}
