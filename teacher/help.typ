#import "../templates/cards.typ": help-doc
#import "../lib/theme.typ": numa-colors

#help-doc(1,block(inset: 12mm,radius: 3mm,fill: numa-colors.at(0).lighten(80%),width: 100%,height: 100%,outset: -6mm)[
  
  
#set text(size:1.2em)
#set par(leading: 8mm)
= Petit guide du détective #emoji.magnify
#set align(left)
#v(5mm)

+ Lis l'énoncé. Relis-le si besoin.  #emoji.eye
+ Souligne en #text(fill:blue.lighten(20%))[bleu] ce qu'on cherche. #emoji.pencil
+ Relève en #text(fill:green.darken(20%))[vert] les indices qui te semblent utiles. #emoji.lightbulb
// + Écris en #text(fill:red.darken(20%))[rouge] les éventuelles informations manquantes. #emoji.quest
+ Explore ! Écris une idée, un exemple, un dessin... #emoji.brush
+ Présente les étapes de ton raisonnement.  #emoji.page
+ Conclus. #emoji.checkmark

])