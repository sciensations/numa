#import "../../lib/authoring.typ": exercise-image
#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Les cinq jetons],
  topics: ("arithmetique", "optimisation", "logique-strategie"),
  difficulty: 2.5,
  content: [
    Mathilde a trouvé dans son grenier les cinq jetons ci-dessous, posés sur une règle en bois. Elle souhaite les disposer autrement sur la règle, de façon à obtenir une opération dont le résultat soit le plus grand possible.

    Quel sera ce résultat ?

    #exercise-image(
      "/assets/exercises/s01/tokens.png",
      width: 50mm,
      alt: "Cinq jetons portant 3, 4, 5, 6 et le signe de multiplication.",
    )

    _Note : le « 6 » retourné peut se transformer en « 9 »._
  ],
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
