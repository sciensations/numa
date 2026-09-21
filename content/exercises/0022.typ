#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [La tombola],
  topics: ("combinatoire", "logique-strategie",),
  difficulty: 2,
  content: [
    À la fête de l'école, une tombola est organisée. Cent tickets ont été imprimés : quarante portent « bon pour un petit lot », un ticket indique « gros lot », et les autres sont perdants.

    Combien de tickets faut-il acheter pour être certain de gagner au moins un lot ?
  ],
  source: (
    organization: "FSJM",
    competition: "Demi-finale",
    year: 2015,
    problem: 4,
    coefficient: 4,
    tracker_row: 1417,
    attribution: [FSJM, Demi-finale 2015, problème n°4, coef. 4 · ligne 1417 de l'index],
  ),
  status: "published",
)
