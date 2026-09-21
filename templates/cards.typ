#import "@preview/zebra:0.1.0": qrcode
#import "../lib/model.typ": published-exercises, source-attribution
#import "../lib/logo.typ": numa-logo
#import "../lib/theme.typ": *
#import "responses.typ": exercise-qrid
#let star-score(a)={
  
  let stars = () 
  while stars.len() < a {
    stars.push(text(size:7mm,emoji.star))
  }
  stars.join(h(1mm))
}





#let _exercise-side(item) = {
  let accent = accent-for(item.serial)
  let heading-block = block(
    width: 100%,
    fill: accent.lighten(70%),
    inset: 4mm,
    radius: 2.5mm,
  )[
    #grid(
      columns: (1fr, auto),
      gutter: 3mm,
      align(left + horizon)[
        #set text(size: 14pt, weight: "bold", fill: numa-blue-dark)
        #item.title
      ],
    )
  ]
  let statement-block = block(width: 100%,inset:4mm)[
    #set text(size: 10.5pt)
    #align(left)[#item.content]
  ]
  let natural = block(width: 136mm)[
    #heading-block
    #v(2.8mm)
    #statement-block
  ]

  layout(_ => {
    let measured = measure(natural)
    assert(measured.height <= 93mm,
      message: "card front overflows for " + item.id + " ("
        + str(calc.round(measured.height / 1mm, digits: 1)) + "mm > 93mm)")
    block(
      width: 148mm,
      height: 105mm,
      inset: 6mm,
      stroke: 0.3pt + numa-muted.lighten(35%),
      fill: none,
    )[
      #grid(
        columns: (1fr,),
        rows: (auto, 1fr),
        row-gutter: 2.8mm,
        heading-block,
        statement-block,
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
    fill: none,
  )[
    #block(
      width: 100%,
      height: 100%,
      fill: accent.lighten(74%),
      radius: 3mm,
      inset: 7mm,
    )[
      // #grid(
     //    columns: (1fr,1fr),align: (left+top,right+top),
      
     // star-score(item.difficulty),exercise-qrid(item))
      #align(right,star-score(item.difficulty))
      #align(center + horizon)[
        #v(3fr)
        #numa-logo(width: 52mm)
        #v(2fr)
        #set text(size: 13pt, weight: "bold", fill: numa-blue-dark)
        #item.title
        
        
        
        #v(2fr)
      ]
      #grid(
        columns: (1fr,30mm),align: (left+bottom,right),
      
      text(size: 2.3mm,emph(source-attribution(item.source))),exercise-qrid(item))
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



#let _branded-back-help = {
  let accent = accent-for(1)
  block(
    width: 148mm,
    height: 105mm,
    inset: 6mm,
    stroke: 0.3pt + numa-muted.lighten(35%),
    fill: none,
  )[
    #block(
      width: 100%,
      height: 100%,
      fill: accent.lighten(74%),
      radius: 3mm,
      inset: 7mm,
    )[ 
      #align(center + horizon)[
        #v(3fr)
        #numa-logo(width: 52mm)
        #v(2fr)
        #set text(size: 13pt, weight: "bold", fill: numa-blue-dark)
        Petit guide du détective #emoji.magnify
        
        
        
        #v(2fr)
      ]
    ]
  ]
}
#let help-doc(n,body) = {
  
  let sheet-count = calc.ceil(n / 4)

  set page(width: 297mm, height: 210mm, margin: 0mm, fill: white)
  set text(font: print-fonts, lang: "fr", fill: numa-ink)
  set par(justify: false, leading: 0.68em)

  for sheet-index in range(sheet-count) {
    let group = ()
    for offset in range(4) {
      group.push(body)
    }

    _sheet(group)
    pagebreak()
    _sheet(group.map(x=>_branded-back-help))
    if sheet-index < sheet-count - 1 { pagebreak() }
  }
}
