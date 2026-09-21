#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [L'anniversaire rock],
  topics: ("logique-strategie",),
  difficulty: 4,
  content: [
    Alice, Béatrice, Carine et Daphné forment un groupe de rock (chant, batterie, guitare basse, guitare électrique — un rôle chacune). Règle permanente : si Alice ne joue pas de basse, alors Carine ne joue pas de guitare électrique.

    Aujourd'hui : la chanteuse n'est ni Alice ni Daphné ; Béatrice ne joue ni batterie ni basse ; ni Alice ni Daphné ne jouent de guitare électrique ; Carine ne joue pas de basse et ne chante pas.

    Que fait chacune ?
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 2",
    year: 2012,
    problem: 9,
    coefficient: 9,
    tracker_row: 1302,
    attribution: [FSJM, Finale internationale 2012, jour 2, problème n°9, coef. 9 · ligne 1302 de l'index],
  ),
  status: "published",
)
