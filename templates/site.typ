#import "../lib/logo.typ": numa-logo-html
#import "../lib/model.typ": has-content, memberships, source-attribution, topic-label, topic-registry

#let base-url = "https://lcnbr.github.io/numa"

#let _a(href, body, class: none) = {
  let attrs = (href: href)
  if class != none { attrs.insert("class", class) }
  html.elem("a", attrs: attrs, body)
}

#let _shell(title, description, root-prefix: "", filters: false, body) = {
  html.elem("html", attrs: (lang: "fr"))[
    #html.elem("head")[
      #html.elem("meta", attrs: (charset: "utf-8"))
      #html.elem("meta", attrs: (name: "viewport", content: "width=device-width, initial-scale=1"))
      #html.elem("meta", attrs: (name: "description", content: description))
      #html.elem("title")[#title · Numa]
      #html.elem("link", attrs: (rel: "stylesheet", href: root-prefix + "assets/site.css"))
      #if filters { html.elem("script", attrs: (src: root-prefix + "assets/site.js", defer: "")) }
    ]
    #html.elem("body")[
      #html.elem("header", attrs: (class: "site-header"))[
        #html.elem("div", attrs: (class: "site-header__inner"))[
          #_a(root-prefix + "index.html", [
            #numa-logo-html(width: 38mm)
          ], class: "brand-link")
          #html.elem("span", attrs: (class: "tagline"))[Cherche, teste, explique !]
        ]
      ]
      #html.elem("main", attrs: (class: "site-main"))[#body]
      #html.elem("footer", attrs: (class: "site-footer"))[
        Bibliothèque d’exercices Numa · Neuchâtel
      ]
    ]
  ]
}

#let _difficulty-label(value) = str(value).replace(".", ",") + " / 5"

#let _option(value, label, selected: false) = {
  let attrs = (value: value)
  if selected { attrs.insert("selected", "") }
  html.elem("option", attrs: attrs)[#label]
}

#let index-page(exercises, selections) = {
  let published = exercises.filter(it => it.status == "published")
  let organizations = published.map(it => it.source.organization).dedup().sorted()
  let listed-selections = selections.filter(it => it.listed)
  _shell(
    [Exercices],
    "Bibliothèque d’exercices Numa avec énoncés, indices et solutions lorsqu’ils sont disponibles.",
    filters: true,
  )[
    #html.elem("section", attrs: (class: "hero"))[
      #html.elem("p", attrs: (class: "eyebrow"))[Bibliothèque Numa]
      #html.elem("h1")[Un grand terrain de problèmes]
      #html.elem("p", attrs: (class: "lead"))[
        Explore les exercices indépendamment des séances. Filtre-les, retrouve un énoncé après l’activité et ouvre les indices ou solutions lorsqu’ils sont prêts.
      ]
    ]

    #html.elem("section", attrs: (class: "catalog-section", aria-labelledby: "catalog-title"))[
      #html.elem("div", attrs: (class: "catalog-heading"))[
        #html.elem("h2", attrs: (id: "catalog-title"))[Tous les exercices]
        #html.elem("p", attrs: (id: "result-count", class: "result-count", aria-live: "polite"))[
          #published.len() exercices
        ]
      ]

      #html.elem("form", attrs: (id: "catalog-filters", class: "filters", role: "search"))[
        #html.elem("div", attrs: (class: "filter filter--search"))[
          #html.elem("label", attrs: ("for": "filter-search"))[Rechercher]
          #html.elem("input", attrs: (
            id: "filter-search",
            name: "q",
            type: "search",
            placeholder: "Titre, source, identifiant…",
            autocomplete: "off",
          ))
        ]
        #html.elem("div", attrs: (class: "filter"))[
          #html.elem("label", attrs: ("for": "filter-topic"))[Thème]
          #html.elem("select", attrs: (id: "filter-topic", name: "topic"))[
            #_option("", [Tous les thèmes])
            #for (slug, label) in topic-registry.pairs() {
              _option(slug, label)
            }
          ]
        ]
        #html.elem("div", attrs: (class: "filter"))[
          #html.elem("label", attrs: ("for": "filter-min"))[Difficulté min.]
          #html.elem("select", attrs: (id: "filter-min", name: "min"))[
            #for quarter in range(4, 21) {
              let value = quarter / 4
              _option(str(value), _difficulty-label(value), selected: quarter == 4)
            }
          ]
        ]
        #html.elem("div", attrs: (class: "filter"))[
          #html.elem("label", attrs: ("for": "filter-max"))[Difficulté max.]
          #html.elem("select", attrs: (id: "filter-max", name: "max"))[
            #for quarter in range(4, 21) {
              let value = quarter / 4
              _option(str(value), _difficulty-label(value), selected: quarter == 20)
            }
          ]
        ]
        #html.elem("div", attrs: (class: "filter"))[
          #html.elem("label", attrs: ("for": "filter-source"))[Source]
          #html.elem("select", attrs: (id: "filter-source", name: "source"))[
            #_option("", [Toutes les sources])
            #for organization in organizations { _option(organization, organization) }
          ]
        ]
        #html.elem("div", attrs: (class: "filter"))[
          #html.elem("label", attrs: ("for": "filter-selection"))[Utilisé dans]
          #html.elem("select", attrs: (id: "filter-selection", name: "selection"))[
            #_option("", [Toutes les sélections])
            #for selection in listed-selections { _option(selection.id, [#upper(selection.id) · #selection.title]) }
          ]
        ]
        #html.elem("button", attrs: (type: "reset", class: "button button--secondary"))[Effacer les filtres]
      ]

      #html.elem("p", attrs: (id: "no-results", class: "no-results", hidden: ""))[
        Aucun exercice ne correspond à ces filtres.
      ]
      #html.elem("ul", attrs: (id: "exercise-catalog", class: "exercise-grid"))[
        #for item in published {
          let used-in = memberships(selections, item)
          html.elem("li", attrs: (
            class: "catalog-card",
            "data-id": item.id,
            "data-topics": item.topics.join(" "),
            "data-difficulty": str(item.difficulty),
            "data-source": item.source.organization,
            "data-selections": used-in.map(it => it.id).join(" "),
          ))[
            #_a("e/" + item.id + ".html", [
              #html.elem("span", attrs: (class: "catalog-card__id"))[ID #upper(item.id)]
              #html.elem("strong", attrs: (class: "catalog-card__title"))[#item.title]
              #html.elem("span", attrs: (class: "catalog-card__meta"))[
                Niveau #_difficulty-label(item.difficulty) · #item.source.organization #item.source.year
              ]
              #html.elem("span", attrs: (class: "chip-row"))[
                #for topic in item.topics {
                  html.elem("span", attrs: (class: "chip"))[#topic-label(topic)]
                }
              ]
            ])
          ]
        }
      ]
    ]
  ]
}

#let _disclosure(label, value, class: "disclosure") = {
  let disclosure-body = if type(value) == array {
    html.elem("ul")[
      #for item in value { if has-content(item) { html.elem("li")[#item] } }
    ]
  } else { value }
  html.elem("details", attrs: (class: class))[
    #html.elem("summary")[#label]
    #html.elem("div", attrs: (class: "disclosure__body"))[#disclosure-body]
  ]
}

#let exercise-page(selections, item) = {
  let parts = item.statement_parts
  let used-in = memberships(selections, item)
  _shell(
    item.title,
    "Énoncé de l’exercice " + upper(item.id) + " de Numa.",
    root-prefix: "../",
  )[
    #html.elem("nav", attrs: (class: "breadcrumbs", aria-label: "Fil d’Ariane"))[
      #_a("../index.html", [Catalogue]) #sym.arrow.r ID #upper(item.id)
    ]
    #html.elem("article", attrs: (class: "exercise-page"))[
      #html.elem("header", attrs: (class: "page-heading"))[
        #html.elem("p", attrs: (class: "eyebrow"))[ID #upper(item.id)]
        #html.elem("h1")[#item.title]
        #html.elem("div", attrs: (class: "metadata-row"))[
          #html.elem("span", attrs: (class: "metadata-pill"))[Niveau #_difficulty-label(item.difficulty)]
          #for topic in item.topics {
            html.elem("span", attrs: (class: "metadata-pill"))[#topic-label(topic)]
          }
        ]
        #if used-in.len() > 0 {
          html.elem("p", attrs: (class: "membership-row"))[
            Utilisé dans :
            #for selection in used-in {
              _a("../index.html?selection=" + selection.id, upper(selection.id), class: "selection-chip")
            }
          ]
        }
      ]
      #html.elem("section", attrs: (class: "statement"))[
        #for (index, part) in parts.enumerate() {
          if index > 0 { html.elem("h2", attrs: (class: "continuation"))[Suite] }
          html.elem("div", attrs: (class: "statement__part"))[#part]
          if index == 0 and item.figure != none {
            html.elem("figure", attrs: (class: "exercise-figure"))[
              #html.elem("img", attrs: (
                src: "../" + item.figure.path,
                alt: item.figure.alt,
                loading: "lazy",
              ))
              #let caption = item.figure.at("caption", default: none)
              #if has-content(caption) { html.elem("figcaption")[#caption] }
            ]
          }
        }
      ]
      #html.elem("p", attrs: (class: "source"))[#source-attribution(item.source)]
      #if has-content(item.hints) { _disclosure([Indices], item.hints) }
      #if has-content(item.extra) { _disclosure([Pour aller plus loin], item.extra) }
      #if has-content(item.solution) {
        _disclosure([Voir la solution], item.solution, class: "disclosure disclosure--solution")
      }
      #html.elem("nav", attrs: (class: "exercise-nav", aria-label: "Navigation des exercices"))[
        #_a("../index.html", [Retour au catalogue], class: "button button--secondary")
      ]
    ]
  ]
}

#let not-found-page() = _shell(
  [Page introuvable],
  "Cette page Numa n’existe pas ou a été déplacée.",
  root-prefix: base-url + "/",
)[
  #html.elem("section", attrs: (class: "hero hero--compact"))[
    #html.elem("p", attrs: (class: "eyebrow"))[Erreur 404]
    #html.elem("h1")[Page introuvable]
    #html.elem("p", attrs: (class: "lead"))[Ce lien ne correspond à aucun exercice publié.]
    #_a(base-url + "/index.html", [Voir le catalogue], class: "button")
  ]
]
