#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [L'ordinateur malicieux],
  topics: ("logique-strategie",),
  difficulty: 2,
  content: [
    Sur mon écran d'ordinateur, j'avais écrit une opération. Celui-ci m'a fait une farce : il a transformé les 4 en 9, les 9 en 4, les $-$ en $+$, les $+$ en $-$, les $times$ en $div$ et les $div$ en $times$.
    
Voici l'opération transformée : 

(4 $div$ 19) $-$ (49 $times$ 2) $+$ 99 $+$ (9 $div$ 5).

Décodez-la et donnez-en la réponse.
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 2",
    year: 2011,
    problem: 9,
    coefficient: 9,
    tracker_row: 1246,
    attribution: [Tournoi de St Michel en l'Herm 1994
  ],
  ),
  status: "published",
)