// Development fixture for compiling paged templates independently of bundle
// export.
#import "../../content/catalog.typ": exercises, selections
#import "../../templates/cards.typ": cards-document
#import "../../templates/responses.typ": responses-document

#let source = selections.first()
#let row-count = int(sys.inputs.at("rows", default: "6"))
#let selected = if row-count <= 6 {
  exercises.slice(0, row-count)
} else {
  exercises + (
    exercises.at(0) + (id: "abc123", serial: 7),
    exercises.at(1) + (id: "def456", serial: 8),
  )
}
#let selection = source + (exercises: selected)

#if sys.inputs.at("document", default: "cards") == "responses" {
  responses-document(selection)
} else {
  cards-document(selected)
}
