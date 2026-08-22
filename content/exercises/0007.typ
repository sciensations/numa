#import "../../lib/model.typ": exercise

#let item = exercise(
  serial: 7,
  title: [Le patron du dé],
  topics: ("geometrie", "logique-strategie"),
  difficulty: 1.0,
  statement_parts: (
    [
      Dans un dé « normal », la somme des points situés sur deux faces opposées est toujours égale à 7.

      Complète les faces du patron de ce dé normal.
    ],
  ),
  figure: (
    path: "assets/exercises/s01/die-net.png",
    alt: "Patron de dé formé de six carrés : quatre carrés alignés, portant 2 puis 3 sur les deux premiers, un carré portant 1 au-dessus du deuxième, et un carré vide sous le troisième.",
    caption: none,
  ),
  source: (
    organization: "FSJM",
    competition: "Quarts de finale",
    year: 2006,
    problem: 1,
    coefficient: 1,
    tracker_row: 946,
    attribution: [FSJM, Quarts de finale 2006, problème n°1, coef. 1 · ligne 946 de l'index],
  ),
  hints: (),
  extra: none,
  solution: none,
  status: "published",
)
