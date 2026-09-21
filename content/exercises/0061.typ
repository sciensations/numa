#import "@preview/cetz:0.5.2"
#import "../../lib/authoring.typ": exercise-diagram
#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [La carte à colorier],
  topics: ("geometrie", "logique-strategie"),
  difficulty: 2.5,
  content: [
    Colorie cette carte de six régions de sorte que deux régions qui se touchent par un côté aient toujours des couleurs différentes.

    Quel est le plus petit nombre de couleurs nécessaire ?

    #exercise-diagram(alt: "Carte rectangulaire découpée par des segments horizontaux et verticaux ; un petit rectangle central touche les régions voisines.")[
      // The source says six regions but draws seven; preserve it pending review.
      #cetz.canvas(length: 0.15mm, {
        import cetz.draw: *
        set-style(stroke: 0.8pt)
        rect((0, 0), (318, 218))
        line((158, 218), (158, 100), (318, 100))
        line((0, 139), (228, 139), (228, 0))
        line((88, 139), (88, 0))
        line((88, 59), (228, 59))
      })
    ]
  ],
  source: (
    organization: "Numa",
    competition: none,
    year: none,
    problem: none,
    coefficient: none,
    tracker_row: none,
    attribution: [Création Numa],
  ),
  status: "published",
)
