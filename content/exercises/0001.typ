#import "../../lib/authoring.typ": exercise-columns, exercise-image
#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Relève de la Garde],
  topics: ("arithmetique", "logique-strategie"),
  difficulty: 1.5,
  content: [
    #exercise-columns(
      [
        La relève de la Garde est l'une des plus anciennes cérémonies du palais de Buckingham. En automne, elle se déroule tous les jours pairs.

        Mina promet à son amie d'aller voir cette cérémonie dans une semaine exactement et lui dit : « Après-demain, nous serons le 11 novembre. »

        Quel jour s'y rendront-elles ?
      ],
      [
        #exercise-image(
          "/assets/exercises/s03/guard.png",
          width: 100%,
          height: 49mm,
          alt: "Illustration d'un garde britannique devant sa guérite.",
        )
      ],
    )
  ],
  source: (
    organization: "FSJM",
    competition: "Demi-finale",
    year: 2007,
    problem: 2,
    coefficient: 2,
    tracker_row: 960,
    attribution: [FSJM, Demi-finale 2007, problème n°2, coef. 2 · ligne 960 de l'index],
  ),
  hints: (),
  extra: none,
  solution: none,
  status: "published",
)
