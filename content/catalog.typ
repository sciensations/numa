#import "exercise-registry.typ": exercises

#let selections = (
  "s01", "s03", "s05", "s09", "s11", "s14", "s17",
  "s20", "s22", "s26", "s28", "s29", "s33", "s34",
).map(id => {
  import ("selections/" + id + ".typ") as definition
  definition.item
})
