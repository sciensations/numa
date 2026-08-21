#import "../../lib/model.typ": selection
#import "../exercises/0001.typ": item as ex01
#import "../exercises/0002.typ": item as ex02
#import "../exercises/0003.typ": item as ex03
#import "../exercises/0004.typ": item as ex04
#import "../exercises/0005.typ": item as ex05
#import "../exercises/0006.typ": item as ex06

#let item = selection(
  id: "s03",
  title: [Fiche 1 : la parité],
  date: "2026-09-09",
  year: 2026,
  purpose: "response",
  listed: true,
  exercises: (ex01, ex02, ex03, ex04, ex05, ex06),
)
