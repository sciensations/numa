#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Les morceaux de musique],
  topics: ("arithmetique", "suites-motifs",),
  difficulty: 3,
  content: [
    La musique d'ambiance d'un magasin est composée de quatre morceaux A, B, C et D, qui se succèdent sans interruption, toujours dans le même ordre (A recommence après D). Chaque morceau dure un nombre entier de minutes, au plus 9. A, B et C durent 5, 3 et 2 minutes.

    Quand Patricia entre dans le magasin, elle entend B, qui a débuté depuis une minute. Elle reste exactement une heure. Quand elle sort, elle entend A, qui a débuté depuis une minute.

    Combien de minutes dure le morceau D ?
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 2",
    year: 2015,
    problem: 5,
    coefficient: 5,
    tracker_row: 1454,
    attribution: [FSJM, Finale internationale 2015, jour 2, problème n°5, coef. 5 · ligne 1454 de l'index],
  ),
  status: "published",
)
