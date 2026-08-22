// Must fail: catalog validation rejects two exercises with the same signature.
#import "../../content/catalog.typ": exercises
#import "../../lib/model.typ": validate-catalog

#let collision = exercises.at(1) + (emojis: exercises.first().emojis)
#validate-catalog((exercises.first(), collision), ())
