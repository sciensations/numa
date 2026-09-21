#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [La carte devinée],
  topics: ("logique-strategie",),
  difficulty: 1.5,
  content: [
    Une personne tire une carte d'un jeu de 32 cartes. Le magicien pose des questions :

    « La carte est-elle un numéro ? » — Oui. « Est-elle paire ? » — Oui. « Est-elle un huit ? » — Non. « Est-elle noire ? » — Oui. « Est-elle un trèfle ? » — Non.

    Le magicien a trouvé. Et toi ? (Un jeu de 32 cartes : cœur et carreau rouges, trèfle et pique noirs ; hauteurs 7, 8, 9, 10, valet, dame, roi, as.)
  ],
  source: (
    organization: "FSJM",
    competition: "Demi-finale",
    year: 1999,
    problem: 2,
    coefficient: 2,
    tracker_row: 524,
    attribution: [FSJM, Demi-finale 1999, problème n°2, coef. 2 · ligne 524 de l'index],
  ),
  status: "published",
)
