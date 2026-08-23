#import "../../lib/model.typ": exercise

#let item = exercise(
  serial: 8,
  title: [Les bosses],
  topics: ("arithmetique", "optimisation"),
  difficulty: 1.5,
  statement_parts: (
    [
      Un troupeau est composé de chameaux et de dromadaires (au moins un animal de chaque espèce). Au total, on compte 29 bosses. Un chameau a deux bosses, un dromadaire une seule.

      Combien le troupeau compte-t-il de bêtes, au minimum ?
      #v(1fr)
      #align(center,image("../../assets/exercises/s01/dromadaire.png"))
      #v(1fr)
    ],
  ),
  figure: none,
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 2",
    year: 2008,
    problem: 2,
    coefficient: 2,
    tracker_row: 1059,
    attribution: [FSJM, Finale internationale 2008, jour 2, problème n°2, coef. 2 · ligne 1059 de l'index],
  ),
  hints: (),
  extra: none,
  solution: none,
  status: "published",
)
