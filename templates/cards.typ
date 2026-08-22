#import "../lib/model.typ": published-exercises, source-attribution
#import "../lib/theme.typ": *

#let _logo-path = "../assets/brand/numa-logo.png"

#let _front-body(item) = {
  let statement = item.statement_parts.first()
  if item.figure == none {
    statement
  } else {
    grid(
      columns: (1.9fr, 1fr),
      gutter: 4mm,
      statement,
      align(center + horizon)[
        #image(
          "../" + item.figure.path,
          width: 100%,
          height: 49mm,
          fit: "contain",
          alt: item.figure.alt,
        )
      ],
    )
  }
}

#let _exercise-side(item, continuation: false) = {
  let accent = accent-for(item.serial)
  let heading-text = if continuation { [#item.title · _suite_] } else { item.title }
  let statement = if continuation { item.statement_parts.at(1) } else { _front-body(item) }
  let heading-block = block(
    width: 100%,
    fill: accent.lighten(58%),
    inset: 4mm,
    radius: 2.5mm,
  )[
    #grid(
      columns: (1fr, auto),
      gutter: 3mm,
      align(left + horizon)[
        #set text(size: 14pt, weight: "bold", fill: numa-blue-dark)
        #heading-text
      ],
      align(right + horizon)[
        #set text(size: 7pt, weight: "regular", fill: numa-muted)
        ID #upper(item.id)
      ],
    )
  ]
  let statement-block = block(width: 100%,inset:4mm)[
    #set text(size: 10.5pt)
    #show table: it => align(center, it)
    #align(left)[#statement]
  ]
  let source-block = block(width: 100%)[
    #set text(size: 7pt, weight: "light", fill: numa-muted)
    #align(right)[#emph(source-attribution(item.source))]
  ]
  let natural = block(width: 136mm)[
    #heading-block
    #v(2.8mm)
    #statement-block
    #v(2.8mm)
    #source-block
  ]

  layout(_ => {
    let measured = measure(natural)
    // assert(measured.height <= 93mm,
    //   message: "card side overflows for " + item.id + " ("
    //     + str(calc.round(measured.height / 1mm, digits: 1)) + "mm > 93mm)")
    block(
      width: 148mm,
      height: 105mm,
      inset: 6mm,
      stroke: 0.3pt + numa-muted.lighten(35%),
      fill: numa-paper,
    )[
      #grid(
        columns: (1fr,),
        rows: (auto, 1fr, auto),
        row-gutter: 2.8mm,
        heading-block,
        statement-block,
        source-block,
      )
    ]
  })
}

#let _branded-back(item) = {
  let accent = accent-for(item.serial)
  block(
    width: 148mm,
    height: 105mm,
    inset: 6mm,
    stroke: 0.3pt + numa-muted.lighten(35%),
    fill: numa-paper,
  )[
    #block(
      width: 100%,
      height: 100%,
      fill: accent.lighten(68%),
      radius: 3mm,
      inset: 7mm,
    )[
      #align(center + horizon)[
        #image(_logo-path, width: 52mm, alt: "Numa")
        #v(7mm)
        #set text(size: 13pt, weight: "bold", fill: numa-blue-dark)
        Cherche, teste, explique !
        #v(4mm)
        #set text(size: 8pt, weight: "regular", fill: numa-muted)
        ID #upper(item.id)
      ]
    ]
  ]
}

#let _blank-cell() = block(
  width: 148mm,
  height: 105mm,
  stroke: 0.3pt + numa-muted.lighten(35%),
)

#let _front(item) = if item == none { _blank-cell() } else { _exercise-side(item) }

#let _back(item) = if item == none {
  _blank-cell()
} else if item.statement_parts.len() == 2 {
  _exercise-side(item, continuation: true)
} else {
  _branded-back(item)
}

#let _sheet(cells) = {
  assert(cells.len() == 4, message: "an imposed card sheet needs exactly four cells")
  block(width: 297mm, height: 210mm)[
    #align(center + top)[
      #grid(
        columns: (148mm, 148mm),
        rows: (105mm, 105mm),
        column-gutter: 0mm,
        row-gutter: 0mm,
        ..cells,
      )
    ]
    // Trim ticks stay outside the 6mm safe area. The outer card edges nearly
    // coincide with the paper edges, so only the internal cuts need marks.
    #place(top + left, dx: 148.5mm)[#line(length: 4mm, angle: 90deg, stroke: 0.35pt)]
    #place(bottom + left, dx: 148.5mm)[#line(length: 4mm, angle: -90deg, stroke: 0.35pt)]
    #place(top + left, dy: 105mm)[#line(length: 4mm, stroke: 0.35pt)]
    #place(top + right, dy: 105mm)[#line(length: 4mm, angle: 180deg, stroke: 0.35pt)]
  ]
}

#let cards-document(items) = {
  let exercises = published-exercises(items)
  assert(exercises.len() > 0, message: "cannot make cards for an empty batch")
  let sheet-count = calc.ceil(exercises.len() / 4)

  set page(width: 297mm, height: 210mm, margin: 0mm, fill: white)
  set text(font: print-fonts, lang: "fr", fill: numa-ink)
  set par(justify: false, leading: 0.68em)

  for sheet-index in range(sheet-count) {
    let group = ()
    for offset in range(4) {
      group.push(exercises.at(sheet-index * 4 + offset, default: none))
    }

    _sheet(group.map(_front))
    pagebreak()

    // Short-edge duplex on landscape stock mirrors columns but preserves rows.
    let mirrored = (group.at(1), group.at(0), group.at(3), group.at(2))
    _sheet(mirrored.map(_back))
    if sheet-index < sheet-count - 1 { pagebreak() }
  }
}
