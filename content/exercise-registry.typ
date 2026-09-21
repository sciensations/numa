// Copy the draft template to the next numbered file, then increase this value.
// Keep all allocated files, including drafts: filenames determine permanent IDs.
#let last-serial = 13

#assert(type(last-serial) == int and last-serial >= 1 and last-serial <= 9999,
  message: "last-serial must be the highest allocated four-digit exercise number")

#let exercises = range(1, last-serial + 1).map(serial => {
  let stem = "0" * (4 - str(serial).len()) + str(serial)
  import ("exercises/" + stem + ".typ") as definition
  assert(type(definition.item) == function,
    message: stem + ".typ must export `item = exercise.with(...)` without a serial")
  let item = definition.item(serial: serial)
  assert(item.serial == serial,
    message: stem + ".typ must use the serial supplied by the registry")
  item
})

#let exercise-at(serial) = {
  let matches = exercises.filter(item => item.serial == serial)
  assert(matches.len() == 1, message: "unknown or duplicate exercise serial " + str(serial))
  matches.first()
}
