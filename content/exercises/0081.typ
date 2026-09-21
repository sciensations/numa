#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Les places de concert],
  topics: ("logique-strategie", "combinatoire"),
  difficulty: 3.75,
  content: [
    Anne, Brigitte, Ève, Olga et Sophie font la queue. Olga est plus près de la caisse que Brigitte, mais derrière Sophie. Anne et Sophie ne sont pas directement l'une derrière l'autre. Ève n'est directement à côté ni d'Anne, ni d'Olga, ni de Sophie.

    Dans quel ordre font-elles la queue, à partir de la caisse ?
  ],
  source: (
    organization: "FSJM",
    competition: "Demi-finale",
    year: 2004,
    problem: 9,
    coefficient: 9,
    tracker_row: 782,
    attribution: [FSJM, Demi-finale 2004, problème n°9, coef. 9 · ligne 782 de l'index],
  ),
  status: "published",
)
