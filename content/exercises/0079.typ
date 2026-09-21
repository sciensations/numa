#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Diviseur ou multiple],
  topics: ("nombres-divisibilite", "logique-strategie"),
  difficulty: 3.75,
  content: [
    Didier et Muriel jouent avec dix cartes numérotées de 1 à 10. Didier commence en enlevant la carte 2. Chacun son tour, on enlève une carte dont le numéro est un diviseur ou un multiple du numéro de la carte enlevée juste avant. Qui ne peut plus jouer a perdu.

    Quelle carte Muriel doit-elle enlever maintenant pour être certaine de gagner ? (1 divise tout nombre.)
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 2",
    year: 2013,
    problem: 7,
    coefficient: 7,
    tracker_row: 1353,
    attribution: [FSJM, Finale internationale 2013, jour 2, problème n°7, coef. 7 · ligne 1353 de l'index],
  ),
  status: "published",
)
