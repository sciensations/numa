#import "../../lib/model.typ": exercise

#let item = exercise(
  serial: 6,
  title: [Défi — Plus ou moins un],
  topics: ("combinatoire", "logique-strategie", "optimisation"),
  difficulty: 4.5,
  statement_parts: (
    [
      Bob a écrit le nombre 2 au centre d'un tableau 3 × 3. Alice doit écrire un entier plus grand que zéro dans chacune des huit autres cases. Dans chaque paire de cases voisines (qui partagent un côté complet), les deux nombres doivent différer de 1. Le score d'Alice est la somme des neuf nombres.

    ],
    [
      Alice peut obtenir les scores 20 et 18. Combien de scores AUTRES que 20 et 18 peut-elle obtenir ?

      #table(
        columns: (18mm, 18mm, 18mm),
        rows: (18mm, 18mm, 18mm),
        inset: 0pt,
        align: center + horizon,
        stroke: 0.6pt,
        [], [], [],
        [], [*2*], [],
        [], [], [],
      )
    ],
  ),
  figure: none,
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 2",
    year: 2018,
    problem: 8,
    coefficient: 8,
    tracker_row: 1628,
    attribution: [FSJM, Finale internationale 2018, jour 2, problème n°8, coef. 8 · ligne 1628 de l'index],
  ),
  hints: (),
  extra: none,
  solution: none,
  status: "published",
)
