#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Une fois sur trois],
  topics: ("logique-strategie", "nombres-divisibilite",),
  difficulty: 3.5,
  content: [
    Trisha ment une fois toutes les trois phrases ; sinon elle dit la vérité (après avoir menti, elle dit deux fois la vérité avant de mentir à nouveau). Elle commence soit par mentir, soit par dire une ou deux vérités avant son premier mensonge.

    Trisha pense à un nombre entier de deux chiffres et prononce, dans l'ordre : « Un des chiffres du nombre est 2 » ; « Le nombre est plus grand que 57 » ; « Le nombre est pair » ; « Le nombre est plus petit que 31 » ; « Le nombre est multiple de 6 » ; « Un des chiffres du nombre est 4 ».

    Quel est le nombre de Trisha ?
#align(center)[#image("../../assets/exercises/s05/trishas05.png", width:21.1%)]
    
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 1",
    year: 2018,
    problem: 6,
    coefficient: 6,
    tracker_row: 1608,
    attribution: [FSJM, Finale internationale 2018, jour 1, problème n°6, coef. 6 · ligne 1608 de l'index],
  ),
  status: "published",
)
