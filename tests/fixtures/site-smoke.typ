// Exercises non-empty disclosure branches without changing published content.
#import "../../content/catalog.typ": exercises, selections
#import "../../templates/site.typ": exercise-page

#let item = exercises.first() + (
  hints: ([Commence par distinguer les cas pairs et impairs.], [Teste un petit exemple.]),
  extra: [Que se passe-t-il si l’on décale la date d’un jour ?],
  solution: [Une solution de contrôle pour le rendu HTML.],
)

#exercise-page(selections, item)
