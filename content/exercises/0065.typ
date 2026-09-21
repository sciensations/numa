#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Nombre à deviner],
  topics: ("arithmetique", "algebre"),
  difficulty: 1.5,
  content: [
    Un nombre a trois chiffres dont la somme est 18. Le chiffre des centaines est la moitié du chiffre des dizaines, et le tiers du chiffre des unités.

    Quel est ce nombre ?
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 2",
    year: 2007,
    problem: 2,
    coefficient: 2,
    tracker_row: 993,
    attribution: [FSJM, Finale internationale 2007, jour 2, problème n°2, coef. 2 · ligne 993 de l'index],
  ),
  status: "published",
)
