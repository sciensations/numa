#import "id.typ": exercise-id
#import "emoji.typ": emoji-signature

#let topic-registry = (
  "arithmetique": "Arithmétique",
  "nombres-divisibilite": "Nombres et divisibilité",
  "algebre": "Algèbre",
  "geometrie": "Géométrie",
  "combinatoire": "Combinatoire",
  "logique-strategie": "Logique et stratégie",
  "probabilites": "Probabilités",
  "mesures": "Mesures",
  "suites-motifs": "Suites et motifs",
  "optimisation": "Optimisation",
)

#let topic-label(slug) = topic-registry.at(slug)

#let _required(record, key, owner) = {
  assert(key in record, message: owner + " is missing required field `" + key + "`")
  record.at(key)
}

#let has-content(value) = {
  if value == none { false }
  else if type(value) == str { value.trim() != "" }
  else if type(value) == array { value.any(has-content) }
  else if type(value) == content { value != [] }
  else { true }
}

#let source-attribution(source) = source.attribution

#let validate-source(source, owner) = {
  assert(type(source) == dictionary, message: owner + " source must be a dictionary")
  for key in ("organization", "competition", "year", "problem", "coefficient", "tracker_row", "attribution") {
    let _value = _required(source, key, owner + " source")
  }
  assert(type(source.organization) == str and source.organization.trim() != "",
    message: owner + " source organization is required")
  assert(type(source.competition) == str and source.competition.trim() != "",
    message: owner + " source competition is required")
  assert(type(source.year) == int and source.year >= 1900,
    message: owner + " source year must be an integer")
  assert(type(source.problem) == int and source.problem >= 1,
    message: owner + " source problem must be positive")
  assert(type(source.coefficient) == int and source.coefficient >= 1,
    message: owner + " source coefficient must be positive")
  assert(type(source.tracker_row) == int and source.tracker_row >= 1,
    message: owner + " source tracker row must be positive")
  assert(has-content(source.attribution), message: owner + " source attribution is required")
  source
}

#let validate-exercise(item) = {
  assert(type(item) == dictionary, message: "exercise must be a dictionary")
  let id = _required(item, "id", "exercise")
  let serial = _required(item, "serial", "exercise " + str(id))
  let emojis = _required(item, "emojis", "exercise " + str(id))
  let title = _required(item, "title", "exercise " + str(id))
  let parts = _required(item, "statement_parts", "exercise " + str(id))
  let topics = _required(item, "topics", "exercise " + str(id))
  let difficulty = _required(item, "difficulty", "exercise " + str(id))
  let figure = _required(item, "figure", "exercise " + str(id))
  let source = _required(item, "source", "exercise " + str(id))
  let hints = _required(item, "hints", "exercise " + str(id))
  let extra = _required(item, "extra", "exercise " + str(id))
  let solution = _required(item, "solution", "exercise " + str(id))
  let status = _required(item, "status", "exercise " + str(id))

  assert(type(serial) == int and serial >= 1,
    message: "exercise " + id + " needs a positive serial")
  assert(id == exercise-id(serial),
    message: "exercise serial " + str(serial) + " must use id `" + exercise-id(serial) + "`")
  assert(id.match(regex("^[0-9a-f]{6}$")) != none,
    message: "exercise id must be six lowercase hexadecimal characters")
  assert(type(emojis) == array and emojis.len() == 4,
    message: "exercise " + id + " needs exactly four emoji")
  assert(emojis.all(emoji => type(emoji) == str and emoji.trim() != ""),
    message: "exercise " + id + " contains an invalid emoji")
  assert(emojis.dedup().len() == 4,
    message: "exercise " + id + " emoji must be distinct")
  assert(has-content(title), message: "exercise " + id + " needs a title")
  assert(type(parts) == array and parts.len() in (1, 2),
    message: "exercise " + id + " needs one or two statement parts")
  assert(parts.all(has-content), message: "exercise " + id + " contains an empty statement part")
  assert(type(topics) == array and topics.len() >= 1,
    message: "exercise " + id + " needs at least one topic")
  assert(topics.all(topic => type(topic) == str and topic in topic-registry),
    message: "exercise " + id + " contains an unknown topic")
  assert(type(difficulty) in (int, float) and difficulty >= 1 and difficulty <= 5
    and difficulty * 4 == calc.round(difficulty * 4),
    message: "exercise " + id + " difficulty must be 1–5 in 0.25 increments")
  let _source = validate-source(source, "exercise " + id)
  assert(type(hints) == array, message: "exercise " + id + " hints must be an array")
  assert(extra == none or type(extra) == content,
    message: "exercise " + id + " extra must be content or none")
  assert(solution == none or type(solution) == content,
    message: "exercise " + id + " solution must be content or none")
  assert(status in ("draft", "published"),
    message: "exercise " + id + " status must be draft or published")

  if figure != none {
    assert(type(figure) == dictionary,
      message: "exercise " + id + " figure must be a dictionary or none")
    let path = _required(figure, "path", "figure for " + id)
    let alt = _required(figure, "alt", "figure for " + id)
    assert(type(path) == str and path.trim() != "" and not path.starts-with("/"),
      message: "figure path for " + id + " must be repository-relative")
    assert(type(alt) == str and alt.trim() != "",
      message: "figure alt text for " + id + " is required")
  }
  item
}

#let exercise(
  serial: none,
  title: none,
  statement_parts: none,
  topics: none,
  difficulty: none,
  figure: none,
  source: none,
  hints: (),
  extra: none,
  solution: none,
  status: "draft",
) = validate-exercise((
  id: exercise-id(serial),
  serial: serial,
  emojis: emoji-signature(serial),
  title: title,
  statement_parts: statement_parts,
  topics: topics,
  difficulty: difficulty,
  figure: figure,
  source: source,
  hints: hints,
  extra: extra,
  solution: solution,
  status: status,
))

#let selection(
  id: none,
  title: none,
  date: none,
  year: none,
  purpose: "response",
  listed: true,
  exercises: none,
) = (
  id: id,
  title: title,
  date: date,
  year: year,
  purpose: purpose,
  listed: listed,
  exercises: exercises,
)

#let published-exercises(exercises) = exercises.filter(it => it.status == "published")

#let find-selection(selections, id) = {
  let matches = selections.filter(it => it.id == id)
  assert(matches.len() == 1, message: "unknown or duplicate selection `" + id + "`")
  matches.first()
}

#let memberships(selections, item) = selections.filter(sel =>
  sel.listed and sel.exercises.any(candidate => candidate.id == item.id))

#let validate-catalog(
  exercises,
  selections,
  expected-published: none,
  expected-selections: none,
) = {
  assert(type(exercises) == array, message: "catalogue exercises must be an array")
  assert(type(selections) == array, message: "catalogue selections must be an array")
  let serials = ()
  let ids = ()
  let emoji-signatures = ()
  let published = 0
  for item in exercises {
    let _validated = validate-exercise(item)
    assert(not serials.contains(item.serial), message: "duplicate exercise serial " + str(item.serial))
    assert(not ids.contains(item.id), message: "duplicate exercise id `" + item.id + "`")
    let emoji-key = item.emojis.join("|")
    assert(not emoji-signatures.contains(emoji-key),
      message: "emoji signature collision for exercise " + item.id + ": " + item.emojis.join(" "))
    serials.push(item.serial)
    ids.push(item.id)
    emoji-signatures.push(emoji-key)
    if item.status == "published" { published += 1 }
  }
  assert(serials == serials.sorted(), message: "exercises must be ordered by serial")

  let selection-ids = ()
  for sel in selections {
    assert(type(sel) == dictionary, message: "selection must be a dictionary")
    assert(type(sel.id) == str and sel.id.match(regex("^[a-z][a-z0-9-]*$")) != none,
      message: "invalid selection id")
    assert(not selection-ids.contains(sel.id), message: "duplicate selection `" + sel.id + "`")
    selection-ids.push(sel.id)
    assert(has-content(sel.title), message: "selection " + sel.id + " needs a title")
    assert(sel.purpose in ("response", "cards"), message: "invalid selection purpose")
    assert(type(sel.listed) == bool, message: "selection listed must be boolean")
    assert(type(sel.exercises) == array, message: "selection exercises must be an array")
    let member-ids = ()
    for item in sel.exercises {
      assert(ids.contains(item.id), message: "selection " + sel.id + " references unknown exercise")
      assert(item.status == "published", message: "selection " + sel.id + " references a draft")
      assert(not member-ids.contains(item.id), message: "duplicate exercise in selection " + sel.id)
      member-ids.push(item.id)
    }
    if sel.purpose == "response" {
      assert(sel.exercises.len() >= 4 and sel.exercises.len() <= 8,
        message: "response selection " + sel.id + " needs four to eight exercises")
    }
  }
  if expected-published != none {
    assert(published == expected-published,
      message: "expected " + str(expected-published) + " published exercises, found " + str(published))
  }
  if expected-selections != none {
    assert(selections.len() == expected-selections,
      message: "expected " + str(expected-selections) + " selections, found " + str(selections.len()))
  }
  (exercises: exercises.len(), selections: selections.len(), published: published)
}
