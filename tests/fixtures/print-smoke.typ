// Development fixture for compiling paged templates independently of bundle
// export.
#import "../../content/catalog.typ": exercises, selections
#import "../../templates/cards.typ": cards-document
#import "../../templates/responses.typ": responses-document

#let source = selections.first()
#let row-count = int(sys.inputs.at("rows", default: "6"))
#let selected = exercises.slice(0, row-count)
#let selection = source + (exercises: selected)

#if sys.inputs.at("document", default: "cards") == "responses" {
  responses-document(selection)
} else {
  cards-document(selected)
}
