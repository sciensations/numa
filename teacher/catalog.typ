#import "../content/catalog.typ": exercises, selections
#import "../lib/id.typ": exercise-id
#import "../lib/model.typ": topic-label, validate-catalog
#import "../lib/theme.typ": print-fonts, numa-blue-dark, numa-ink, numa-muted

#let stats = validate-catalog(exercises, selections)
#let next-serial = if exercises.len() == 0 { 1 } else { calc.max(..exercises.map(it => it.serial)) + 1 }

#set page(paper: "a4", margin: 18mm)
#set text(font: print-fonts, lang: "fr", fill: numa-ink)
#set heading(numbering: "1.")

= Tableau de bord Numa

#text(size: 15pt, weight: "bold", fill: numa-blue-dark)[
  Prochain numéro interne : #next-serial
]

Identifiant correspondant : *#upper(exercise-id(next-serial))*

#stats.published exercices publiés · #stats.selections sélections persistantes.

== Catalogue

#table(
  columns: (12mm, 22mm, 35mm, 1fr, 25mm),
  inset: 2mm,
  stroke: 0.4pt + numa-muted.lighten(35%),
  table.header([*N°*], [*ID*], [*Emoji*], [*Titre*], [*Difficulté*]),
  ..exercises.map(item => (
    [#item.serial],
    [#upper(item.id)],
    [#text(font: "Noto Color Emoji", size: 8pt)[#item.emojis.join(" ")]],
    item.title,
    [#item.difficulty / 5],
  )).flatten(),
)

== Thèmes utilisés

#for topic in exercises.map(it => it.topics).flatten().dedup() {
  [• #topic-label(topic)\ ]
}
