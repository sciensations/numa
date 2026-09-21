#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [L'ascenseur de la tour],
  topics: ("logique-strategie", "nombres-divisibilite",),
  difficulty: 3,
  content: [
    L'ascenseur d'une tour ne peut pas contenir plus de 7 personnes. Il arrive vide au rez-de-chaussée et plusieurs personnes y montent. L'ascenseur s'arrête aux 18#super[e], 27#super[e] et 36#super[e] étages : à chaque arrêt, le nombre de personnes qui sortent est exactement le double du nombre de personnes qui entrent. Puis l'ascenseur monte au 45#super[e] étage : une personne sort et il repart vide.

    Le nombre total de personnes sorties (aux quatre étages) n'est pas un nombre premier. Combien de personnes étaient montées au rez-de-chaussée ?

    Rappel : un nombre premier a exactement deux diviseurs, 1 et lui-même : 2, 3, 5, 7, 11, 13, 17, 19…
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 1",
    year: 2012,
    problem: 5,
    coefficient: 5,
    tracker_row: 1280,
    attribution: [FSJM, Finale internationale 2012, jour 1, problème n°5, coef. 5 · ligne 1280 de l'index],
  ),
  status: "published",
)
