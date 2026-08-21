#import "@preview/suiji:0.5.1": gen-rng-f, integers-f

// Permanent public exercise identifiers. Changing this function, its package
// version, or the seed convention would change printed QR destinations.
#let exercise-id(serial) = {
  assert(type(serial) == int and serial >= 1,
    message: "exercise serial must be a positive integer")
  let rng = gen-rng-f(serial)
  let value = 0
  (rng, value) = integers-f(rng, low: 0, high: 0x1000000)
  let raw = str(value, base: 16)
  let id = "0" * (6 - raw.len()) + raw
  assert(id != "000000", message: "exercise serial maps to reserved id 000000")
  id
}
