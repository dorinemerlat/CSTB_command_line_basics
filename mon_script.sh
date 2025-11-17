#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Example robust script: prints a variable (with default), creates a directory and prints its path
: "${my_var:=default_value}"
echo "${my_var}"

mkdir -p "nouveau_dossier"
cd "nouveau_dossier" || exit 1

pwd