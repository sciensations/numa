#import "../../templates/qr-stickers.typ": qr-stickers
#import "../../lib/theme.typ": *
#import "../../content/exercise-registry.typ": exercise-at

#let serials = (85,86,87)

#set page(height: 210mm, width: 297mm, margin: 20mm, fill: white)
#set text(font: print-fonts, lang: "fr", size: 9.5pt, fill: numa-ink)

#qr-stickers(serials.map(exercise-at))
