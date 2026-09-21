#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Le jeu de Nicole],
  topics: ("arithmetique", "suites-motifs",),
  difficulty: 3.5,
  content: [
    Nicole part d'un nombre non nul, qu'elle écrit. Si le dernier nombre écrit est pair, elle le divise par 2 et écrit le résultat ; s'il est impair, elle le multiplie par 3, ajoute 1, et écrit le résultat. Elle s'arrête en écrivant 1.

    Exemple en partant de 5 : la liste 5 ; 16 ; 8 ; 4 ; 2 ; 1 compte six nombres.

    Combien de nombres contiendra la plus longue liste possible en partant d'un nombre au maximum égal à 10 ?
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 2",
    year: 2008,
    problem: 7,
    coefficient: 7,
    tracker_row: 1064,
    attribution: [FSJM, Finale internationale 2008, jour 2, problème n°7, coef. 7 · ligne 1064 de l'index],
  ),
  status: "published",
)
