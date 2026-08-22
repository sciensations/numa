#import "@preview/suiji:0.5.1": gen-rng-f, integers-f

// Curated, printable symbols. Keep this order stable: changing it changes every
// derived signature already printed on a card.
#let emoji-library = (
  "🍎", "🍐", "🍋", "🍉", "🍇", "🍓", "🥕", "🌽",
  "🍄", "🌵", "🌻", "🌙", "⭐", "☀️", "🌈", "🔥",
  "💧", "❄️", "⚡", "🎈", "🎲", "🎯", "🧩", "🪁",
  "🎵", "🎨", "📚", "✏️", "📏", "🔍", "🔑", "🔒",
  "💡", "⚙️", "🧭", "⏰", "🚲", "🚀", "🚂", "⛵",
  "🏠", "🏰", "🗼", "🌉", "🐝", "🐞", "🦋", "🐢",
  "🐙", "🐬", "🦉", "🦊", "🐼", "🐸", "🦁", "🐧",
  "🦀", "🐳", "👟", "🎩", "👑", "🪙", "🔺", "🔷",
)

#let emoji-signature(serial) = {
  assert(type(serial) == int and serial >= 1,
    message: "emoji signature needs a positive exercise serial")
  // A separate seed namespace keeps this derivation independent of public IDs.
  let rng = gen-rng-f(serial + 0x4e554d41)
  let chosen = ()
  while chosen.len() < 4 {
    let index = 0
    (rng, index) = integers-f(rng, low: 0, high: emoji-library.len())
    let candidate = emoji-library.at(index)
    if not chosen.contains(candidate) { chosen.push(candidate) }
  }
  chosen
}
