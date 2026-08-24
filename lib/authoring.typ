// Cross-target building blocks for figures placed by an exercise author.
// They preserve native, editable Typst content in print while avoiding paged
// layout constructs that the experimental HTML exporter currently drops.

#let _html-target() = target() in ("html", "bundle")

#let _checked-alt(alt) = {
  assert(type(alt) == str and alt.trim() != "",
    message: "an exercise visual needs non-empty alternative text")
  alt
}

// Center semantic content, such as a table, without turning it into an image
// on the website.
#let exercise-center(body) = context {
  if _html-target() {
    html.elem("div", attrs: (class: "exercise-center"))[#body]
  } else {
    align(center, body)
  }
}

// Place a raster/vector image at the exact point chosen by the author. Paths
// start at the project root so they resolve consistently from this module.
#let exercise-image(
  path,
  alt: none,
  width: auto,
  height: auto,
  fit: "contain",
) = context {
  let description = _checked-alt(alt)
  let picture = image(path, width: width, height: height, fit: fit, alt: description)
  if _html-target() {
    html.elem("figure", attrs: (class: "exercise-visual exercise-visual--image"))[#picture]
  } else {
    align(center, picture)
  }
}

// Keep code-drawn layouts native in print. html.frame is deliberately limited
// to the visual itself so the surrounding exercise remains semantic HTML.
#let exercise-diagram(body, alt: none) = context {
  let description = _checked-alt(alt)
  if _html-target() {
    html.elem("figure", attrs: (class: "exercise-visual exercise-visual--diagram"))[
      #html.elem("div", attrs: (
        class: "exercise-diagram__frame",
        role: "img",
        aria-label: description,
      ))[#html.frame(body)]
    ]
  } else {
    align(center, body)
  }
}

// A responsive counterpart to Typst's paged grid. The exercise author chooses
// both columns; the site stacks them on narrow screens through shared CSS.
#let exercise-columns(
  left-body,
  right-body,
  columns: (1.9fr, 1fr),
  gutter: 4mm,
) = context {
  if _html-target() {
    html.elem("div", attrs: (class: "exercise-columns"))[
      #html.elem("div", attrs: (class: "exercise-columns__main"))[#left-body]
      #html.elem("div", attrs: (class: "exercise-columns__aside"))[#right-body]
    ]
  } else {
    grid(columns: columns, gutter: gutter, left-body, right-body)
  }
}
