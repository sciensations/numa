#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Des billes de toutes les couleurs],
  topics: ("combinatoire", "logique-strategie",),
  difficulty: 3.5,
  content: [
    Dans un sac, il y a 15 billes blanches, 15 noires, 6 rouges et 5 vertes.

    Combien de billes, au minimum, faut-il sortir sans les regarder pour être certain d'avoir sorti au moins 10 billes de la même couleur ?
  ],
  source: (
    organization: "FSJM",
    competition: "Quarts de finale",
    year: 2019,
    problem: 7,
    coefficient: 7,
    tracker_row: none,
    attribution: [FSJM, Quarts de finale 2019, problème n°7, coef. 7 · d'après le PDF original (absent de l'index)],
  ),
  status: "published",
)
