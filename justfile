set shell := ["bash", "-euo", "pipefail", "-c"]

python := env_var_or_default("PYTHON", "python3")
validation_profile := env_var_or_default("NUMA_PROFILE", "pilot")

default:
    @just --list

# Download the pinned Typst binary into .tools/ for systems without Typst 0.15.1.
setup:
    "{{python}}" scripts/install_typst.py

# Create one safe draft file; prompts for missing values.
new-exercise serial="":
    "{{python}}" scripts/new_exercise.py "{{serial}}"

# Watch the Typst bundle and serve dist/ locally.
preview host="127.0.0.1" port="8000":
    "{{python}}" scripts/preview.py --host "{{host}}" --port "{{port}}"

# Build the complete Typst HTML/PDF bundle into dist/.
build:
    "{{python}}" scripts/build.py

# Compile the current teacher card batch.
print-cards:
    "{{python}}" scripts/compile_print.py cards

# Compile one persistent response selection.
print-response selection="s03":
    "{{python}}" scripts/compile_print.py response "{{selection}}"

# Build, then run all read-only checks. Use `just check full` for the 13-session target.
check profile=validation_profile:
    "{{python}}" scripts/build.py --profile "{{profile}}"
    "{{python}}" scripts/compile_print.py cards
    "{{python}}" scripts/compile_print.py response s03
    "{{python}}" scripts/check.py --profile "{{profile}}"
