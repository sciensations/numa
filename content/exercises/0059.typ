#import "@preview/cetz:0.5.2"
#import "../../lib/authoring.typ": exercise-diagram
#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [L'enveloppe],
  topics: ("geometrie", "logique-strategie"),
  difficulty: 2,
  content: [
    Peux-tu dessiner cette enveloppe ouverte d'un seul trait, sans lever le crayon ni repasser sur un trait ?

    Si oui : d'où faut-il partir ? Essaie plusieurs points de départ et note ce que tu observes.

    #exercise-diagram(alt: "Une enveloppe : un rectangle avec ses deux diagonales, surmonté d'un triangle dont la base est le côté supérieur du rectangle.")[
      #cetz.canvas(length: 8mm, {
        import cetz.draw: *
        set-style(stroke: 0.8pt)
        line((0, 0), (4, 0), (4, 2.2), (2, 3.5), (0, 2.2), close: true)
        line((0, 2.2), (4, 2.2))
        line((0, 0), (4, 2.2))
        line((0, 2.2), (4, 0))
      })
    ]
  ],
  source: (
    organization: "Cercles mathématiques",
    competition: none,
    year: none,
    problem: none,
    coefficient: none,
    tracker_row: none,
    attribution: [Grand classique du dessin d'un seul trait],
  ),
  status: "published",
)
