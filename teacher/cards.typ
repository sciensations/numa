// Scratch card batch for Typst Web. Edit this tuple independently of any
// response selection, then export the compiled PDF.
#import "../templates/cards.typ": cards-document
#import "../content/exercises/0001.typ": item as ex01
#import "../content/exercises/0002.typ": item as ex02
#import "../content/exercises/0003.typ": item as ex03
#import "../content/exercises/0004.typ": item as ex04
#import "../content/exercises/0005.typ": item as ex05
#import "../content/exercises/0006.typ": item as ex06

#cards-document((ex01, ex02, ex03, ex04, ex05, ex06))
