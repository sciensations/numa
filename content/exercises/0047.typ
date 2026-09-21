#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [La tour infernale],
  topics: ("suites-motifs", "nombres-divisibilite"),
  difficulty: 3.25,
  content: [
    Dans une tour de plus de 4 étages vit un locataire par étage. Le locataire du 1er étage paie 1 franc de charges, celui du 2e paie 2 francs, celui du 3e paie 3 francs, et ainsi de suite. Les locataires « du bas », réunis, paient exactement autant que les locataires « du haut », réunis. Le total ne dépasse pas 1988 francs.

    Combien la tour compte-t-elle d'étages ?
  ],
  source: (
    organization: "FSJM",
    competition: "Demi-finale",
    year: 1988,
    problem: 5,
    coefficient: 5,
    tracker_row: 6,
    attribution: [FSJM, Demi-finale 1988, problème n°5, coef. 5 · ligne 6 de l'index],
  ),
  status: "published",
)
