#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [La crème ne compte pas pour du beurre],
  topics: ("mesures", "arithmetique"),
  difficulty: 3,
  content: [
    Le lait donne en moyenne le sixième de son poids de crème, et la crème le quart de son poids de beurre.

    Quel poids total de beurre, en grammes, obtient-on avec le lait donné du 1er mars au 31 mai inclus par deux vaches produisant chaque jour l'une 8 litres et l'autre 10 litres ? (Un litre de lait pèse 1,03 kg.)
  ],
  source: (
    organization: "FSJM",
    competition: "Quarts de finale",
    year: 2013,
    problem: 7,
    coefficient: 7,
    tracker_row: 1370,
    attribution: [FSJM, Quarts de finale 2013, problème n°7, coef. 7 · ligne 1370 de l'index],
  ),
  status: "published",
)
