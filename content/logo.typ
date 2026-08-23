// Vector Numa wordmark traced from the supplied raster reference. Every glyph
// is assembled from closed, filled CeTZ surfaces with a literal 0 mm stroke.

#import "@preview/cetz:0.5.2"
#import "../lib/theme.typ": numa-blue, numa-blue-dark, numa-green-light, numa-teal

#let _mark-width = 74.2
#let _mark-height = 23.4
#let _muted-green = rgb("#66A684")
#let _m-back = rgb("#50968C")
#let _a-top-overlap = rgb("#32717B")
#let _a-bottom-overlap = rgb("#236485")
#let _subtitle = rgb("#0C365E")

#let _drawing(width, subtitle) = {
  let unit = width / _mark-width

  cetz.canvas(length: unit, {
    import cetz.draw: *

    // Invisible surface fixes the public component's aspect ratio.
    rect(
      (0, if subtitle { 0 } else { 7.5 }),
      (_mark-width, if subtitle { _mark-height } else { 23.3 }),
      fill: white.transparentize(100%),
      stroke: none,
    )

    // n: the blue rectangle and arch are distinct filled surfaces. Their
    // explicitly filled overlap reproduces the darker lower-left stem.
    rect((0.0, 7.5), (4.2, 23.3), fill: numa-blue, stroke: 0mm)
    svg-path(
      ("M", (0.0, 7.5)),
      ("L", (0.0, 15.5)),
      ("C", (0.0, 19.808), (3.358, 23.3), (7.5, 23.3)),
      ("C", (11.642, 23.3), (15.0, 19.808), (15.0, 15.5)),
      ("L", (15.0, 7.5)),
      ("L", (10.7, 7.5)),
      ("L", (10.7, 15.5)),
      ("C", (10.7, 17.599), (9.267, 19.3), (7.4, 19.3)),
      ("C", (5.533, 19.3), (4.1, 17.599), (4.1, 15.5)),
      ("L", (4.1, 7.5)),
      ("z",),
      fill: numa-blue,
      stroke: 0mm,
    )
    svg-path(
      ("M", (4.2, 22.504)),
      ("C", (1.627, 21.193), (0.0, 18.479), (0.0, 15.5)),
      ("L", (0.0, 7.5)),
      ("L", (4.2, 7.5)),
      ("z",),
      fill: numa-blue-dark,
      stroke: 0mm,
    )

    // u: blue base, green upright, and the muted-green filled overlap.
    svg-path(
      ("M", (16.9, 23.3)),
      ("L", (21.1, 23.3)),
      ("L", (21.1, 15.4)),
      ("C", (21.1, 13.246), (22.667, 11.5), (24.6, 11.5)),
      ("C", (26.478, 11.5), (28.0, 13.246), (28.0, 15.4)),
      ("L", (32.2, 15.4)),
      ("C", (32.2, 11.037), (28.753, 7.5), (24.6, 7.5)),
      ("C", (20.347, 7.5), (16.9, 11.037), (16.9, 15.4)),
      ("z",),
      fill: numa-blue,
      stroke: 0mm,
    )
    rect((28.0, 15.4), (32.2, 23.3), fill: numa-green-light, stroke: 0mm)
    svg-path(
      ("M", (28.0, 15.4)),
      ("C", (28.0, 13.246), (26.478, 11.5), (24.6, 11.5)),
      ("C", (30.295, 12.8), (30.56, 14.1), (32.2, 15.4)),
      ("L", (28.0, 15.4)),
      ("z",),
      fill: numa-green-light,
      stroke: 0mm,
    )
    svg-path(
      ("M", (32.2, 15.4)),
      ("C", (30.56, 14.1), (30.295, 12.8), (24.6, 11.5)),
      ("L", (24.6, 7.5)),
      ("C", (28.753, 7.5), (32.2, 11.037), (32.2, 15.4)),
      ("z",),
      fill: _muted-green,
      stroke: 0mm,
    )

    // m: concentric circular arches. Each is a circle-plus-rectangle union
    // with its counter subtracted; CeTZ also computes both colour overlaps.
    let m-arch(center, outer-radius, inner-radius, fill: none, stroke: none) = {
      let x = center.at(0)
      let y = center.at(1)
      boolean(
        {
          boolean(
            { circle(center, radius: outer-radius, fill: none, stroke: none) },
            {
              rect(
                (x - outer-radius, 7.5),
                (x + outer-radius, y),
                fill: none,
                stroke: none,
              )
            },
            op: "union",
            fill: none,
            stroke: none,
          )
        },
        {
          boolean(
            { circle(center, radius: inner-radius, fill: none, stroke: none) },
            {
              rect(
                (x - inner-radius, 7.5),
                (x + inner-radius, y),
                fill: none,
                stroke: none,
              )
            },
            op: "union",
            fill: none,
            stroke: none,
          )
        },
        op: "difference",
        fill: fill,
        stroke: stroke,
      )
    }
    let m-blue(fill: none, stroke: none) = m-arch(
      (40.9, 16.6), 6.7, 2.7, fill: fill, stroke: stroke,
    )
    let m-green(fill: none, stroke: none) = m-arch(
      (50.35, 16.65), 6.65, 2.65, fill: fill, stroke: stroke,
    )

    rect((34.2, 7.5), (38.4, 23.3), fill: _m-back, stroke: 0mm)
    m-blue(fill: numa-blue, stroke: 0mm)
    m-green(fill: numa-green-light, stroke: 0mm)
    boolean(
      { rect((34.2, 7.5), (38.4, 23.3), fill: none, stroke: none) },
      { m-blue() },
      op: "intersection",
      fill: numa-blue-dark,
      stroke: 0mm,
    )
    boolean(
      { m-blue() },
      { m-green() },
      op: "intersection",
      fill: numa-teal,
      stroke: 0mm,
    )

    // a: filled upper and lower half-bands, plus the two filled terminal-stem
    // surfaces and their darker intersections with the bowl.
    svg-path(
      ("M", (58.6, 15.4)),
      ("C", (58.6, 19.763), (62.047, 23.3), (66.3, 23.3)),
      ("C", (70.553, 23.3), (74.2, 19.763), (74.2, 15.4)),
      ("L", (70.0, 15.4)),
      ("C", (70.0, 17.554), (68.3, 19.3), (66.3, 19.3)),
      ("C", (64.2, 19.3), (62.4, 17.554), (62.4, 15.4)),
      ("z",),
      fill: numa-green-light,
      stroke: 0mm,
    )
    svg-path(
      ("M", (58.6, 15.4)),
      ("C", (58.6, 11.037), (62.047, 7.5), (66.3, 7.5)),
      ("C", (70.553, 7.5), (74.2, 11.037), (74.2, 15.4)),
      ("L", (70.0, 15.4)),
      ("C", (70.0, 13.246), (68.3, 11.5), (66.3, 11.5)),
      ("C", (64.2, 11.5), (62.4, 13.246), (62.4, 15.4)),
      ("z",),
      fill: numa-blue,
      stroke: 0mm,
    )
    rect((70.0, 15.4), (74.2, 23.3), fill: numa-green-light, stroke: 0mm)
    rect((70.0, 7.5), (74.2, 15.4), fill: numa-blue-dark, stroke: 0mm)
    svg-path(
      ("M", (70.0, 22.373)),
      ("C", (72.582, 21.004), (74.2, 18.324), (74.2, 15.4)),
      ("L", (70.0, 15.4)),
      ("z",),
      fill: _a-top-overlap,
      stroke: 0mm,
    )
    svg-path(
      ("M", (70.0, 8.427)),
      ("C", (72.582, 9.796), (74.2, 12.476), (74.2, 15.4)),
      ("L", (70.0, 15.4)),
      ("z",),
      fill: _a-bottom-overlap,
      stroke: 0mm,
    )

    if subtitle {
      content(
        (0, 2.2),
        [#std.scale(x: 90%, origin: left, reflow: true)[
          #text(
            font: "Atkinson Hyperlegible Next",
            size: width * 0.084,
            weight: "bold",
            tracking: 0.035em,
            fill: _subtitle,
          )[Club de Maths - Neuchâtel]
        ]],
        anchor: "west",
      )
    }
  })
}

#let numa-logo(width: 52mm, subtitle: true) = {
  assert(type(width) == length and width > 0pt, message: "logo width must be a positive length")
  _drawing(width, subtitle)
}

// Typst's experimental HTML exporter needs html.frame to retain a CeTZ canvas.
#let numa-logo-html(width: 38mm, subtitle: true, class: "site-logo", label: "Numa") = {
  html.elem(
    "span",
    attrs: (
      class: class,
      role: "img",
      "aria-label": label,
    ),
  )[
    #html.frame(_drawing(width, subtitle))
  ]
}


#numa-logo()