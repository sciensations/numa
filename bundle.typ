#import "content/catalog.typ": exercises, selections
#import "lib/model.typ": find-selection, has-content, memberships, validate-catalog
#import "templates/site.typ": base-url, exercise-page, index-page, not-found-page

#let build-profile = sys.inputs.at("profile", default: "pilot")
#assert(build-profile in ("pilot", "full"), message: "profile must be pilot or full")
#let expected-published = if build-profile == "full" { 77 } else { 6 }
#let expected-selections = if build-profile == "full" { 13 } else { 1 }
#let catalog-stats = validate-catalog(
  exercises,
  selections,
  expected-published: expected-published,
  expected-selections: expected-selections,
)

#if build-profile == "pilot" {
  let s03 = find-selection(selections, "s03")
  let pilot-exercises = exercises.filter(item => item.status == "published")
  assert(s03.exercises.len() == 6, message: "pilot requires six exercises in S03")
  assert(pilot-exercises.map(it => it.id) == ("3009ac", "e09805", "9df8b0", "402f01", "25ecd7", "bb6cb4"),
    message: "pilot exercise ID mapping changed")
}

#let active-exercises = exercises.filter(it => it.status == "published")

// Static site assets. Print PDFs remain teacher-only Typst entrypoints.
#for path in (
  "assets/site.css",
  "assets/site.js",
  "assets/brand/numa-logo.png",
  "assets/fonts/AtkinsonHyperlegibleNext-Regular.woff2",
  "assets/fonts/AtkinsonHyperlegibleNext-Bold.woff2",
  "assets/fonts/OFL.txt",
) {
  asset(path, read(path, encoding: none))
}
#asset("robots.txt", read("assets/robots.txt", encoding: none))

#let figure-paths = ()
#for item in active-exercises {
  if item.figure != none and not figure-paths.contains(item.figure.path) {
    figure-paths.push(item.figure.path)
  }
}
#for path in figure-paths { asset(path, read(path, encoding: none)) }

#let content-status = (
  exercises: catalog-stats.exercises,
  selections: catalog-stats.selections,
  published: catalog-stats.published,
  hints: active-exercises.filter(it => has-content(it.hints)).len(),
  extra: active-exercises.filter(it => has-content(it.extra)).len(),
  solutions: active-exercises.filter(it => has-content(it.solution)).len(),
  ids: active-exercises.map(it => it.id),
  emoji_signatures: active-exercises.map(it => it.emojis),
)
#asset("content-status.json", bytes(json.encode(content-status, pretty: true)))

#document(
  "index.html",
  title: [Exercices Numa],
  description: [Bibliothèque d’exercices Numa.],
  date: none,
)[
  #index-page(active-exercises, selections)
]

#for item in active-exercises {
  document(
    "e/" + item.id + ".html",
    title: item.title,
    description: [Énoncé de l’exercice #upper(item.id).],
    date: none,
  )[
    #exercise-page(selections, item)
  ]
}

#document(
  "404.html",
  title: [Page introuvable],
  description: [Cette page Numa n’existe pas ou a été déplacée.],
  date: none,
)[
  #not-found-page()
]

#let sitemap-urls = (base-url + "/index.html",)
#for item in active-exercises { sitemap-urls.push(base-url + "/e/" + item.id + ".html") }
#let sitemap = (
  "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
    + "<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">\n"
    + sitemap-urls.map(url => "  <url><loc>" + url + "</loc></url>\n").join()
    + "</urlset>\n"
)
#asset("sitemap.xml", bytes(sitemap))
