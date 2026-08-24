// Shared print palette and typography.

#let numa-blue-dark = rgb("#1D5A7E")
#let numa-blue = rgb("#3B86A3")
#let numa-teal = rgb("#569B88")
#let numa-green = rgb("#7FB97B")
#let numa-green-light = rgb("#8ABD7B")
#let numa-ink = rgb("#17313E")
#let numa-paper = rgb("#F7FAF8")
#let numa-muted = rgb("#607680")
#let numa-font = "Atkinson Hyperlegible Next"

#let numa-colors = (
  numa-blue,
  numa-teal,
  numa-green,
  numa-green-light,
)

#let accent-for(order) = numa-colors.at(calc.rem(order - 1, numa-colors.len()))

#let print-fonts = (numa-font,)

#let apply-print-theme(body) = {
  set text(font: print-fonts, lang: "fr", fill: numa-ink)
  set par(justify: false, leading: 0.68em)
  body
}

#rect(fill: numa-blue) numa-blue
#rect(fill: numa-blue-dark)numa-blue-dark
#rect(fill: numa-green) numa-green
#rect(fill: numa-blue)
#rect(fill: numa-blue)
#rect(fill: numa-blue)
#rect(fill: numa-blue)
#rect(fill: numa-blue)
#rect(fill: numa-blue)
#rect(fill: numa-blue)
