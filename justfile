set shell := ["bash", "-euo", "pipefail", "-c"]

typst := env_var_or_default("TYPST", "typst")

default:
    @just --list

# Watch and serve the website with Typst's native live reload.
preview port="3000":
    "{{typst}}" watch --features html,bundle --format bundle --font-path assets/fonts --ignore-system-fonts --root . --port "{{port}}" bundle.typ dist

# Build the complete Typst website bundle into dist/.
build:
    rm -rf dist
    "{{typst}}" compile --features html,bundle --format bundle --font-path assets/fonts --ignore-system-fonts --root . bundle.typ dist

# Compile the current teacher card batch.
print-cards:
    mkdir -p output/pdf
    "{{typst}}" compile --root . --font-path assets/fonts --ignore-system-fonts teacher/cards.typ output/pdf/card-batch.pdf

# Compile one persistent response selection.
print-response selection="s03":
    mkdir -p output/pdf
    "{{typst}}" compile --root . --font-path assets/fonts --ignore-system-fonts "teacher/responses/{{selection}}.typ" "output/pdf/{{selection}}-responses.pdf"

# Compile the site, card batch, and every stored response selection.
check:
    rm -rf dist
    "{{typst}}" compile --features html,bundle --format bundle --font-path assets/fonts --ignore-system-fonts --root . bundle.typ dist
    mkdir -p output/pdf
    "{{typst}}" compile --root . --font-path assets/fonts --ignore-system-fonts teacher/cards.typ output/pdf/card-batch.pdf
    for source in teacher/responses/*.typ; do selection="$(basename "$source" .typ)"; "{{typst}}" compile --root . --font-path assets/fonts --ignore-system-fonts "$source" "output/pdf/$selection-responses.pdf"; done
