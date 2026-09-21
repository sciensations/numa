#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Chacun à sa place !],
  topics: ("logique-strategie", "combinatoire",),
  difficulty: 2.5,
  content: [
    Six élèves déjeunent à la même table rectangulaire : deux en bout de table, deux de chaque côté, face à face. Marion veut être assise en face de Charlotte. Hugo ne veut pas être en bout de table. Victoria veut être assise à côté de Bruno, mais pas en face de Soufiane.

    Place les six élèves en respectant tous les souhaits (écris l'initiale de chacun).

    Remarque : deux personnes « à côté l'une de l'autre » sont sur le même côté ; un bout de table n'est à côté de personne.
  ],
  source: (
    organization: "FSJM",
    competition: "Demi-finale",
    year: 2005,
    problem: 4,
    coefficient: 4,
    tracker_row: 842,
    attribution: [FSJM, Demi-finale 2005, problème n°4, coef. 4 · ligne 842 de l'index],
  ),
  status: "published",
)
