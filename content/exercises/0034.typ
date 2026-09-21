#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [À la maternelle],
  topics: ("combinatoire",),
  difficulty: 2,
  content: [
    La maîtresse distribue à chaque enfant une feuille avec trois symboles, et trois feutres (bleu, rouge, jaune). Chaque enfant colorie chaque symbole d'une couleur, sans jamais utiliser deux fois la même couleur sur sa feuille. Seuls deux enfants du groupe ont des feuilles identiques, toutes les autres sont différentes.

    Combien le groupe compte-t-il d'enfants, au maximum ?
  ],
  source: (
    organization: "FSJM",
    competition: "Quarts de finale",
    year: 2018,
    problem: 3,
    coefficient: 3,
    tracker_row: 1641,
    attribution: [FSJM, Quarts de finale 2018, problème n°3, coef. 3 · ligne 1641 de l'index],
  ),
  status: "published",
)
