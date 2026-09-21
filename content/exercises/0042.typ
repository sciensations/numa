#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Le jeu de Julien],
  topics: ("arithmetique", "logique-strategie"),
  difficulty: 1.25,
  content: [
    Julien a séparé son jeu de 32 cartes en deux paquets : 19 cartes à gauche, 13 à droite. Le paquet de gauche contient 13 cartes noires. Un jeu de 32 cartes contient autant de rouges que de noires.

    Combien le paquet de droite contient-il de cartes rouges ?
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 1",
    year: 2008,
    problem: 1,
    coefficient: 1,
    tracker_row: 1042,
    attribution: [FSJM, Finale internationale 2008, jour 1, problème n°1, coef. 1 · ligne 1042 de l'index],
  ),
  status: "published",
)
