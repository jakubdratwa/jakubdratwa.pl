#!/bin/bash
# Otwiera tę stronę w Safari — bez serwera, bez wpisywania localhost.
# Działa z tej lokalizacji, nawet jeśli przeniesiesz cały folder.

cd "$(dirname "$0")" || exit 1
if [ ! -f "index.html" ]; then
  echo "Brak pliku index.html w tym folderze."
  read -r
  exit 1
fi
open -a Safari "$(pwd)/index.html"
