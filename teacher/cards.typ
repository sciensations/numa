// Scratch card batch for Typst Web. Edit this tuple independently of any
// response selection, then export the compiled PDF.
#import "../templates/cards.typ": cards-document
#import "../content/exercise-registry.typ": exercise-at

#cards-document((1, 2, 3, 4, 5, 6).map(exercise-at))
