#import "../../lib/model.typ": exercise

#let item = exercise.with(
  title: [Un peu de logique],
  topics: ("logique-strategie",),
  difficulty: 2,
  content: [
    Laquelle des cinq propositions ci-dessous est la négation (ou le contraire) de :
    "Tous les collèges sont ouverts tous les jours."
  
﻿﻿﻿﻿- Il y a un jour où tous les collèges sont fermés.
    
﻿﻿﻿﻿- Il y a au moins un collège qui est fermé au moins un jour.
    
﻿﻿﻿﻿- Tous les collèges sont fermés tous les jours.
    
﻿﻿﻿- Chaque collège est fermé au moins un jour.
   
﻿﻿﻿﻿- Chaque jour un collège au moins est fermé.
    #align(center)[#image("../../assets/exercises/s05/colleges05.png", width:23%)]
  ],
  source: (
    organization: "FSJM",
    competition: "Finale internationale, jour 2",
    year: 2011,
    problem: 9,
    coefficient: 9,
    tracker_row: 1246,
    attribution: [Tournoi de l'A.P.M.E.P de Rennes 1992
  ],
  ),
  status: "published",
)