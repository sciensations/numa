#import "@preview/zebra:0.1.0": qrcode
#import "../../lib/logo.typ": numa-logo
#import "../../lib/model.typ": published-exercises
#import "../../lib/theme.typ": *

#{
  
set page(height: 210mm, width: 297mm, margin: 20mm, fill: white)
  set text(font: print-fonts, lang: "fr", size: 9.5pt, fill: numa-ink)
  set par(justify: false, leading: 0.6em)

  
  let rep-fields = {
  grid(columns: 1,row-gutter: 3mm,rows: (auto, auto, 1fr, auto),
  grid(
    columns: (35mm, 1fr),
    align: (left + horizon, right + horizon),
    numa-logo(width: 26mm),
    [
      #set text(size: 15.5pt, weight: "bold", fill: numa-blue-dark)
      Problèmes supplémentaires
    ],
  ),
  grid(
    columns: (1fr, 1fr),
    gutter: 12mm,
    [*Prénom et nom :* #box(width: 1fr, baseline: 1pt, line(length: 100%, stroke: 0.5pt))],
    //[*Date :* #box(width: 1fr, baseline: 1pt, line(length: 100%, stroke: 0.5pt))],
  ),{

  set table(stroke: 0.45pt + numa-muted.lighten(30%), inset: 2mm)
  table(
    columns: (35mm, 3fr, 1fr),
    rows: (auto,1fr,1fr,1fr,1fr,1fr),
    
    align: (center + horizon, left + top, center + horizon, center + horizon),
    table.header(
      table.cell(fill: numa-blue.lighten(65%))[*Problème*],
      table.cell(fill: numa-blue.lighten(65%))[*Réponse et explication*],
      table.cell(fill: numa-blue.lighten(65%))[*Validation*],
    ),
    ..([],)*15,
  )},
  align(right)[
    #set text(size: 7pt, fill: numa-muted)
    Scanne le code après la séance pour retrouver l’énoncé et les compléments.
  ])}

  grid(
    columns: 2, rows: (170mm,),
    gutter: 40mm,
    rep-fields,
    rep-fields
  )

}