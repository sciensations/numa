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

#let qr-stickers(selection,rows: 2,columns:7) = {
  
  let exercises = published-exercises(selection)
  // set par(justify: false, leading: 0.6em)

  
  

  table(
    columns: (35mm,)*columns,
    
    // gutter: 4mm,
    align: center,
    ..exercises.map(item => ((table.cell(breakable: false,stroke: black.lighten(90%)
    // inset: 4mm
  )[
        #set text(weight: "bold", fill: numa-blue-dark)
        #item.title
        #v(-3mm)
        #exercise-qrid(item)
      ],) * rows*columns)).flatten(),
  )
}

#import "../content/exercise-registry.typ": exercise-at

#let serials = (85,86,87)

#set page(height: 210mm, width: 297mm, margin: 20mm, fill: white)
#set text(font: print-fonts, lang: "fr", size: 9.5pt, fill: numa-ink)

#qr-stickers(serials.map(exercise-at))
