#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Traversée],
  topics: ("logique-strategie", "algebre"),
  difficulty: 3.5,
  content: [
    Les professeurs et les élèves d'un lycée (1991 personnes en tout) doivent traverser une rivière avec une barque qui ne peut porter plus de 100 kg. Chaque élève pèse 50 kg, chaque professeur 100 kg.

    Il faut au minimum 4235 traversées pour faire passer tout le monde (un aller-retour compte pour deux traversées).

    Combien y a-t-il d'élèves dans ce lycée ?
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 2",
    year: 1991,
    problem: 6,
    coefficient: 6,
    tracker_row: 147,
    attribution: [FSJM, Finale internationale 1991, jour 2, problème n°6, coef. 6 · ligne 147 de l'index],
  ),
  status: "published",
)
