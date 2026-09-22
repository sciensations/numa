#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Logiciens et menteurs],
  topics: ("logique-strategie",),
  difficulty: 1.75,
  content: [
    Alain, Bernard et Charles se rencontrent. Parmi eux : un « juste », qui dit toujours la vérité ; un « roublard », qui ment toujours ; un « ignorant », qui peut aussi bien mentir que dire vrai.

    Alain dit : « Bernard est le juste. » Charles dit : « Alain n'est pas le roublard. »

    Peux-tu dire qui est qui ?

    #align(center)[#image("../../assets/exercises/s05/menteurss05.png", width:40%)]

    
  ],
  source: (
    organization: "FSJM",
    competition: "Demi-finale",
    year: 1988,
    problem: 2,
    coefficient: 2,
    tracker_row: 3,
    attribution: [FSJM, Demi-finale 1988, problème n°2, coef. 2 · ligne 3 de l'index],
  ),
  status: "published",
)
