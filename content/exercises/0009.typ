#import "../../lib/model.typ": exercise

#let item = exercise(
  serial: 9,
  title: [Le nombre mystérieux],
  topics: ("arithmetique", "logique-strategie"),
  difficulty: 2.0,
  statement_parts: (
    [
      Trouve un nombre de 3 chiffres, tous différents, tel que :

      - la somme des 3 chiffres vaut 10 ;
      - le produit des 2 premiers chiffres vaut 6 ;
      - le chiffre des dizaines est le plus grand des trois.

      Quel est ce nombre ?
    ],
  ),
  figure: none,
  source: (
    organization: "FSJM",
    competition: "Demi-finale",
    year: 2005,
    problem: 3,
    coefficient: 3,
    tracker_row: 841,
    attribution: [FSJM, Demi-finale 2005, problème n°3, coef. 3 · ligne 841 de l'index],
  ),
  hints: (),
  extra: none,
  solution: none,
  status: "published",
)
