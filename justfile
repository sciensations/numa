set shell := ["bash", "-euo", "pipefail", "-c"]

typst := env_var_or_default("TYPST", "typst")
validation_profile := env_var_or_default("NUMA_PROFILE", "pilot")

default:
    @just --list

# Create one safe draft file and refresh the static Typst registry.
new-exercise serial="":
    "./tools/new-exercise" "{{serial}}"

# Regenerate the static Typst registry from content/exercises/*.typ.
registry:
    "./tools/registry"

# Fail if the committed registry does not match the numbered files.
registry-check:
    "./tools/registry" --check

# Watch and serve the website with Typst's native live reload.
preview port="3000":
    "./tools/registry" --check
    "{{typst}}" watch --features html,bundle --format bundle --font-path assets/fonts --ignore-system-fonts --input profile="{{validation_profile}}" --root . --port "{{port}}" bundle.typ dist

# Build the complete Typst website bundle into dist/.
build profile=validation_profile:
    "./tools/registry" --check
    rm -rf dist
    "{{typst}}" compile --features html,bundle --format bundle --font-path assets/fonts --ignore-system-fonts --input profile="{{profile}}" --root . bundle.typ dist

# Compile the current teacher card batch.
print-cards:
    mkdir -p output/pdf
    "{{typst}}" compile --root . --font-path assets/fonts --ignore-system-fonts teacher/cards.typ output/pdf/card-batch.pdf

# Compile one persistent response selection.
print-response selection="s03":
    mkdir -p output/pdf
    "{{typst}}" compile --root . --font-path assets/fonts --ignore-system-fonts "teacher/responses/{{selection}}.typ" "output/pdf/{{selection}}-responses.pdf"

# Compile the site, card batch, and every stored response selection.
check profile=validation_profile:
    "./tools/registry" --check
    rm -rf dist
    "{{typst}}" compile --features html,bundle --format bundle --font-path assets/fonts --ignore-system-fonts --input profile="{{profile}}" --root . bundle.typ dist
    mkdir -p output/pdf
    "{{typst}}" compile --root . --font-path assets/fonts --ignore-system-fonts teacher/cards.typ output/pdf/card-batch.pdf
    for source in teacher/responses/*.typ; do selection="$(basename "$source" .typ)"; "{{typst}}" compile --root . --font-path assets/fonts --ignore-system-fonts "$source" "output/pdf/$selection-responses.pdf"; done
