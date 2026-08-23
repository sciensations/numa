#import "../../lib/model.typ": exercise

#let item = exercise(
  serial: 11,
  title: [Les cinq jetons],
  topics: ("arithmetique", "optimisation", "logique-strategie"),
  difficulty: 2.5,
  statement_parts: (
    [
      Mathilde a trouvé dans son grenier les cinq jetons ci-dessous, posés sur une règle en bois. Elle souhaite les disposer autrement sur la règle, de façon à obtenir une opération dont le résultat soit le plus grand possible.

      Quel sera ce résultat ?

      #v(1fr)
      #align(center,image("../../assets/exercises/s01/tokens.png",width: 5cm))
      #v(1fr)
      _Note : le « 6 » retourné peut se transformer en « 9 »._
    ],
  ),
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 2",
    year: 2011,
    problem: 4,
    coefficient: 4,
    tracker_row: 1236,
    attribution: [FSJM, Finale internationale 2011, jour 2, problème n°4, coef. 4 · ligne 1236 de l'index],
  ),
  hints: (),
  extra: none,
  solution: none,
  status: "published",
)
